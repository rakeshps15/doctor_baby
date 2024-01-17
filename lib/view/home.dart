import 'package:doctor_baby/controller/dates_controller.dart';
import 'package:doctor_baby/view/chat.dart';
import 'package:doctor_baby/view/mail/mail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class VaccineCalendar extends StatefulWidget {

  final DatesController datesController = Get.put(DatesController());

  @override
  _VaccineCalendarState createState() => _VaccineCalendarState();
  }

class _VaccineCalendarState extends State<VaccineCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};
  DateTime? _selectedListViewDate;


  @override
  void initState() {
    super.initState();

  sendMailToParent();

    datesController.dates.forEach((date) {
      _events[date] = ['Vaccine Date'];
    });

    DateTime birthDate = DateTime.now();
 }
  
  List<String> _getEventsForDay(DateTime date) {
    return _events[date] ?? [];
  }

  void _showEventDetails(DateTime selectedDay) {
    List<String> events = _events[selectedDay] ?? [];
    if (events.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Events on ${selectedDay.toString().split(' ')[0]}'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: events.map((event) {
                return Text('- $event');
              }).toList(),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  final DatesController datesController = Get.put(DatesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatBot()));
        },child: Icon(Icons.message),),

        backgroundColor: Colors.white,
        body: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text("Doctor baby", 
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),)),
      
              TableCalendar(
                firstDay: DateTime.utc(2021, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
                headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                formatButtonDecoration: BoxDecoration(color: Colors.grey),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                  titleTextStyle: TextStyle(color: Colors.black),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(color: Colors.black),
                ),
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _showEventDetails(selectedDay);
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    final markers = <Widget>[];
          
                    if (_events[date] != null && _events[date]!.isNotEmpty) {
                      markers.add(
                        Positioned(
                          bottom: 1,
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    }
          
                    return Row(children: markers);
                  },
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Vaccine Dates:',
                  style: TextStyle(letterSpacing: 1.2,fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Expanded(
                child: Container(
                  // padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: 
                  Obx(() => 
                  ListView.builder(
                    itemCount: datesController.dates.length,
                    itemBuilder: (context, index) {
                      DateTime date = datesController.dates[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        color: Colors.grey[900],
                        child: ListTile(
                          title: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${date.day}/${date.month}/${date.year}',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                  fontSize: 17
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _selectedListViewDate = date;
                              _selectedDay = date;
                              _focusedDay = date;
                            });
                            _showEventDetails(date);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
