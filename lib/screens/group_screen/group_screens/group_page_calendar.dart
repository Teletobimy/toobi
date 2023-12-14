import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test01/screens/group_screen/group_screens/chat_screen/chatting/chat/chat_bubble.dart';
import 'package:test01/screens/setting/colors.dart';
import '../../setting/setting.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class GroupCalander extends StatefulWidget {
  const GroupCalander({super.key});

  @override
  State<GroupCalander> createState() => _GroupCalanderState();
}

class _GroupCalanderState extends State<GroupCalander> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>> events = {};

  late final ValueNotifier<List<Event>> _selectedEvents;
  var cnt = 0;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    print(user);
  }

  @override
  void dipose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController eventController = TextEditingController();
    return SafeArea(
      child: Column(
        children: [
          TableCalendar(
            locale: 'ko_kr', // 한국 달력 적용
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            eventLoader: _getEventsForDay,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            onDayLongPressed: (selectedDay, focusedDay) async
                // => showDialog(
                //     context: context,
                //     builder: (context)
                {
              return await showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  builder: (context) => AddBottomSheet(
                        focusedDay: focusedDay,
                        selectedDay: selectedDay,
                      ));
              // AlertDialog(
              //   scrollable: true,
              //   title: const Text("모임생성"),
              //   content: Padding(
              //     padding: const EdgeInsets.all(8),
              //     child: TextField(
              //       controller: eventController,
              //     ),
              //   ),
              //   actions: [
              //     TextButton.icon(
              //         onPressed: () {
              //           events.addAll({
              //             selectedDay: [Event(eventController.text)]
              //           });

              //           _selectedEvents.value =
              //               _getEventsForDay(_selectedDay!);
              //           Navigator.of(context).pop();
              //           print("이벤트 :$events");
              //           print("셀렉티드이벤츠 :$_selectedEvents");
              //           print("셀렉티드이벤츠벨류 : ${_selectedEvents.value}");
              //         },
              //         icon: const Icon(Icons.add),
              //         label: const Text("정모생성"))
              //   ],
              // );
            },
            // ),

            calendarStyle: const CalendarStyle(
              outsideDaysVisible: true,
            ),
          ),
          Container(
            width: double.infinity,
            height: 32,
            color: Colors.grey,
            child: const Text("---------------"),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Callendar')
                  // .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                }
                final chatDocs = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) {
                    return ScheduleCard(
                      chatDocs[index]['startTime'],
                      chatDocs[index]['endTime'],
                      chatDocs[index]['content'],
                      chatDocs[index]['index'],
                    );
                    // final int startTime;
                    // final int endTime;
                    // final String content;
                    // final int index;

                    // ChatBubbles(
                    //     chatDocs[index]['text'],
                    //     chatDocs[index]['userID'].toString() == user!.uid,
                    //     chatDocs[index]['userName'],
                    //     chatDocs[index]['userImage']);
                  },
                );
              },
            ),

            // child: ValueListenableBuilder<List<Event>>(
            //     valueListenable: _selectedEvents,
            //     builder: (context, value, _) {
            //       return ListView.builder(
            //           itemCount: value.length,
            //           itemBuilder: (context, index) {
            //             return Container(
            //               margin: const EdgeInsets.symmetric(
            //                   horizontal: 12, vertical: 4),
            //               decoration: BoxDecoration(
            //                 border: Border.all(width: 1),
            //                 borderRadius: BorderRadius.circular(12),
            //               ),
            //               child: ListTile(
            //                 onTap: () => print(""),
            //                 title: Text('${value[index]}'),
            //               ),
            //             );
            //           });
            //     }),
          )
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(this.startTime, this.endTime, this.content, this.index,
      {Key? key})
      : super(key: key);

  final Timestamp startTime;
  final Timestamp endTime;
  final String content;
  final int index;

  @override
  Widget build(BuildContext context) {
    Key key = GlobalKey();
    return Dismissible(
      key: key,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: PRIMATY_COLOR),
            borderRadius: BorderRadius.circular(8),
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: NetworkImage(
            //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE2SPTcM30IOarR5xyjD2ZtKYxbvY0PFhl-Q&usqp=CAU",
            //   ),
            // ),
          ),
          // foregroundDecoration: BoxDecoration(
          //   image: DecorationImage(
          //     fit: BoxFit.fill,
          //     image: NetworkImage(
          //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmQVFusMgsdl9rmBN6MUHSx2ZdOV4sinH3Jg&usqp=CAU"),
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: LIGHT_GREY_COLOR,
                        border: const Border.symmetric(
                            horizontal: BorderSide(width: 1))),
                    height: 40,
                    width: double.infinity,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "참석현황 : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.person_4_outlined),
                        Icon(Icons.person_4_outlined),
                        Icon(Icons.person_4_outlined),
                        Icon(Icons.person_4_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.person_3_outlined),
                        Icon(Icons.person_3_outlined),
                        Icon(Icons.person_3_outlined),
                        Icon(Icons.person_3_outlined),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '$index',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: PRIMATY_COLOR,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(width: 16),
                        _Time(startTime: startTime, endTime: endTime),
                        const SizedBox(width: 16),
                        const SizedBox(width: 16),
                        _Content(content: content),
                        const SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

//// -------- 달력부분  ---------

// class TableCalender1 extends StatefulWidget {
//   const TableCalender1({
//     super.key,
//   });

//   @override
//   State<TableCalender1> createState() => _TableCalender1State();
// }

// class _TableCalender1State extends State<TableCalender1> {

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

///   --하기는 컴포넌트 --  //
class _Time extends StatelessWidget {
  const _Time({
    required this.startTime,
    required this.endTime,
  });
  final Timestamp startTime;
  final Timestamp endTime;

  @override
  Widget build(BuildContext context) {
    const textStyle1 = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMATY_COLOR,
      fontSize: 14.0,
    );
    DateTime startTime2 = startTime.toDate();
    DateTime endTime2 = endTime.toDate();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${startTime2.year}-${startTime2.month}-${startTime2.day} ${startTime2.hour}-${startTime2.minute}',
          style: textStyle1,
        ),
        Text(
          '${endTime2.year}-${endTime2.month}-${endTime2.day} ${endTime2.hour}-${endTime2.minute}',
          style: textStyle1.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Text(
      content,
    ));
  }
}

class AddBottomSheet extends StatefulWidget {
  final DateTime? selectedDay;
  final DateTime? focusedDay;
  const AddBottomSheet({super.key, this.selectedDay, this.focusedDay});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newDAY = widget.selectedDay.toString();

    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(color: Colors.blue[100]),
      child: Column(
        children: [
          Text('${widget.selectedDay}'),
          Text('${widget.focusedDay}'),
          Text(newDAY),
          TextField(
            decoration: InputDecoration(
              labelText: "labelText : ${widget.selectedDay}",
              hintText: "hintText : ${widget.focusedDay}",
            ),
          ),
        ],
      ),
    ));
  }
}
