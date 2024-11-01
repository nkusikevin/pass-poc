import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentHistoryItem {
  final String title;
  final String amount;
  final DateTime date;

  PaymentHistoryItem({
    required this.title,
    required this.amount,
    required this.date,
  });

  factory PaymentHistoryItem.fromJson(Map<String, dynamic> json) {
    // Parse the date string from dd/MM/yyyy hh:mma format
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mma');
    final DateTime parsedDate = formatter.parse(json['date'].toString());

    return PaymentHistoryItem(
      title: json['title'] ?? '',
      amount: json['amount']?.toString() ?? '',
      date: parsedDate,
    );
  }

  String get formattedDate {
    return DateFormat('dd/MM/yyyy hh:mm a').format(date);
  }
}

class PaymentHistory extends StatelessWidget {
  PaymentHistory({
    super.key,
  });

  final List<Map<String, String>> payments = [
    {"title": "Traffic Fine", "amount": "25,000", "date": "01/11/2024 11:00PM"},
    {"title": "Traffic Fine", "amount": "25,000", "date": "25/01/2024 11:00PM"},
    {
      "title": "Birth Certificate",
      "amount": "500",
      "date": "25/01/2024 11:00PM"
    },
    {"title": "Traffic Fine", "amount": "25,000", "date": "25/01/2024 11:00PM"},
    {"title": "Traffic Fine", "amount": "25,000", "date": "25/01/2024 11:00PM"},
    {"title": "Traffic Fine", "amount": "25,000", "date": "31/10/2024 11:00PM"}
  ];

  Map<String, List<PaymentHistoryItem>> _groupPaymentsByDate() {
    final Map<String, List<PaymentHistoryItem>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var payment in payments) {
      try {
        final paymentItem = PaymentHistoryItem.fromJson(payment);
        final paymentDate = DateTime(
          paymentItem.date.year,
          paymentItem.date.month,
          paymentItem.date.day,
        );

        String key;
        if (paymentDate.isAtSameMomentAs(today)) {
          key = 'Today';
        } else if (paymentDate.isAtSameMomentAs(yesterday)) {
          key = 'Yesterday';
        } else {
          key = DateFormat('MMM dd, yyyy').format(paymentDate);
        }

        grouped.putIfAbsent(key, () => []);
        grouped[key]!.add(paymentItem);
      } catch (e) {
        debugPrint('Error parsing payment: $e');
        // Skip invalid dates instead of crashing
        continue;
      }
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedPayments = _groupPaymentsByDate();
    final sortedDates = groupedPayments.keys.toList()
      ..sort((a, b) {
        if (a == 'Today') return -1;
        if (b == 'Today') return 1;
        if (a == 'Yesterday') return -1;
        if (b == 'Yesterday') return 1;
        return b.compareTo(a); // Sort other dates in descending order
      });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment history',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Color(0xFFF4F4F4),
                  hintStyle: const TextStyle(fontSize: 14),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    borderSide: BorderSide.none, // Remove border
                  ),
                ),
              )),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                final date = sortedDates[index];
                final datePayments = groupedPayments[date]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: date),
                    ...datePayments.map((payment) => PaymentHistoryCard(
                          title: payment.title,
                          amount: payment.amount,
                          date: payment.formattedDate,
                        )),
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class PaymentHistoryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String date;

  const PaymentHistoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1D1D1D1A)),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Text(
              '$amount RWF',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
