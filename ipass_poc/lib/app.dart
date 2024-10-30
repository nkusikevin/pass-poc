
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/home_page.dart';
import 'pages/profile.dart';
import 'pages/updates.dart';

class MyAppView extends StatefulWidget {
  MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const UpdatesPage(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),

        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.rectangle_grid_2x2_fill, size: 25),
              activeIcon:
                  Icon(CupertinoIcons.rectangle_grid_2x2_fill, size: 25),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(CupertinoIcons.chat_bubble_2, size: 30),
                  Positioned(
                    right: -10,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '4',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              activeIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(CupertinoIcons.chat_bubble_2_fill, size: 30),
                  Positioned(
                    right: -10,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              label: 'Updates',
            ),
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person, size: 25),
              activeIcon: Icon(CupertinoIcons.person_fill, size: 25),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
