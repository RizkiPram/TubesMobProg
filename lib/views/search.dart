import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:we_talk1/helper/constans.dart';
import 'package:we_talk1/services/database.dart';
import 'package:we_talk1/views/ConversationScreen.dart';
import 'package:we_talk1/widget/widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController searchController = new TextEditingController();
  QuerySnapshot searchSnapShot;

  initiateSearch() {
    databaseMethod.getUserByUsername(searchController.text).then((val) {
      setState(() {
        searchSnapShot = val;
      });
    });
  }

  //chatroom,send user
  createChatRoomAndStartConversation({String userName}) {
    if (userName != Constanst.myName) {
      String chatRoomId = getChatRoomId(userName, Constanst.myName);
      List<String> users = [userName, Constanst.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      DatabaseMethod().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      print("You Cannot Send Message to this username");
    }
  }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: simpleTextStyle(),
              ),
              Text(
                userEmail,
                style: simpleTextStyle(),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(35)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
  }

  Widget searchList() {
    return searchSnapShot != null
        ? ListView.builder(
            itemCount: searchSnapShot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapShot.docs[index].data()["name"],
                userEmail: searchSnapShot.docs[index].data()["email"],
              );
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "search username....",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none))),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
