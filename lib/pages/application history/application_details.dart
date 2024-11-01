import 'package:flutter/material.dart';

class ApplicationDetailsPage extends StatelessWidget {
  final String applicantName;
  final String applicantId;
  final String serviceApplied;
  final String applicationNumber;
  final String applicationStatus;
  final String drivingTestCode;
  final String district;
  final String sector;
  final String amountPaid;

  const ApplicationDetailsPage({
    super.key,
    required this.applicantName,
    required this.applicantId,
    required this.serviceApplied,
    required this.applicationNumber,
    required this.applicationStatus,
    required this.drivingTestCode,
    required this.district,
    required this.sector,
    required this.amountPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Application Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTile(
              title: 'Applicant Name :',
              titleValue: applicantName,
            ),
            _buildListTile(
              title: 'Applicant ID :',
              titleValue: applicantId,
            ),
            _buildListTile(
              title: 'Service Applied :',
              titleValue: serviceApplied,
            ),
            _buildListTile(
              title: 'Application Number :',
              titleValue: applicationNumber,
            ),
            _buildListTile(
              title: 'Application Status :',
              titleValue: applicationStatus,
              titleStyle: TextStyle(
                color: _getStatusColor(applicationStatus),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            if (drivingTestCode != null && drivingTestCode.trim().isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Driving Test Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Driving Test Code: $drivingTestCode',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            if ((district != null && district.isNotEmpty) ||
                (sector != null && sector.isNotEmpty))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Processing Office Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 1),
                  if (district.isNotEmpty)
                    _buildListTile(
                      title: 'District',
                      titleValue: district,
                    ),
                  if (sector.isNotEmpty) const SizedBox(height: 1),
                  if (sector.isNotEmpty)
                    _buildListTile(
                      title: 'Sector',
                      titleValue: sector,
                    ),
                ],
              ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                _buildListTile(
                  title: 'Amount Paid',
                  titleValue: amountPaid,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Color(0xFF1DAB61);
      case 'Submitted':
        return Color(0xFF2684FF);
      case 'Payment Expired':
        return Color(0xFFDF1F07);
      default:
        return Colors.grey;
    }
  }

  Widget _buildListTile({
    required String title,
    required String titleValue,
    TextStyle? titleStyle,
  }) {
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: Color(0xFF475467),
            ),
          ),
          Flexible(
            child: Text(
              titleValue,
              overflow: TextOverflow.ellipsis,
              style: titleStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1D1D1D),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
