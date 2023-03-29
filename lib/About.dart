import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CONTACT US',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ContactUs(
                  logo: NetworkImage("https://i.pinimg.com/736x/09/24/a7/0924a7ef295741e916c8f42512bbe5bd.jpg"),
                  companyName: 'Nishant Shinde',
                  textColor: Colors.black,
                  cardColor: Colors.orangeAccent,
                  email: 'nishant_shinde_aids@moderncoe.edu.in',
                  companyColor: Colors.black,
                  taglineColor: Colors.orangeAccent,
                  instagram: 'nishantshinde3553',
                  linkedinURL: '',
              ),
              SizedBox(height: 20),
              ContactUs(
                logo: NetworkImage("https://i.pinimg.com/736x/09/24/a7/0924a7ef295741e916c8f42512bbe5bd.jpg"),
                companyName: 'Raj Shinde',
                textColor: Colors.black,
                cardColor: Colors.orangeAccent,
                email: 'raj_shinde_aids@moderncoe.edu.in',
                companyColor: Colors.black,
                taglineColor: Colors.orangeAccent,
                instagram: 'raj_shinde_009',
                linkedinURL: '',
              ),
              SizedBox(height: 20),
              ContactUs(
                logo: NetworkImage("https://i.pinimg.com/736x/09/24/a7/0924a7ef295741e916c8f42512bbe5bd.jpg"),
                companyName: 'Mahesh Shriram',
                textColor: Colors.black,
                cardColor: Colors.orangeAccent,
                email: 'mahesh_shriram_aids@moderncoe.edu.in',
                companyColor: Colors.black,
                taglineColor: Colors.orangeAccent,
                instagram: 'mahesh__shriram',
                linkedinURL: '',
              ),
              SizedBox(height: 20),
              ContactUs(
                logo: NetworkImage("https://i.pinimg.com/736x/09/24/a7/0924a7ef295741e916c8f42512bbe5bd.jpg"),
                companyName: 'Harshal Tak',
                textColor: Colors.black,
                cardColor: Colors.orangeAccent,
                email: 'harshal_tak_aids@moderncoe.edu.in',
                companyColor: Colors.black,
                taglineColor: Colors.orangeAccent,
                instagram: 'ht.on.insta',
                linkedinURL: '',
              ),
              SizedBox(height: 20),
              ContactUs(
                logo: NetworkImage("https://i.pinimg.com/736x/09/24/a7/0924a7ef295741e916c8f42512bbe5bd.jpg"),
                companyName: 'Pratik Wangaskar',
                textColor: Colors.black,
                cardColor: Colors.orangeAccent,
                email: 'pratik_wangaskar_aids@moderncoe.edu.in',
                companyColor: Colors.black,
                taglineColor: Colors.orangeAccent,
                instagram: 'pratiknw_1711',
                linkedinURL: '',
              ),
            ],
          ),
        )
    );
  }
}
