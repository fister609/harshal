import 'package:first/widgets/conversationList.dart';
import 'package:flutter/material.dart';
import 'models/chatUsersModel.dart';
List<ChatUsers> chatUsers = [
  ChatUsers(name: "Nishant Shinde", messageText: "Awesome Setup", imageURL: "https://th.bing.com/th/id/OIP.ilt044P14cs9JJ73WxZl8gHaF7?pid=ImgDet&rs=1", time: "Now"),
  ChatUsers(name: "Pratik Wangaskar", messageText: "Hello Bhava!", imageURL: "https://th.bing.com/th/id/OIP.ilt044P14cs9JJ73WxZl8gHaF7?pid=ImgDet&rs=1", time: "Yesterday"),
  ChatUsers(name: "Raj Shinde", messageText: "Contact me urgent", imageURL: "https://th.bing.com/th/id/OIP.ilt044P14cs9JJ73WxZl8gHaF7?pid=ImgDet&rs=1", time: "14 Feb"),
  ChatUsers(name: "Mahesh Shriram", messageText: "Meet me at 5", imageURL: "https://th.bing.com/th/id/OIP.ilt044P14cs9JJ73WxZl8gHaF7?pid=ImgDet&rs=1", time: "Now"),
  ChatUsers(name: "Ashish Ransing", messageText: "...", imageURL: "https://th.bing.com/th/id/OIP.ilt044P14cs9JJ73WxZl8gHaF7?pid=ImgDet&rs=1", time: "Now"),
  ChatUsers(name: "Siddheya Lohar", messageText: "I like someone 🤫", imageURL: "https://th.bing.com/th/id/OIP.ilt044P14cs9JJ73WxZl8gHaF7?pid=ImgDet&rs=1", time: "Now"),

];
String title = '';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.deepOrange,
              title: Title(color: Colors.white, child: Text('Fi-ster',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),),
              elevation: 3,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Chats',style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                      Container(
                        padding: EdgeInsets.only(top: 2,bottom: 2,left: 8,right: 8),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:Colors.pink[50],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add,color: Colors.pink,size: 20),
                            SizedBox(width:20),
                            Text('Add new',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                          ]
                        ),
                      )
                    ]
                )
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
            ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  title = chatUsers[index].name;
                  return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageURL: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
    );

    },
            ),
            SizedBox(height: 300),
          ],
        ),
      ),
    );
  }
}

