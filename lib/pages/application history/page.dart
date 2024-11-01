import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ipass_poc/components/no_data_found.dart';

import 'application_details.dart';

class ApplicationHistoryItem {
  final String applicantName;
  final String serviceApplied;
  final String applicationNumber;
  final String applicationStatus;
  final String amountPaid;
  final DateTime date;
  final String applicantId;
  final String? drivingTestCode;
  final String? district;
  final String? sector;

  ApplicationHistoryItem({
    required this.applicantName,
    required this.serviceApplied,
    required this.applicationNumber,
    required this.applicationStatus,
    required this.amountPaid,
    required this.date,
    required this.applicantId,
    this.drivingTestCode,
    this.district,
    this.sector,
  });

  factory ApplicationHistoryItem.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mma');
    final DateTime parsedDate = formatter.parse(json['date'].toString());

    return ApplicationHistoryItem(
        applicantName: json['applicantName'] ?? '',
        serviceApplied: json['serviceApplied'] ?? '',
        applicationNumber: json['applicationNumber'] ?? '',
        applicationStatus: json['applicationStatus'] ?? '',
        amountPaid: json['amountPaid'] ?? '',
        date: parsedDate,
        applicantId: json['applicantId'] ?? '',
        drivingTestCode: json['drivingTestCode'],
        district: json['district'],
        sector: json['sector']);
  }

  String get formattedDate {
    return DateFormat('dd/MM/yyyy hh:mm a').format(date);
  }
}

class ApplicationHistory extends StatefulWidget {
  const ApplicationHistory({super.key});

  @override
  _ApplicationHistoryState createState() => _ApplicationHistoryState();
}

class _ApplicationHistoryState extends State<ApplicationHistory> {
  List<ApplicationHistoryItem> _applications = [];
  List<ApplicationHistoryItem> _filteredApplications = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadApplications();
    _searchController.addListener(_filterApplications);
  }

  void _loadApplications() {
    final List<Map<String, dynamic>> rawApplications = [
      // {
      //   "applicantName": "ISIMBI R. PARADIS",
      //   "applicantId": "1100000000000000",
      //   "serviceApplied": "Birth Certificate",
      //   "applicationNumber": "B200811104622S3BA",
      //   "applicationStatus": "Approved",
      //   "processingOffice": "Legal Marriage Details",
      //   "district": "Nyarugenge",
      //   "sector": "Nyarugenge",
      //   "amountPaid": "500 RWF",
      //   "date": "01/11/2024 03:45PM"
      // },
      // {
      //   "applicantName": "ISIMBI R. PARADIS",
      //   "applicantId": "1100000000000000",
      //   "serviceApplied": "Registration for Driving Test - (Definitive)",
      //   "applicationNumber": "B200811104622S3BA",
      //   "applicationStatus": "Approved",
      //   "drivingTestCode": "NYG1601231401090032/P",
      //   "amountPaid": "10,000 RWF",
      //   "date": "28/02/2024 09:15AM"
      // },
      // {
      //   "applicantName": "JOHN DOE",
      //   "applicantId": "1100000000000001",
      //   "serviceApplied": "Birth Certificate",
      //   "applicationNumber": "B200811104622S3BC",
      //   "applicationStatus": "Payment Expired",
      //   "processingOffice": "Civil Registry",
      //   "district": "Kigali",
      //   "sector": "Gasabo",
      //   "amountPaid": "0 RWF",
      //   "date": "01/01/2024 11:59PM"
      // },
      // {
      //   "applicantName": "JANE SMITH",
      //   "applicantId": "1100000000000002",
      //   "serviceApplied": "Birth Certificate",
      //   "applicationNumber": "B200811104622S3BD",
      //   "applicationStatus": "Submitted",
      //   "processingOffice": "Civil Registry",
      //   "district": "Musanze",
      //   "sector": "Muhoza",
      //   "amountPaid": "0 RWF",
      //   "date": "25/01/2024 11:00PM"
      // }
    ];

    setState(() {
      _applications = rawApplications
          .map((app) => ApplicationHistoryItem.fromJson(app))
          .toList();
      _filteredApplications = _applications;
    });
  }

  void _filterApplications() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredApplications = _applications.where((application) {
        return application.applicantName.toLowerCase().contains(query) ||
            application.applicationNumber.toLowerCase().contains(query) ||
            application.serviceApplied.toLowerCase().contains(query) ||
            application.applicationStatus.toLowerCase().contains(query);
      }).toList();
    });
  }

  Map<String, List<ApplicationHistoryItem>> _groupApplicationsByDate() {
    final Map<String, List<ApplicationHistoryItem>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var application in _filteredApplications) {
      final applicationDate = DateTime(
        application.date.year,
        application.date.month,
        application.date.day,
      );

      String key;
      if (applicationDate.isAtSameMomentAs(today)) {
        key = 'Today';
      } else if (applicationDate.isAtSameMomentAs(yesterday)) {
        key = 'Yesterday';
      } else {
        key = DateFormat('MMM dd, yyyy').format(applicationDate);
      }

      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(application);
    }

    return grouped;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupedApplications = _groupApplicationsByDate();
    final sortedDates = groupedApplications.keys.toList()
      ..sort((a, b) {
        if (a == 'Today') return -1;
        if (b == 'Today') return 1;
        if (a == 'Yesterday') return -1;
        if (b == 'Yesterday') return 1;
        return b.compareTo(a);
      });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Application History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_applications.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search applications',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  hintStyle: const TextStyle(fontSize: 14),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          _filteredApplications.isEmpty
              ? const Expanded(
                  child: NoDataFound(
                  title: 'No Applications Found',
                  description:
                      'It looks like you don’t have any applications so far',
                ))
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: sortedDates.length,
                    itemBuilder: (context, index) {
                      final date = sortedDates[index];
                      final dateApplications = groupedApplications[date]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(title: date),
                          ...dateApplications
                              .map((application) => ApplicationHistoryCard(
                                    applicantName: application.applicantName,
                                    serviceApplied: application.serviceApplied,
                                    applicationStatus:
                                        application.applicationStatus,
                                    applicationNumber:
                                        application.applicationNumber,
                                    onTap: () =>
                                        _navigateToDetails(application),
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

  void _navigateToDetails(ApplicationHistoryItem application) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicationDetailsPage(
          applicantName: application.applicantName,
          applicantId: application.applicantId,
          serviceApplied: application.serviceApplied,
          applicationNumber: application.applicationNumber,
          applicationStatus: application.applicationStatus,
          drivingTestCode: application.drivingTestCode ?? '',
          district: application.district ?? '',
          sector: application.sector ?? '',
          amountPaid: application.amountPaid,
        ),
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
          color: Colors.grey,
        ),
      ),
    );
  }
}

class ApplicationHistoryCard extends StatelessWidget {
  final String applicantName;
  final String serviceApplied;
  final String applicationStatus;
  final String applicationNumber;
  final VoidCallback onTap;

  const ApplicationHistoryCard({
    super.key,
    required this.applicantName,
    required this.serviceApplied,
    required this.applicationStatus,
    required this.applicationNumber,
    required this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF1DAB61);
      case 'Submitted':
        return const Color(0xFF2684FF);
      case 'Payment Expired':
        return const Color(0xFFDF1F07);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF1D1D1D1A)),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      serviceApplied,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    applicationStatus,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _getStatusColor(applicationStatus),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                applicationNumber,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
