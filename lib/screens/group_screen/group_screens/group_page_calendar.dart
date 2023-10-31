import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test01/screens/setting/colors.dart';
import '../../setting/setting.dart';

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

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
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
            onDayLongPressed: (selectedDay, focusedDay) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("모임생성"),
                    content: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: eventController,
                      ),
                    ),
                    actions: [
                      TextButton.icon(
                          onPressed: () {
                            events.addAll({
                              selectedDay: [Event(eventController.text)]
                            });

                            _selectedEvents.value =
                                _getEventsForDay(_selectedDay!);
                            Navigator.of(context).pop();
                            print("이벤트 :$events");
                            print("셀렉티드이벤츠 :$_selectedEvents");
                            print("셀렉티드이벤츠벨류 : ${_selectedEvents.value}");
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("정모생성"))
                    ],
                  );
                }),

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
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: events.length,
          //       itemBuilder: (BuildContext context, int index) => ScheduleCard(
          //             startTime: DateTime.april,
          //             endTime: DateTime.august,
          //             content: 'test모드, 이곳에 일정을 넣습니다',
          //             index: index + 1,
          //           )),
          // )
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () => print(""),
                            title: Text('${value[index]}'),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final int index;

  const ScheduleCard(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.content,
      required this.index});

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
  final int startTime;
  final int endTime;

  @override
  Widget build(BuildContext context) {
    const textStyle1 = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMATY_COLOR,
      fontSize: 16.0,
    );

    return Column(
      children: [
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle1,
        ),
        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
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
