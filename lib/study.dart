import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class StudyApp extends StatefulWidget {
  const StudyApp({Key? key}) : super(key: key);

  @override
  State<StudyApp> createState() => _StudyAppState();
}

class _StudyAppState extends State<StudyApp> {
  String url = '';
  int? number;
  uploadDataToFirebase() async{
    //generate random number
    number = Random().nextInt(10);
    //pick pdf file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = basename(pick.path);
    //upload pdf file to firebase
    var pdfFile = FirebaseStorage.instance.ref().child(name).child("/.pdf");
    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    //upload url to cloud firebase
    await FirebaseFirestore.instance.collection("file").doc().set({
      'fileUrl':url,
      'num':name,
    });



// Delete the file

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Study Material',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: () {// method to show the search bar
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("file").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,i){
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                    return ListTile(
                      title: Text(x['num']),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => View(url: x['fileUrl'],)));
                      },
                      onLongPress: (){

                      },
                      trailing: Text('AI&DS'),
                      /*child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(x['num']),*/
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(onPressed: uploadDataToFirebase,child: Icon(Icons.add),),
    );
  }
}

class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;
  View({this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}
