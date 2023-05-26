import 'package:first/Authenticate/Methods.dart';
import 'package:first/Screens/ChatRoom.dart';
import 'package:first/group_chats/group_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with WidgetsBindingObserver {
  List<Map<String, dynamic>> userList = [];
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
    getUsersList();
  }

  void setStatus(String status) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void getUsersList() async {
    setState(() {
      isLoading = true;
    });

    QuerySnapshot querySnapshot =
    await _firestore.collection('users').get();

    setState(() {
      userList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        title: Text(
          "Chat Room",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logOut(context),
          )
        ],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];

                if (user['uid'] == _auth.currentUser!.uid) {
                  // Skip the current user's profile
                  return Container();
                }

                return ListTile(
                  onTap: () {
                    String roomId = chatRoomId(
                      _auth.currentUser!.displayName!,
                      user['name'] ?? '', // Handle null value here
                    );

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ChatRoom(
                          chatRoomId: roomId,
                          userMap: user,
                        ),
                      ),
                    );
                  },
                  leading: Icon(Icons.account_box, color: Colors.black),
                  title: Text(
                    user['name'] ?? '', // Handle null value here
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(user['email'] ?? ''), // Handle null value here
                  trailing: user['status'] == 'Online'
                      ? Icon(Icons.circle, color: Colors.green)
                      : Icon(Icons.circle, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.group),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GroupChatHomeScreen(),
          ),
        ),
      ),
    );
  }
}