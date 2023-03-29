import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'dart:async';
import 'buy_sell.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  final pdfs = ['assets/SE_AI-DS_Curriculam_2021_28.06.2021.pdf',
                'assets/IOT.pdf',
                'assets/MIS.pdf',
                'assets/Stat.pdf',
                'assets/SE.pdf',
                'assets/DSA.pdf'];

  final title = ['SE AI&DS Syllabus',
                 'Internet Of Things',
                 'Management Information System',
                 'Statistics',
                 'Software Engineering',
                 'Data Structures and Algorithms'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fi-Ster',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),),
      ),
           body: Stack(
             children: [ SingleChildScrollView(
              physics: BouncingScrollPhysics(),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                      child: Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('Study Material',style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                      ],
                  ),
                  ),
                  ),
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIcon: Icon(Icons.search,color: Colors.grey.shade600,size:20),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text(title[0]),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_) => PDFViewerFromAsset(pdfAssetPath: pdfs[0])));
                        },
                        trailing: Text('AI&DS',style: TextStyle(fontSize: 11)),
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text(title[1]),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_) => PDFViewerFromAsset(pdfAssetPath: pdfs[1])));
                        },
                        trailing: Text('AI&DS',style: TextStyle(fontSize: 11)),
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text(title[2]),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_) => PDFViewerFromAsset(pdfAssetPath: pdfs[2])));
                        },
                        trailing: Text('AI&DS',style: TextStyle(fontSize: 11)),
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text(title[3]),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_) => PDFViewerFromAsset(pdfAssetPath: pdfs[3])));
                        },
                        trailing: Text('AI&DS',style: TextStyle(fontSize: 11)),
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text(title[4]),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_) => PDFViewerFromAsset(pdfAssetPath: pdfs[4])));
                        },
                        trailing: Text('AI&DS',style: TextStyle(fontSize: 11)),
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.picture_as_pdf),
                        title: Text(title[5]),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_) => PDFViewerFromAsset(pdfAssetPath: pdfs[5])));
                        },
                        trailing: Text('AI&DS',style: TextStyle(fontSize: 11)),
                      ),
                      SizedBox(height: 300),
                    ],
                  ),
                     ),
               Positioned(
                 bottom: 16,
                 right: 16,
                 child:
                    FloatingActionButton(
                         child: Icon(Icons.shopping_cart),
                         onPressed: (){
                           Navigator.push(context,MaterialPageRoute(builder: (context) => BuyPage()));
                         },
                       ),
                     ),
            ],
           ),
    );
  }
}


class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key? key, required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Asset'),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(snapshot.data!),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  child: const Text('-'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  child: const Text('+'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages = await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}