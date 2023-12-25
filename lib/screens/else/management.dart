import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  State<Management> createState() => _ManagementState();
}

Future<List<Map<String, dynamic>>> fetchAllMeetingsData() async {
  CollectionReference meetings = FirebaseFirestore.instance.collection('Moim');
  List<Map<String, dynamic>> moimDataList = [];

  try {
    QuerySnapshot querySnapshot = await meetings.get();

    querySnapshot.docs.forEach((doc) {
      String moimTitle = doc.get('moimTitle');
      String moimLocation = doc.get('moimLocation');
      int moimLimit = doc.get('moimLimit');

// boardID 1702466067006 (번호)
// createdTime 2023년 12월 13일 오후 8시 14분 26초 UTC+9 (타임스탬프)
// moimIntroduction "" (문자열)
// moimJang"XBiOoTEngGM1Df5xv3CBiRq0vfb2"(문자열)
// moimLimit 50 (번호)
// moimLocation"온라인"(문자열)
// moimMembers(배열)0"XBiOoTEngGM1Df5xv3CBiRq0vfb2"(문자열)
// moimPoint0(번호)
// moimScheule(배열)
// moimTitle"독서한잔 커피두잔"(문자열)
// oonYoungJin

      // 모임 데이터를 Map으로 생성하여 리스트에 추가
      Map<String, dynamic> moimData = {
        'moimTitle': moimTitle,
        'moimPoint': moimLocation,
        'moimLimit': moimLimit,
      };
      moimDataList.add(moimData);
    });

    print('All Meetings Data: $moimDataList');
    // 여기서 moimDataList를 활용하여 필요한 작업 수행 가능
  } catch (e) {
    print('Failed to fetch meetings: $e');
  }
  return moimDataList;
}

class _ManagementState extends State<Management> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchAllMeetingsData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(), // 로딩 중인 경우 프로그레스바 표시
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'), // 에러 발생 시 에러 메시지 표시
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No meetings found'), // 데이터 없는 경우 메시지 표시
              );
            } else {
              List<Map<String, dynamic>> moimTitle = snapshot.data!;
              return ListView.builder(
                itemCount: moimTitle.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text("${moimTitle[index]["moimTitle"]}"),
                        Text("${moimTitle[index]["moimPoint"]}"),
                        Text("${moimTitle[index]["moimLimit"]}"),
                      ],
                    ),
                  );
                  // ListTile(
                  //   title: Text("모임이름 : ${moimTitle[index].toString()}"),
                  // );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
