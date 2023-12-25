import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../login_screen.dart';

class GroupRegister extends StatefulWidget {
  const GroupRegister({super.key});

  @override
  State<GroupRegister> createState() => _GroupRegisterState();
}

final groupTitle = TextEditingController();
int _selectedLocation = 0;
int _moimLimit = 10;
const List<String> _location = <String>[
  '서울',
  '경기도',
  '인천',
  '그 외',
  '온라인',
];

class _GroupRegisterState extends State<GroupRegister> {
  @override
  Widget build(BuildContext context) {
    var fHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              controller: groupTitle,
              decoration: InputDecoration(labelText: '모임이름'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('모임장소 : '),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  // Display a CupertinoPicker with list of fruits.
                  onPressed: () => _showDialog(
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 28,
                      // This sets the initial item.
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedLocation,
                      ),
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          _selectedLocation = selectedItem;
                        });
                      },
                      children:
                          List<Widget>.generate(_location.length, (int index) {
                        return Center(child: Text(_location[index]));
                      }),
                    ),
                  ),
                  // This displays the selected fruit name.
                  child: Text(
                    _location[_selectedLocation],
                    style: const TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("모임인원 : "),
                NumberPicker(
                  minValue: 10,
                  maxValue: 50,
                  step: 10,
                  haptics: true,
                  value: _moimLimit,
                  onChanged: ((value) => setState(
                        () {
                          _moimLimit = value;
                        },
                      )),
                ),
              ],
            ),
            SizedBox(height: fHeight * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _addEventToFirestore();
                    groupTitle.clear();
                  },
                  child: Text('가입'),
                ),
                ElevatedButton(
                  onPressed: () {
                    groupTitle.clear();
                  },
                  child: Text('취소'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addEventToFirestore() async {
    String moimTitle = groupTitle.text;
    String moimLocation = _location[_selectedLocation];
    int moimLimit = _moimLimit;

    DateTime now = DateTime.now();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    int point = 0;

    List<String> moimSchedule = [];

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("user")
          .doc(user.uid)
          .get();
      String name = data["userName"];

      print("id : ${user.uid} 이름 : $name");
      Map<String, String> map = {user.uid: name};
      if (moimTitle.isNotEmpty && moimLocation.isNotEmpty && map.isNotEmpty) {
        String generateRandomId(int length) {
          const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
          final random = Random();
          return String.fromCharCodes(Iterable.generate(
            length,
            (_) => chars.codeUnitAt(random.nextInt(chars.length)),
          ));
        }

        String randomeID = generateRandomId(20);

        try {
          await FirebaseFirestore.instance
              .collection('moim')
              .doc(randomeID)
              .set({
            'moimTitle': moimTitle,
            'moimLocation': moimLocation,
            "moimIntroduction": "",
            'moimLimit': moimLimit,
            'createdTime': now,
            "moimJang": map,
            "oonYoungJin": map,
            "moimPoint": point,
            "boardID": DateTime.now().millisecondsSinceEpoch,
            "moimMembers": map,
            "moimScheule": moimSchedule,
          });

          await FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .update({
            'myMoimList.$randomeID': moimTitle,
          });
          print('모임이 성공적으로 추가되었습니다!');
          // 추가되었으니 필요한 다른 작업을 수행하거나 화면을 닫을 수 있습니다.
        } catch (e) {
          print('모임 추가 중 오류가 발생했습니다: $e');
        }
      } else {
        print('유효한 정보를 입력하세요.');
      }
    } else {
      auth.signOut().then((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginSingUpScreen()),
        );
      });
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
