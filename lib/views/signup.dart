import 'package:flutter/material.dart';
import 'package:we_talk/services/auth.dart';
import 'package:we_talk/widget/widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMetods authMetods = new AuthMetods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMetods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        print("$val");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: isLoading
            ? Container(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : SingleChildScrollView(
                child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                    validator: (val) {
                                      return val.isEmpty || val.length < 3
                                          ? "Enter Username 3+ characters"
                                          : null;
                                    },
                                    controller: userNameTextEditingController,
                                    style: simpleTextStyle(),
                                    decoration:
                                        textFieldInputDecoration('username')),
                                TextFormField(
                                    validator: (val) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val)
                                          ? null
                                          : "Enter correct email";
                                    },
                                    controller: emailTextEditingController,
                                    style: simpleTextStyle(),
                                    decoration:
                                        textFieldInputDecoration('email')),
                                TextFormField(
                                    validator: (val) {
                                      return val.length < 6
                                          ? "Enter Password 6+ characters"
                                          : null;
                                    },
                                    obscureText: true,
                                    controller: passwordTextEditingController,
                                    style: simpleTextStyle(),
                                    decoration:
                                        textFieldInputDecoration('password'))
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
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
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
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
                        'Sign up With Google',
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
                          " have any account?",
                          style: meidumTextStyle(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sign In Now",
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
