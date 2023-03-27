import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'study.dart';
import 'chat.dart';
import 'profile.dart';
import 'package:first/About.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Fi-ster Project',
      home: const HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageindex = 1;
  final pages = [const StudyPage(),EventsPage(),const ChatPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:pages[pageindex],
        bottomNavigationBar: buildMyNavBar(context),
    );
  }
  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.deepOrangeAccent,blurRadius: 5,blurStyle: BlurStyle.solid)],
        border: Border.all(color: Colors.deepOrangeAccent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageindex = 0;
              });
            },
            icon: pageindex == 0
                ? const Icon(
              Icons.menu_book,
              color: Colors.deepOrangeAccent,
              size: 40,
            )
                : const Icon(
              Icons.menu_book_outlined,
              color: Colors.grey,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageindex = 1;
              });
            },
            icon: pageindex == 1
                ? const Icon(
              Icons.home,
              color: Colors.deepOrangeAccent,
              size: 40,
            )
                : const Icon(
              Icons.home_outlined,
              color: Colors.grey,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageindex = 2;
              });
            },
            icon: pageindex == 2
                ? const Icon(
              Icons.chat,
              color: Colors.deepOrangeAccent,
              size: 40,
            )
                : const Icon(
              Icons.chat_outlined,
              color: Colors.grey,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
class EventsPage extends StatefulWidget
{
  @override
  State<EventsPage> createState() => _EventsPageState();

}

class _EventsPageState extends State<EventsPage>
{
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }
  void _resetSelectedDate(){
    _selectedDate = DateTime.now().add(const Duration(days: 2),);
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Title(color: Colors.white, child: Text('Fi-ster',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: () {}, icon: Icon(Icons.search, weight: 20)),
            ),
          ],
          elevation: 3,
        ),
        drawer: Drawer(
          child: MainDrawer(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("UPCOMING EVENTS",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 11,top: 11),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            border: Border.all(width: 3),
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 11,top: 11),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            border: Border.all(width: 3),
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 11, top: 11),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            border: Border.all(width: 3),
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 11, top: 11),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            border: Border.all(width: 3),
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("RECENT EVENTS",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 11,top: 11),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            border: Border.all(width: 3),
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 11,top: 11),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            border: Border.all(width: 3),
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 11, top: 11),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            border: Border.all(width: 3),
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 11, top: 11),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            border: Border.all(width: 3),
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.transparent,
                       borderRadius: BorderRadius.circular(7),
                       border: Border.all(width: 3,style: BorderStyle.solid),
                     ),
                     child: ListTile(
                         leading: Icon(Icons.calendar_month,weight: 20),
                         title: Text('EVENTS CALENDAR',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                   ),
                 ) ,
                  SizedBox(
                    height: 20,
                  ),
                 Container(
                   height: 200,
                   width: 380,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                     border: Border.all(width: 3,style: BorderStyle.solid),
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: CalendarTimeline(
                         showYears: true,
                         initialDate: _selectedDate,
                         firstDate: DateTime.now(),
                         lastDate: DateTime.now().add(const Duration(days: 365*4)),
                         onDateSelected: (date) => setState(()   =>_selectedDate = date),
                         monthColor: Colors.black,
                         dayColor: Colors.black,
                         dayNameColor: Colors.greenAccent,
                         activeDayColor: Colors.deepOrangeAccent,
                         activeBackgroundDayColor: Colors.black,
                         dotsColor: Colors.white,
                         selectableDayPredicate: (date) => date.day!=23,
                         locale: 'en',),
                   ),
                 ),
              ],
            ),
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
            leading: Icon(Icons.chat, weight: 20),
            title: Text("Chats", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: ()
            {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatPage()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.menu_book_sharp, weight: 20),
            title: Text("Study", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: ()
            {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => StudyPage()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.shopping_cart,weight: 20,),
            title: Text("Buy/Sell", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: ()
            {
              Navigator.pop(context);
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
              Navigator.push(context,MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
        ),
      ],

    );
  }
}

