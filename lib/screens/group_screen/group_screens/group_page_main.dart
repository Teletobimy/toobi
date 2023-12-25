import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_components/adaptive_components.dart';

class GroupMainPage extends StatefulWidget {
  const GroupMainPage({super.key});

  @override
  State<GroupMainPage> createState() => _GroupMainPageState();
}

class _GroupMainPageState extends State<GroupMainPage> {
//모임홈화면 ing
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late bool management = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<DocumentSnapshot<Map<String, dynamic>>> userData;
  String? moimID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('user').doc(user.uid).get();

      Map<String, dynamic> map = snapshot["myMoimList"];

      setState(() {
        moimID = map.keys.first;
        print(map.keys.first.toString());
        print(moimID);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('moim').doc(moimID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('데이터를 불러올 수 없습니다.'),
              ),
            );
          } else {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.exists) {
              var moimData = snapshot.data!;

              String moimTitle = moimData['moimTitle'];
              String moimLocation = moimData['moimLocation'];
              int moimPoint = moimData['moimPoint'];

              return ListView(
                children: [
                  Container(
                    height: 190,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/독커.jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    moimTitle,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),

                  SizedBox(
                    height: 200,
                    child: ListView(
                      children: const [
                        Text("🌈안녕하세요❤📚독서 한잔, 커피 한잔☕시즌3으로 오신 여러분을 환영합니다"),
                        Text("🥰활동 : 자유독서, 지정독서, 자율스터디, 문화활동"),
                        Text("📔요일 : 현재 화,목,주말 및 공휴일"),
                        Text("📕시간 : 평일 오후 7시~9시, 주말 및 공휴일 오후 1~5시"),
                        Text("📗장소 : 빵쌤, 신리천카페거리, 센트럴파크 근처 카페 등"),
                        Text("💫모임 스케줄링은 단톡방에서 스프레드시트로 진행합니다👍🏻"),
                        Text("(스케줄은 매주 다를 수 있으니 자세한 사항은 시트를 참고해주세요 :D)"),
                        Text("🌸단톡방 참여 필수 📚독서 한잔, 커피 한잔☕시즌3"),
                        Text("🌸모임장 카카오 ID : khk9462"),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text(
                                    "자동강퇴설정 : on",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(Icons.settings),
                                ],
                              )),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  //모임맴버 부분

                  //MediaQuery.of(context).size.height * 0.3,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "사진첩",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.group),
                            label: const Text("관리"))
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: PageView.builder(
                            controller: PageController(
                              initialPage: 1,
                              viewportFraction: 0.4,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://picsum.photos/seed/159/${index}00',
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.14,
                                    ),
                                    Text('$index번 사진'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "모임맴버(40)",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (management == true)
                          TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  management = false;
                                });
                              },
                              icon: const Icon(Icons.check),
                              label: const Text("확인")),
                        if (management == false)
                          TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  management = true;
                                });
                              },
                              icon: const Icon(Icons.group),
                              label: const Text("관리")),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 40,
                      itemBuilder: (_, index) => management == true
                          ? newMethod(index)
                          : newMethod2(index),
                    ),
                  ),
                ],
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Text('이 모임은 현재 접근이 제한되었습니다'),
                ),
              );
            }
          }
        }
      },
    );
  }

// LayoutBuilder(builder: (context, constraints) {
//       return
// AdaptiveColumn(
//         children: [
//           AdaptiveContainer(
//             columnSpan: 12,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 child: ListView(
//                   children: [
//                     Container(
//                       height: 190,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage(
//                             'assets/독커.jpg',
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text(
//                       "📚독서 한잔, 커피 한잔☕",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
//                     ),
//                     SizedBox(
//                       height: 200,
//                       child: ListView(
//                         children: const [
//                           Text("🌈안녕하세요❤📚독서 한잔, 커피 한잔☕시즌3으로 오신 여러분을 환영합니다"),
//                           Text("🥰활동 : 자유독서, 지정독서, 자율스터디, 문화활동"),
//                           Text("📔요일 : 현재 화,목,주말 및 공휴일"),
//                           Text("📕시간 : 평일 오후 7시~9시, 주말 및 공휴일 오후 1~5시"),
//                           Text("📗장소 : 빵쌤, 신리천카페거리, 센트럴파크 근처 카페 등"),
//                           Text("💫모임 스케줄링은 단톡방에서 스프레드시트로 진행합니다👍🏻"),
//                           Text("(스케줄은 매주 다를 수 있으니 자세한 사항은 시트를 참고해주세요 :D)"),
//                           Text("🌸단톡방 참여 필수 📚독서 한잔, 커피 한잔☕시즌3"),
//                           Text("🌸모임장 카카오 ID : khk9462"),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 10,
//                       width: double.infinity,
//                       color: Colors.white,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: 40,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             TextButton(
//                                 onPressed: () {},
//                                 child: const Row(
//                                   children: [
//                                     Text(
//                                       "자동강퇴설정 : on",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                     SizedBox(
//                                       width: 8,
//                                     ),
//                                     Icon(Icons.settings),
//                                   ],
//                                 )),
//                             const SizedBox(
//                               width: 10,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 10,
//                       width: double.infinity,
//                       color: Colors.white,
//                     ),
//                     //모임맴버 부분
//                     //MediaQuery.of(context).size.height * 0.3,
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "사진첩",
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           TextButton.icon(
//                               onPressed: () {},
//                               icon: const Icon(Icons.group),
//                               label: const Text("관리"))
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.2,
//                       child: Stack(
//                         children: [
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
//                             child: PageView.builder(
//                               controller: PageController(
//                                 initialPage: 1,
//                                 viewportFraction: 0.4,
//                               ),
//                               scrollDirection: Axis.horizontal,
//                               itemCount: 10,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Column(
//                                     children: [
//                                       Image.network(
//                                         'https://picsum.photos/seed/159/${index}00',
//                                         fit: BoxFit.cover,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.14,
//                                       ),
//                                       Text('$index번 사진'),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "모임맴버(40)",
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           if (management == true)
//                             TextButton.icon(
//                                 onPressed: () {
//                                   setState(() {
//                                     management = false;
//                                   });
//                                 },
//                                 icon: const Icon(Icons.check),
//                                 label: const Text("확인")),
//                           if (management == false)
//                             TextButton.icon(
//                                 onPressed: () {
//                                   setState(() {
//                                     management = true;
//                                   });
//                                 },
//                                 icon: const Icon(Icons.group),
//                                 label: const Text("관리")),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.3,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: 40,
//                         itemBuilder: (_, index) => management == true
//                             ? newMethod(index)
//                             : newMethod2(index),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
// },);

  Row newMethod(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Icon(index % 2 == 0 ? Icons.person : Icons.person_2),
            const SizedBox(
              width: 4,
            ),
            Text(
              index % 2 == 0 ? "${index + 1} 남자유저" : "${index + 1} 여자유저",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            label: const Text("편집"))
      ],
    );
  }

  Row newMethod2(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Icon(index % 2 == 0 ? Icons.person : Icons.person_2),
            const SizedBox(
              width: 4,
            ),
            Text(
              index % 2 == 0 ? "${index + 1} 남자유저" : "${index + 1} 여자유저",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.card_giftcard),
            label: const Text("선물하기"))
      ],
    );
  }
}
