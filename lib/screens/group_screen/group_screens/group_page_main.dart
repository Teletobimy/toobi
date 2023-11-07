import 'package:flutter/material.dart';
import 'package:adaptive_components/adaptive_components.dart';

class GroupMainPage extends StatefulWidget {
  const GroupMainPage({super.key});

  @override
  State<GroupMainPage> createState() => _GroupMainPageState();
}

class _GroupMainPageState extends State<GroupMainPage> {
//모임홈화면 ing

  late bool management = false;

  @override
  Widget build(BuildContext context) {
    //final

    //final END
    return LayoutBuilder(builder: (context, constraints) {
      return AdaptiveColumn(
        children: [
          AdaptiveContainer(
            columnSpan: 12,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
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
                    const Text(
                      "📚독서 한잔, 커피 한잔☕",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
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
                              // children: [
                              //   ClipRRect(
                              //     borderRadius: BorderRadius.circular(8),
                              //     child: Image.network(
                              //       'https://picsum.photos/seed/159/600',
                              //       width: 300,
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              //   ClipRRect(
                              //     borderRadius: BorderRadius.circular(8),
                              //     child: Image.network(
                              //       'https://picsum.photos/seed/328/600',
                              //       width: 300,
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              //   ClipRRect(
                              //     borderRadius: BorderRadius.circular(8),
                              //     child: Image.network(
                              //       'https://picsum.photos/seed/614/600',
                              //       width: 300,
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              //   ClipRRect(
                              //     borderRadius: BorderRadius.circular(8),
                              //     child: Image.network(
                              //       'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA2MTBfOTMg%2FMDAxNTI4NjE0NjA0NDcz.fAf3CClc5_yBJMZ7Mr7hs0JyjqEXsbrgs2CxkcZ1jx0g.2-mLMSH88M53vnP50-wl0seuhZ4bZU-nJVr_tv0LkMcg.JPEG.zxczx23%2F%25B5%25B6%25BC%25AD%25C0%25C7%25BF%25D5006.jpg&type=a340',
                              //       width: 300,
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              //   ClipRRect(
                              //     borderRadius: BorderRadius.circular(8),
                              //     child: Image.network(
                              //       'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA0MzBfMTIz%2FMDAxNjgyODMzMDIzMjA0.rp6m8rN4Xx29YrjBJHIpOtG4tC9628ChX1ZVdFU3m2Ug.mWdpUj-lf5UQjCDF2_KbaFgPCxfWmOzTTySFetXa9pMg.PNG.forest1212%2Fimage.png&type=a340',
                              //       width: 300,
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ],
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
                        // {
                        // return UserContainer(
                        //   index: index,
                        // );
                        // },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //test
          // AdaptiveContainer(
          //     columnSpan: 12,
          //     child: Column(
          //       children: [
          //         const HomeHighlight(),
          //         LayoutBuilder(
          //           builder: (context, constraints) => HomeArtists(
          //             artists: artists,
          //             constraints: constraints,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   AdaptiveContainer(
          //     columnSpan: 12,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(2), // Modify this line
          //           child: Text(
          //             'Recently played',
          //             style: context.headlineSmall,
          //           ),
          //         ),
          //         HomeRecent(
          //           playlists: playlists,
          //         ),
          //       ],
          //     ),
          //   ),
          //   AdaptiveContainer(
          //     columnSpan: 12,
          //     child: Padding(
          //       padding: const EdgeInsets.all(2), // Modify this line
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Flexible(
          //             flex: 10,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Padding(
          //                   padding:
          //                       const EdgeInsets.all(2), // Modify this line
          //                   child: Text(
          //                     'Top Songs Today',
          //                     style: context.titleLarge,
          //                   ),
          //                 ),
          //                 LayoutBuilder(
          //                   builder: (context, constraints) =>
          //                       PlaylistSongs(
          //                     playlist: topSongs,
          //                     constraints: constraints,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           // Add spacer between tables
          //           Flexible(
          //             flex: 10,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Padding(
          //                   padding:
          //                       const EdgeInsets.all(2), // Modify this line
          //                   child: Text(
          //                     'New Releases',
          //                     style: context.titleLarge,
          //                   ),
          //                 ),
          //                 LayoutBuilder(
          //                   builder: (context, constraints) =>
          //                       PlaylistSongs(
          //                     playlist: newReleases,
          //                     constraints: constraints,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          //testEnd
        ],
      );
    });
  }

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

// class UserContainer extends StatelessWidget {
//   final int index;
//   const UserContainer({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Container(
//         decoration: BoxDecoration(border: Border.all(width: 0.1)),
//         height: 40,
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1),
//                         borderRadius: BorderRadius.circular(50),
//                         color: Colors.grey),
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: Container(
//                         width: 13,
//                         height: 13,
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 1),
//                             borderRadius: BorderRadius.circular(50),
//                             color: Colors.red),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 4,
//                   ),
//                   Icon(index % 2 == 0 ? Icons.person : Icons.person_2),
//                   const SizedBox(
//                     width: 4,
//                   ),
//                   Text(
//                     index % 2 == 0 ? "${index + 1} 남자유저" : "${index + 1} 여자유저",
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//               TextButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.settings),
//                   label: const Text("편집"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//  WordBreakText(
//   "🌈안녕하세요❤📚독서 한잔, 커피 한잔☕시즌3으로 오신 여러분을 환영합니다🥰📙 활동 : 자유독서, 지정독서, 자율스터디, 문화활동📔 요일 : 현재 화,목,주말 및 공휴일📕 시간 : 평일 오후 7시~9시, 주말 및 공휴일 오후 1~5시📗 장소 : 빵쌤, 신리천카페거리, 센트럴파크 근처 카페 등  💫모임 스케줄링은 단톡방에서 스프레드시트로 진행합니다👍🏻 (스케줄은 매주 다를 수 있으니 자세한 사항은 시트를 참고해주세요 :D) 🌸단톡방 참여 필수 📚독서 한잔, 커피 한잔☕시즌3 🌸모임장 카카오 ID : khk9462",
//   style: TextStyle(fontSize: 14),
// ),
