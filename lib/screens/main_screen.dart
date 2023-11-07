import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:test01/screens/group_screen/group_page_controller.dart';
import 'package:test01/screens/login_screen.dart';
import 'package:test01/screens/myprofilepages/myprofile_page_controller.dart';
import 'package:test01/screens/setting/colors.dart';
import 'package:test01/temp_screen.dart';

class MainScreen2 extends StatefulWidget {
  const MainScreen2({super.key});

  @override
  State<MainScreen2> createState() => _MainScreen2State();
}

// int _selectedIndex = 0;

class _MainScreen2State extends State<MainScreen2> {
  final _authentication = FirebaseAuth.instance;

  User? loggedUser;
  int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
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
        title: const Text("📚독서 한잔, 커피 한잔☕ "),
        centerTitle: true,
        backgroundColor: PRIMATY_COLOR,
        leading: Builder(
            builder: (BuildContext context) => IconButton(
                tooltip: "메뉴",
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu))),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         return Test1();
        //       }));
        //     },
        //     child: Text("action button"),
        //   ),
        //   SizedBox(
        //     width: 14,
        //   )
        // ],
      ),
      //Drawer part
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
              icon: Icon(Icons.house_outlined),
              selectedIcon: Icon(Icons.house),
              label: Text("그룹"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.house_outlined),
              selectedIcon: Icon(Icons.house),
              label: Text("채팅"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.house_outlined),
              selectedIcon: Icon(Icons.house),
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
        // ListView(
        //   padding: EdgeInsets.zero,
        //   children: <Widget>[
        //     const DrawerHeader(
        //       decoration: BoxDecoration(
        //         color: PRIMATY_COLOR,
        //       ),
        //       child: Text(
        //         '메뉴 모음',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 24,
        //         ),
        //       ),
        //     ),
        //     //Draw 버튼 1
        //     GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const MyprofilePageController(),
        //           ),
        //         );
        //       },
        //       child: const Padding(
        //         padding: EdgeInsets.only(
        //           left: 12,
        //           top: 8,
        //           bottom: 8,
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.person),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Text("버튼 1"),
        //           ],
        //         ),
        //       ),
        //     ),
        //     // Draw 버튼 2
        //     GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const MyprofilePageController(),
        //           ),
        //         );
        //       },
        //       child: const Padding(
        //         padding: EdgeInsets.only(
        //           left: 12,
        //           top: 8,
        //           bottom: 8,
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.person),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Text("버튼 2"),
        //           ],
        //         ),
        //       ),
        //     ),
        //     //버튼 3
        //     GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const MyprofilePageController(),
        //           ),
        //         );
        //       },
        //       child: const Padding(
        //         padding: EdgeInsets.only(
        //           left: 12,
        //           top: 8,
        //           bottom: 8,
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.person),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Text("버튼 3"),
        //           ],
        //         ),
        //       ),
        //     ),
        //     GestureDetector(
        //       onTap: () {
        //         _authentication.signOut();
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => LoginSingUpScreen()));
        //       },
        //       child: const Padding(
        //         padding: EdgeInsets.only(
        //           left: 12,
        //           top: 8,
        //           bottom: 8,
        //         ),
        //         child: Row(
        //           children: [
        //             Icon(Icons.logout),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Text("로그아웃 3"),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
      body: _widgetList.elementAt(_selectedIndex),
      // bottomNavigationBar: Row(
      //   children: [
      //     NavigationRail(
      //       destinations: <NavigationRailDestination>[
      //         NavigationRailDestination(
      //           icon: Icon(Icons.house_outlined),
      //           selectedIcon: Icon(Icons.house),
      //           label: Text("Home"),
      //         ),
      //         NavigationRailDestination(
      //           icon: Icon(Icons.house_outlined),
      //           selectedIcon: Icon(Icons.house),
      //           label: Text("Home"),
      //         ),
      //         NavigationRailDestination(
      //           icon: Icon(Icons.house_outlined),
      //           selectedIcon: Icon(Icons.house),
      //           label: Text("Home"),
      //         ),
      //       ],
      //       selectedIndex: _selectedIndex,
      //       onDestinationSelected: (int index) {
      //         setState(() {
      //           _selectedIndex = index;
      //         });
      //       },
      //       useIndicator: true,
      //       labelType: NavigationRailLabelType.all,
      //       selectedLabelTextStyle: TextStyle(color: Colors.lightBlue[500]),
      //       unselectedLabelTextStyle: TextStyle(color: Colors.grey[500]),
      //       backgroundColor: Colors.grey[50],
      //       indicatorColor: Colors.cyan[50],
      //       minWidth: 100,
      //       leading: Container(
      //         width: 80,
      //         height: 80,
      //         color: Colors.red,
      //       ),
      //       trailing: Container(
      //         width: 80,
      //         height: 80,
      //         color: Colors.blue,
      //       ),
      //     ),
      //   ],
      // )
      // BottomAppBar(
      //   height: 69,
      //   child: Row(
      //     children: [
      //       //하단 버튼 1
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () {
      //             Navigator.pushAndRemoveUntil(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const MainScreen2(),
      //               ),
      //               (route) => false,
      //             );
      //           },
      //           child: const Column(
      //             children: [Icon(Icons.home), Text("홈")],
      //           ),
      //         ),
      //       ),
      //       Container(
      //         height: double.infinity,
      //         width: 2,
      //         color: Colors.grey,
      //       ),
      //       //하단 버튼 2
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const GroupPageControll(),
      //               ),
      //             );
      //           },
      //           child: const Column(
      //             children: [Icon(Icons.group), Text("모임")],
      //           ),
      //         ),
      //       ),
      //       Container(
      //         height: double.infinity,
      //         width: 2,
      //         color: Colors.grey,
      //       ),
      //       //하단 버튼 3
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const TempScreen(),
      //               ),
      //             );
      //           },
      //           child: const Column(
      //             children: [Icon(Icons.chat), Text("톡")],
      //           ),
      //         ),
      //       ),
      //       Container(
      //         height: double.infinity,
      //         width: 2,
      //         color: Colors.grey,
      //       ),
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const MyprofilePageController(),
      //               ),
      //             );
      //           },
      //           child: const Column(
      //             children: [Icon(Icons.person), Text("내정보")],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

const List<Widget> _widgetList = <Widget>[
  Home(),
  GroupPageControll(),
  TempScreen(),
  MyprofilePageController(),
];

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView(
          shrinkWrap: true,
          children: [
            //공지사항란
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 2),
              ),
              child: const Center(
                child: Text(
                  '공지사항',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 100,
              decoration: const BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(width: 1)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/독커.jpg',
                  ),
                ),
              ),
              child: const Center(
                child: Text("공지사항란"),
              ),
            ),
            const SizedBox(
                height: 40,
                child: Center(
                    child: Text(
                  "내모임",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
            Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(width: 1)),
              ),
              height: 200,
              child: Text('내정모 모음'),
              //내모임 정모 모음
              // child: StreamBuilder(stream: FirebaseFirestore.instance
              // .collection('')
              // , builder: builder)
            ),
            // Container(
            //   color: Colors.grey,
            //   height: 10,
            // ),
            Container(
                decoration: const BoxDecoration(
                    border: Border.symmetric(horizontal: BorderSide(width: 1))),
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                          label: const Text("모임찾기")),
                      const Text(
                        "추천모임목록",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.create),
                          label: const Text("모임만들기")),
                    ])),
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    ContainerElements2(index: index),
                itemCount: 20,
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                    border: Border.symmetric(horizontal: BorderSide(width: 1))),
                height: 40,
                child: const Center(
                    child: Text(
                  "정모목록",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.amber,
                            ),
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 50,
                            child: Text("정모"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.amber,
                            ),
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 50,
                            child: Text("정모"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.amber,
                            ),
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 50,
                            child: Text("정모"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.amber,
                            ),
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 50,
                            child: Text("정모"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.1),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.amber,
                              ),
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(
                              height: 50,
                              child: Text("정모"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContainerElements extends StatelessWidget {
  final int index;
  const ContainerElements({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black26, borderRadius: BorderRadius.circular(10)),
          height: 100,
          child: IntrinsicHeight(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$index : ',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                index % 2 == 0 ? "게시글1" : "게시글2",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ))),
    );
  }
}

class ContainerElements2 extends StatelessWidget {
  final int index;
  const ContainerElements2({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: PRIMATY_COLOR),
              borderRadius: BorderRadius.circular(20)),
          height: 100,
          child: IntrinsicHeight(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$index : ',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                index % 2 == 0 ? "모임1" : "모임2",
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ))),
    );
  }
}
