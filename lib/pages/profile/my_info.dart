import 'package:flutter/material.dart';

class MyInfo extends StatelessWidget {
  MyInfo({super.key});

  final Map<String, dynamic> _data = {
    'Name': 'ISIMBI RUGEMA Paradis',
    'Identity card': '110000000000000',
    'Username': 'paradis isimbi',
    'Gender': 'Female',
    'Birth date': '1999-12-12',
    'Email Address': 'p.isimbi@me.com',
    'ID place of issue': 'Nyarugenge/Kigali',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: _data.entries
              .map((entry) => _buildListTile(
                    title: entry.key,
                    titleValue: entry.value.toString(),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

Widget _buildListTile({
  required String title,
  required String titleValue,
}) {
  return ListTile(
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xFF475467),
          ),
        ),
        Text(
          titleValue,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1D1D1D)
          ),
        ),
      ],
    ),
  );
}
