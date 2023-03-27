import 'package:flutter/material.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fi-Ster',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),),
        ),
      body: Container(
        child: Center(
          child: Text('Study Page')
        )
      )
    );
  }
}
