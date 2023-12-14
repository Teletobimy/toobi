import 'package:flutter/material.dart';
import 'package:test01/screens/group_screen/group_screens/chat_screen/screens/chat_screen.dart';
import 'package:test01/screens/group_screen/group_screens/group_page_calendar.dart';
import 'package:test01/screens/group_screen/group_screens/group_page_main.dart';
import 'package:test01/screens/main_screen.dart';
import 'package:test01/screens/setting/colors.dart';

class GroupPageControll extends StatefulWidget {
  const GroupPageControll({super.key});

  @override
  State<GroupPageControll> createState() => _CalendarState();
}

int _selectedIndex = 0;

class _CalendarState extends State<GroupPageControll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '모임홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '모임일정',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
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
  GroupMainPage(),
  GroupCalander(),
  ChatScreen(),
];
