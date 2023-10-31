import 'package:flutter/material.dart';
import 'package:test01/screens/main_screen2.dart';
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
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text("📚독서 한잔, 커피 한잔☕ "),
        centerTitle: true,
        // backgroundColor: TitleColor1,
        leading: Builder(
            builder: (BuildContext context) => IconButton(
                tooltip: "북쉐어링",
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu_book_sharp))),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen2(),
              ),
              (route) => false,
            ),
            icon: const Icon(Icons.home),
            style: ButtonStyle(iconSize: MaterialStateProperty.all(30)),
          ),
          const SizedBox(
            width: 13,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: TitleColor1,
              ),
              child: const Text(
                'Drawer Header2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages2'),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile2'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings2'),
            ),
          ],
        ),
      ),
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
