import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:test01/screens/else/group_register.dart';
import 'package:test01/screens/else/management.dart';
import 'package:test01/screens/group_screen/group_page_controller.dart';
import 'package:test01/screens/login_screen.dart';
import 'package:test01/screens/main_pages/feed_page.dart';
import 'package:test01/screens/myprofilepages/myprofile_page_controller.dart';
import 'package:test01/screens/setting/colors.dart';
import 'package:test01/temp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';

class LoginedScreen extends StatefulWidget {
  const LoginedScreen({super.key});

  @override
  State<LoginedScreen> createState() => _LoginedScreenState();
}

// int _selectedIndex = 0;

class _LoginedScreenState extends State<LoginedScreen> {
  final _authentication = FirebaseAuth.instance;

  User? loggedUser;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print("로그인 유저 정보 !! : $loggedUser");
        if (kDebugMode) {
          print(loggedUser!.email);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey[400],
        toolbarHeight: 32,
        // title: const Text(
        //   "📚독서 한잔, 커피 한잔☕ ",
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        // ),
        // centerTitle: true,
        // backgroundColor: PRIMATY_COLOR,
        leading: Builder(
            builder: (BuildContext context) => IconButton(
                tooltip: "메뉴",
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu))),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Management())),
              icon: Icon(Icons.manage_accounts)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 3,
        child: NavigationRail(
          destinations: <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.house_outlined),
              selectedIcon: Icon(Icons.house),
              label: Text("Home"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.diversity_1_outlined),
              selectedIcon: Icon(Icons.diversity_1_rounded),
              label: Text("그룹"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.forum_outlined),
              selectedIcon: Icon(Icons.forum_rounded),
              label: Text("채팅"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.face_3_outlined),
              selectedIcon: Icon(Icons.face_3),
              label: Text("프로필"),
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          useIndicator: true,
          labelType: NavigationRailLabelType.all,
          selectedLabelTextStyle: TextStyle(color: Colors.lightBlue[500]),
          unselectedLabelTextStyle: TextStyle(color: Colors.grey[500]),
          backgroundColor: Colors.grey[50],
          indicatorColor: Colors.cyan[50],
          minWidth: 40,
          leading: Container(
            width: 30,
            height: 40,
            color: Colors.red,
          ),
          trailing: GestureDetector(
            onTap: () {
              _authentication.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginSingUpScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.only(
                left: 12,
                top: 8,
                bottom: 8,
              ),
              child: Column(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10,
                  ),
                  Text("로그아웃 3"),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _widgetList.elementAt(_selectedIndex),
    );
  }
}

const List<Widget> _widgetList = <Widget>[
  Home(),
  GroupPageControll(),
  TempScreen(),
  MyprofilePageController(),
];

//처음 나오는 home page
class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;
  final List<Widget> _pages = [
    FeedPage(),
    Text("2"),
    Text("3"),
    GroupRegister()
  ];

  void _onButtonClicked(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
            ),
            label: "모임",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_sharp,
            ),
            label: "도서",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: "모임만들기",
          ),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        currentIndex: _selectedPage,
        onTap: _onButtonClicked,
      ),
    );
  }
}
