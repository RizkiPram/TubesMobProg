import 'package:flutter/material.dart';
import 'package:we_talk1/helper/authenticate.dart';
import 'package:we_talk1/helper/helperfunctions.dart';
import 'package:we_talk1/views/ChatRoomScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          primarySwatch: Colors.blue,
          fontFamily: "OverpassRegular",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: userIsLoggedIn != null
            ? userIsLoggedIn
                ? ChatRoom()
                : Authenticate()
            : Container(
                child: Center(
                  child: Authenticate(),
                ),
              ));
  }
}
