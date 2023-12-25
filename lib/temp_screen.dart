import 'package:flutter/material.dart';
import 'package:test01/screens/group_screen/group_page_controller.dart';
import 'package:test01/screens/main_screen.dart';
import 'package:test01/screens/myprofilepages/myprofile_page_controller.dart';
import 'package:test01/screens/setting/colors.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("전체 채팅 화면"),
      bottomNavigationBar: BottomAppBar(
        height: 69,
        child: Row(
          children: [
            //하단 버튼 1
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginedScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Column(
                  children: [Icon(Icons.home), Text("홈")],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: 2,
              color: Colors.grey,
            ),
            //하단 버튼 2
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GroupPageControll(),
                    ),
                  );
                },
                child: const Column(
                  children: [Icon(Icons.group), Text("내모임")],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: 2,
              color: Colors.grey,
            ),
            //하단 버튼 3
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TempScreen(),
                    ),
                  );
                },
                child: const Column(
                  children: [Icon(Icons.chat), Text("톡")],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: 2,
              color: Colors.grey,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyprofilePageController(),
                    ),
                  );
                },
                child: const Column(
                  children: [Icon(Icons.person), Text("내정보")],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
