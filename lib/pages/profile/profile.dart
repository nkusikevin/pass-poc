import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ipass_poc/pages/profile/my_info.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24.0),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24.0),
          _buildListTile(
            icon: CupertinoIcons.person,
            title: 'My Infromation',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MyInfo()),
              );
            },
          ),
          _buildListTile(
            icon: CupertinoIcons.car_detailed,
            title: 'My Cars',
            onTap: () {},
          ),
          _buildListTile(
            icon: CupertinoIcons.tray_arrow_down,
            title: 'Application History',
            onTap: () {},
          ),
          _buildListTile(
            icon: FontAwesomeIcons.handHoldingDollar,
            title: 'Payment History',
            onTap: () {},
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildListTile(
            icon: FontAwesomeIcons.wallet,
            title: 'Payment Methods',
            onTap: () {},
          ),
          _buildListTile(
            icon: CupertinoIcons.lock,
            title: 'Privacy & Security',
            onTap: () {},
          ),
          const SizedBox(height: 24.0),
          const Text(
            'General',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildListTile(
            icon: Icons.language,
            title: 'Language',
            onTap: () {},
          ),
          _buildListTile(
            icon: CupertinoIcons.question_circle,
            title: 'Help',
            onTap: () {},
          ),
          const Spacer(),
          _buildListTile(
            icon: Icons.logout,
            title: 'Logout',
            textColor: Colors.red,
            onTap: () {},
          ),
          const SizedBox(height: 8.0),
          const Center(
            child: Text(
              'Version 1.0',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: textColor, size: 24.0),
          title: Text(
            title,
            style: TextStyle(color: textColor),
          ),
          trailing: title != 'Logout'
              ? const Icon(CupertinoIcons.right_chevron, color: Colors.grey)
              : null,
          onTap: onTap,
        ),
        if (title != 'Help' &&
            title != 'Logout' &&
            title != 'Payment History' &&
            title != 'Privacy & Security')
          Row(
            children: [
              const SizedBox(width: 56.0),
              Expanded(
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(width: 24.0),
            ],
          ),
      ],
    );
  }
}
