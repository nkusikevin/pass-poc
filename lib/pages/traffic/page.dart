import 'package:flutter/material.dart';
import 'package:ipass_poc/components/traffic_fines_card.dart';

class TrafficFines extends StatefulWidget {
  const TrafficFines({super.key});

  @override
  State<TrafficFines> createState() => _TrafficFinesState();
}

class _TrafficFinesState extends State<TrafficFines> {
  List<String> selectedFinesIds = [];
  double totalAmount = 0;

  void _handleFineSelection(String fineId, bool isSelected, double amount) {
    setState(() {
      if (isSelected) {
        if (!selectedFinesIds.contains(fineId)) {
          selectedFinesIds.add(fineId);
          totalAmount += amount;
        }
      } else {
        selectedFinesIds.remove(fineId);
        totalAmount -= amount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic Fines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select all traffic fines you'd like to pay",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TrafficFinesCard(
                    offense: 'Over Speeding',
                    vehicleNumber: 'RAD 123 A',
                    amount: 25000,
                    dueDate: DateTime(2024, 01, 30, 20, 0),
                    dateTime: DateTime(2024, 01, 25, 20, 0),
                    speed: 60,
                    location: 'Nyarutarama, Green Hills Academy',
                    imageUrl: 'assets/images/car.jpg',
                    fineId: 'fine_$index',
                    isSelected: selectedFinesIds.contains('fine_$index'),
                    onSelected: _handleFineSelection,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Paying with :',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '0780 000 000',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            TextButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(13),
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: selectedFinesIds.isNotEmpty ? Colors.purple : Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Pay ${totalAmount.toStringAsFixed(0)} RWF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
