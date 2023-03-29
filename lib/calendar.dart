import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'dart:math';

class CalendarPage extends StatefulWidget {

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? selectedDate;
  Random random = new Random();
  @override
  void initState (){
  setState(() {
    selectedDate = DateTime.now();
});
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: CalendarAppBar(
            padding: 8,
            accent: Colors.deepOrangeAccent,
            onDateChanged: (value) => setState(() => selectedDate = value),
            lastDate: DateTime.now(),
            events: List.generate(100, (index) => DateTime.now().subtract(Duration(days: index * random.nextInt(5)))),
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context,index){
                return ListTile(
                  leading: Icon(Icons.event),
                  title: Text('No event listed yet'),
                  trailing: Text(selectedDate.toString(), style: TextStyle(fontSize: 11)),
                );
        })
      );
  }
}
