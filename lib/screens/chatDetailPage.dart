import 'package:flutter/material.dart';
import 'package:first/chat.dart';
import 'package:first/models/chatUsersModel.dart';
import 'package:first/models/chatMessages.dart';
class ChatDetailPage extends StatefulWidget {
  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Nishant Shinde", messageText: "Awesome Setup", imageURL: "images/userImage1.jpeg", time: "Now"),
    ChatUsers(name: "Pratik Wangaskar", messageText: "Awesome Setup", imageURL: "images/userImage1.jpeg", time: "Yesterday"),
    ChatUsers(name: "Raj Shinde", messageText: "Awesome Setup", imageURL: "images/userImage1.jpeg", time: "14 Feb"),
    ChatUsers(name: "Mahesh Shriram", messageText: "Awesome Setup", imageURL: "images/userImage1.jpeg", time: "Now"),
    ChatUsers(name: "Ashish Ransing", messageText: "Awesome Setup", imageURL: "images/userImage1.jpeg", time: "Now"),
    ChatUsers(name: "Siddheya Lohar", messageText: "Awesome Setup", imageURL: "images/userImage1.jpeg", time: "Now"),

  ];

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrangeAccent,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://th.bing.com/th/id/OIP.ilt044P14cs9JJ73WxZl8gHaF7?pid=ImgDet&rs=1"),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(title,style: TextStyle(color: Colors.black, fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.greenAccent, fontSize: 12),),
                      ],
                    ),
                  ),
                  Icon(Icons.settings,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.send,color: Colors.white,size: 20,),
                    backgroundColor: Colors.deepOrangeAccent,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
      );
  }
}
