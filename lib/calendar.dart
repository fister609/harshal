import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? selectedDate;
  TextEditingController eventController = TextEditingController();
  bool isEditing = false;
  String? eventId;
  List<DateTime> events = [];

  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final snapshot = await FirebaseFirestore.instance.collection('calendar').get();
    setState(() {
      events = snapshot.docs.map((doc) => (doc['date'] as Timestamp).toDate()).toList();
    });
  }

  Future<void> addEventToFirebase() async {
    String eventText = eventController.text;
    if (eventText.isNotEmpty) {
      try {
        if (isEditing) {
          await FirebaseFirestore.instance
              .collection("calendar")
              .doc(eventId)
              .update({
            'event': eventText,
          });
        } else {
          await FirebaseFirestore.instance.collection("calendar").add({
            'date': selectedDate,
            'event': eventText,
          });
        }
        setState(() {
          eventController.clear();
          isEditing = false;
          eventId = null;
          fetchEvents(); // Refresh the events list
        });
      } catch (error) {
        // Handle the error
        print("Error adding event: $error");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to add event. Please try again.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      }
    }
  }


  Future<void> deleteEvent(String eventId) async {
    await FirebaseFirestore.instance.collection("calendar").doc(eventId).delete();
    setState(() {
      fetchEvents(); // Refresh the events list
    });
  }

  Future<void> editEvent(String eventId, String eventText) async {
    setState(() {
      isEditing = true;
      this.eventId = eventId;
      eventController.text = eventText;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime endOfYear = DateTime(now.year, 12, 31);

    return Scaffold(
      appBar: CalendarAppBar(
        padding: 8,
        accent: Colors.deepOrangeAccent,
        selectedDate: selectedDate,
        onDateChanged: (value) => setState(() => selectedDate = value),
        firstDate: now,
        lastDate: endOfYear,
        events: events,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('calendar').where('date', isEqualTo: selectedDate).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final events = snapshot.data!.docs;
                  if (events.isNotEmpty) {
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        final eventId = event.id;
                        final eventText = event['event'];
                        return ListTile(
                          leading: Icon(Icons.event),
                          title: Text(eventText),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => editEvent(eventId, eventText),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => deleteEvent(eventId),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
                return ListTile(
                  leading: Icon(Icons.event),
                  title: Text('No events listed'),
                  trailing: Text(selectedDate.toString(), style: TextStyle(fontSize: 11)),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: eventController,
                    decoration: InputDecoration(
                      labelText: 'Event',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: addEventToFirebase,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
