import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/Authenticate/Autheticate.dart';
import 'package:first/Authenticate/LoginScree.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/assets/icon_updated.png');
}

main() async{
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
    String? uid;
    uid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 80),
              Container(
                child:CircleAvatar(
                  radius: 100,
                  foregroundImage: AssetImage('assets/Icon/icon.jpg'),),
              ),
              Text('Fi-ster',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
              SizedBox(height: 50),
              Container(
                width: 150,
                height: 70,
                color: Colors.white,
                child: ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => Authenticate()));}
                  , child: Text("Let's Start!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),),
              ),
              SizedBox(height: 50),
              Text('By Team Fi-ster',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            ]),
      ),
    );
  }
}