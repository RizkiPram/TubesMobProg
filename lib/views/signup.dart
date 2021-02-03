import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_talk1/helper/helperfunctions.dart';
import 'package:we_talk1/services/auth.dart';
import 'package:we_talk1/services/database.dart';
import 'package:we_talk1/widget/widget.dart';

import 'ChatRoomScreen.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthMethod authMethod = new AuthMethod();
  DatabaseMethod databaseMethod = new DatabaseMethod();

  signUp() async {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameController.text,
        "email": emailController.text
      };
      SharedPreferences.setMockInitialValues({});
      HelperFunctions.saveUserLoggedInSharedPreference(true);
      HelperFunctions.saveUserNameSharedPreference(usernameController.text);
      HelperFunctions.saveUserEmailSharedPreference(emailController.text);

      setState(() {
        isLoading = true;
      });
      authMethod
          .signUpWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((val) {
        //print("$val");

        databaseMethod.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.lightBlueAccent, Colors.purpleAccent])),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 50,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (val) {
                                  return val.isEmpty || val.length < 3
                                      ? "please provide Username"
                                      : null;
                                },
                                controller: usernameController,
                                style: simpleTextStyle(),
                                decoration: textFieldDecoration("username"),
                              ),
                              TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Enter correct email";
                                },
                                controller: emailController,
                                style: simpleTextStyle(),
                                decoration: textFieldDecoration("email"),
                              ),
                              TextFormField(
                                validator: (val) {
                                  return val.length < 6
                                      ? "Enter Password 6+ characters"
                                      : null;
                                },
                                obscureText: true,
                                controller: passwordController,
                                style: simpleTextStyle(),
                                decoration: textFieldDecoration("password"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Forgot password ?",
                                style: simpleTextStyle(),
                              ),
                            )),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            signUp();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color(0xff007EF4),
                                  const Color(0xff2A75BC)
                                ]),
                                borderRadius: BorderRadius.circular(40)),
                            child: Text(
                              "Sign Up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            "Sign Up With Google",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "have any account?",
                              style: simpleTextStyle(),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text("  SignIn now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
