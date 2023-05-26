import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:first/profile.dart';
import 'package:first/study.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'About.dart';
import 'Screens/HomeScreen.dart';
import 'Search.dart';
import 'buy_sell.dart';
import 'calendar.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageindex = 2;
  final pages = [BuyPage(), StudyApp(),EventsPage(),HomeScreen(),SearchPage()];
  var _appPageController = PageController();

  setBottomBarIndex(index) {
    setState(() {
      pageindex = index;
    });
    _appPageController.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.bounceInOut);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:pages[pageindex],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          activeColor: Colors.deepOrangeAccent,
          color: Colors.grey,
          style: TabStyle.flip,
          items: [
            TabItem(icon: Icons.shopping_cart,title: 'Share',),
            TabItem(icon: Icons.menu_book_rounded,title: 'Study',),
            TabItem(icon: Icons.home,title: 'Home'),
            TabItem(icon: Icons.message_outlined,title: 'Chat'),
            TabItem(icon: Icons.search,title: 'Search',),],
          initialActiveIndex: 2,
          onTap: (int pageindex){
            setState(() {
              setBottomBarIndex(pageindex);
            });
          },
        )
    );
  }
}

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _linkController;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _linkController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final result = await _picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        _selectedImage = result;
      });
    }
  }

  Future<void> _addEvent() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_selectedImage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select an image')),
          );
          return;
        }

        final title = _titleController.text;
        final description = _descriptionController.text;
        final link = _linkController.text;

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('event_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        final uploadTask = storageRef.putFile(File(_selectedImage!.path));
        final TaskSnapshot storageSnapshot = await uploadTask;
        final imageUrl = await storageSnapshot.ref.getDownloadURL();

        final event = {
          'title': title,
          'description': description,
          'imageUrl': imageUrl,
          'link': link,
        };

        await FirebaseFirestore.instance.collection('events').add(event);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Event added successfully')),
        );

        _formKey.currentState!.reset();
        _selectedImage = null;
      } catch (error) {
        print('Error adding event: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add event')),
        );
      }
    }
  }

  Future<void> _deleteEvent(String eventId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this event?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('events')
                      .doc(eventId)
                      .delete();

                  Navigator.of(context).pop(); // Close the confirmation dialog

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Event deleted successfully')),
                  );
                } catch (error) {
                  print('Error deleting event: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete event')),
                  );
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showEventDetails(String imageUrl, String title, String description, String link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text('Event Name: $title'),
                SizedBox(height: 10),
                Text('Description: $description'),
                SizedBox(height: 10),
                Text('Link: $link'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Title(color: Colors.white, child: Text('Events',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => CalendarPage()));
            }, icon: Icon(Icons.calendar_month, weight: 20)),

          ),],
        elevation: 3,
      ),
      drawer: Drawer(child: MainDrawer()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _linkController,
                        decoration: InputDecoration(labelText: 'Link'),
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: _uploadImage,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _selectedImage != null
                                  ? FileImage(File(_selectedImage!.path)) as ImageProvider<Object>
                                  : AssetImage('assets/Icon/icon.jpg'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _addEvent,
                        child: Text('Add Event'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('events').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final events = snapshot.data!.docs;

              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index].data() as Map<String, dynamic>;

                  final imageUrl = event['imageUrl'] ?? '';
                  final title = event['title'] ?? '';
                  final description = event['description'] ?? '';
                  final link = event['link'] ?? '';

                  return GestureDetector(
                    onLongPress: () {
                      _deleteEvent(events[index].id);
                    },
                    onTap: () {
                      _showEventDetails(imageUrl, title, description, link);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (imageUrl.isNotEmpty)
                              Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                            SizedBox(height: 10),
                            Text(title),
                            SizedBox(height: 10),
                            Text(description),
                            SizedBox(height: 10),
                            Text(link),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Failed to fetch events');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class MainDrawer extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        const DrawerHeader(

          decoration: BoxDecoration(
            color: Colors.deepOrange,
          ), //BoxDecoration
          child: UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.deepOrange),
            accountName: Text(
              "Username",
              style: TextStyle(fontSize: 18),
            ),
            accountEmail: Text("username@gmail.com"),
            currentAccountPictureSize: Size.square(50),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "U",
                style: TextStyle(fontSize: 30.0, color: Colors.blue),
              ), //Text
            ), //circleAvatar
          ), //UserAccountDrawerHeader
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.manage_accounts_rounded,weight: 20),
            title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.settings, weight: 20),
            title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: ()
            {
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.contact_support, weight: 20),
            title: Text("Contact Us", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.shopping_cart,weight: 20,),
            title: Text("Share", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => BuyPage()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: InkWell(
            child: Text('About Us',
                textAlign: TextAlign.center
            ),
            onTap: (){
            },
          ),
        ),
      ],

    );
  }
}
