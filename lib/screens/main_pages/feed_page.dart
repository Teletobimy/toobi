import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 4, right: 4),
      child: Column(
        children: [
          //공지사항란
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            child: const Center(
              child: Text(
                '추천 정모',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 200,
            color: Colors.grey[200],
            child: ListView(
              children: [
                RecommendedMoim(
                  imageUrl:
                      "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjEyMThfODkg%2FMDAxNjcxMzQ3MTAzNzI3.OapSO6VFtba-5MohuAOB-RAZE7nqQGKUbMqCAnCi8JAg.JZ_8ABZbkuzxI6ltzZ-4H4yIQsRpQMUJfmK6arPHG6wg.JPEG.aooww2020%2FCYMERA%25A3%25DF20221218%25A3%25DF012706.jpg&type=a340",
                ),
                RecommendedMoim(
                  imageUrl:
                      "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjEyMThfODkg%2FMDAxNjcxMzQ3MTAzNzI3.OapSO6VFtba-5MohuAOB-RAZE7nqQGKUbMqCAnCi8JAg.JZ_8ABZbkuzxI6ltzZ-4H4yIQsRpQMUJfmK6arPHG6wg.JPEG.aooww2020%2FCYMERA%25A3%25DF20221218%25A3%25DF012706.jpg&type=a340",
                ),
                RecommendedMoim(
                  imageUrl:
                      "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjEyMThfODkg%2FMDAxNjcxMzQ3MTAzNzI3.OapSO6VFtba-5MohuAOB-RAZE7nqQGKUbMqCAnCi8JAg.JZ_8ABZbkuzxI6ltzZ-4H4yIQsRpQMUJfmK6arPHG6wg.JPEG.aooww2020%2FCYMERA%25A3%25DF20221218%25A3%25DF012706.jpg&type=a340",
                ),
                RecommendedMoim(
                  imageUrl:
                      "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjEyMThfODkg%2FMDAxNjcxMzQ3MTAzNzI3.OapSO6VFtba-5MohuAOB-RAZE7nqQGKUbMqCAnCi8JAg.JZ_8ABZbkuzxI6ltzZ-4H4yIQsRpQMUJfmK6arPHG6wg.JPEG.aooww2020%2FCYMERA%25A3%25DF20221218%25A3%25DF012706.jpg&type=a340",
                ),
                RecommendedMoim(
                  imageUrl:
                      "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjEyMThfODkg%2FMDAxNjcxMzQ3MTAzNzI3.OapSO6VFtba-5MohuAOB-RAZE7nqQGKUbMqCAnCi8JAg.JZ_8ABZbkuzxI6ltzZ-4H4yIQsRpQMUJfmK6arPHG6wg.JPEG.aooww2020%2FCYMERA%25A3%25DF20221218%25A3%25DF012706.jpg&type=a340",
                ),
                RecommendedMoim(
                  imageUrl:
                      "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjEyMThfODkg%2FMDAxNjcxMzQ3MTAzNzI3.OapSO6VFtba-5MohuAOB-RAZE7nqQGKUbMqCAnCi8JAg.JZ_8ABZbkuzxI6ltzZ-4H4yIQsRpQMUJfmK6arPHG6wg.JPEG.aooww2020%2FCYMERA%25A3%25DF20221218%25A3%25DF012706.jpg&type=a340",
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            child: const Center(
              child: Text(
                '추천 정모',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
              child: GridView.count(
            crossAxisCount: 2, // 열의 수
            children: List.generate(
              20,
              (index) {
                return Center(
                  child: Text(
                    '아이템 $index',
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}

class RecommendedMoim extends StatelessWidget {
  final imageUrl;
  // final moimTitle;
  // final date;
  // final startTime;
  // final endTime;
  // final joinedNumber;
  // final limitNumber;

  const RecommendedMoim({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          height: 90,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                width: 130,
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(image: NetworkImage(imageUrl))),
                // child: Image.network(imageUrl),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "모임제목",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text("마지막몰입 by 짐퀵"),
                  Text("날짜 시작시간 종료시간"),
                  Row(
                    children: [
                      Text("커피빈 동탄 DT 점"),
                      Text("참여인원 : 1/18"),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
