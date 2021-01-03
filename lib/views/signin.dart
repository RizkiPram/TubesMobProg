import 'package:flutter/material.dart';
import 'package:we_talk/widget/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextField(
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration('email')),
              TextField(
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration('password')),
              SizedBox(
                height: 8,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Forgot Password?",
                      style: simpleTextStyle(),
                    ),
                  )),
              SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xff007EF4),
                      const Color(0xff2A75BC)
                    ]),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'Sign In With Google',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "don't have any account?",
                    style: meidumTextStyle(),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Register Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline),
                  )
                ],
              )
            ],
          ),
        )));
  }
}
