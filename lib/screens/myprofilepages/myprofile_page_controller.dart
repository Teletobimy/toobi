import 'package:flutter/material.dart';
import 'package:test01/screens/main_screen.dart';
import 'package:test01/screens/myprofilepages/profile_pages/main_profile_page1.dart';
import 'package:test01/screens/myprofilepages/profile_pages/main_profile_page2.dart';
import 'package:test01/screens/myprofilepages/profile_pages/main_profile_page3.dart';
import 'package:test01/screens/setting/colors.dart';

class MyprofilePageController extends StatefulWidget {
  const MyprofilePageController({super.key});

  @override
  State<MyprofilePageController> createState() => _CalendarState();
}

int _selectedIndex = 0;

class _CalendarState extends State<MyprofilePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3),
            label: '내프로필',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_sharp),
            label: '업적',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped2,
      ),
    );
  }

  void _onItemTapped2(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

const List<Widget> _widgetOptions = <Widget>[
  MainProfilePage1(),
  MainProfilePage2(),
  MainProfilePage3(),
];
