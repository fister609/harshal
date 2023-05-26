
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:first/buy_sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'Search.dart';
import 'study.dart';
import 'profile.dart';
import 'package:first/About.dart';
import 'calendar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first/Authenticate/Autheticate.dart';
import 'package:first/Screens/HomeScreen.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/assets/icon_updated.png');
}

Future main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
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
        pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: ZoomPageTransitionsBuilder(),}),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Fi-ster Project',
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          children: [
            Lottie.network('https://assets7.lottiefiles.com/private_files/lf30_nzzpyr6i.json',frameRate: FrameRate(100),delegates: LottieDelegates()),
            Text('Fi-ster',style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20))
          ],
        ),
        backgroundColor: Colors.white,
        duration: 2500 ,
        nextScreen: Authenticate(),
        splashIconSize: 300,
        splashTransition: SplashTransition.scaleTransition,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageindex = 2;
  final pages = [BuyPage(), StudyApp(),EventsPage(),HomeScreen(),GFG()];
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
class EventsPage extends StatefulWidget
{
  @override
  State<EventsPage> createState() => _EventsPageState();

}

class _EventsPageState extends State<EventsPage>
{
  var links = ['https://docs.google.com/forms/d/e/1FAIpQLSfvlqt3GGY9LC6niCDYhIg6HGY0scMqdHa0GXD3ScdcnA4uzg/viewform?usp=sf_link'];
  int size =5;
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
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.deepOrange,
                  title: Title(color: Colors.white, child: Text('Fi-ster',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => CalendarPage()));
                      }, icon: Icon(Icons.calendar_month, weight: 20)),

                    ),],
                  elevation: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("UPCOMING EVENTS",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                ),
                for(int i =0;i<10;i++)
                  InkWell(
                    onTap: (){
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                          return Center(
                            child: Container(
                              width: 350,
                              height: 600,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 3),
                                      image: const DecorationImage(image: NetworkImage('https://th.bing.com/th/id/OIP.Ds3CCuq5tFOXLNRrFncUIQHaEB?w=318&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
                                              fit: BoxFit.fill)
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text("Event Name: ",style: TextStyle(color: Colors.black, fontSize: 15,decorationColor: Colors.white)),
                                  SizedBox(height: 30),
                                  Text('Description: ',style: TextStyle(color: Colors.black, fontSize: 15,decorationColor: Colors.white)),
                                  SizedBox(height: 30),
                                  Linkify(
                                      onOpen: (link) async {
                                        if (await canLaunch(link.url)) {
                                          await launch(link.url);
                                        } else {
                                          throw 'Could not launch $link';
                                        }
                                      },
                                      text: "Register: - https://forms.gle/nVpCvy1GKNCH4TkY8",
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black,decorationColor: Colors.white),
                                      linkStyle: TextStyle(fontSize: 15,color: Colors.blueAccent,decorationColor: Colors.white),
                                    ),
                                  SizedBox(height: 30),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Close"),
                                  ),
                                ],),
                            ),);
                        },);},
                    child: Container(
                      margin: EdgeInsets.all(15),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7),),
                        border: Border.all(width: 3),
                        image: const DecorationImage(image: NetworkImage('https://th.bing.com/th/id/OIP.Ds3CCuq5tFOXLNRrFncUIQHaEB?w=318&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
                                fit: BoxFit.cover)
                      ),
                    ),
                  ),

                SizedBox(height: 10),

              ],
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
