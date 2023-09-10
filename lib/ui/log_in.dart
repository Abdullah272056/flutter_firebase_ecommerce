import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../const/Colors.dart';





class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool _isObscure = true;
  String _userId = "";
  String _accessToken1 = "";
  String _refreshToken = "";
  String _userUUId = "";
  int _darkOrLightStatus = 1;

  //social login
  // GoogleSignInAccount? _currentUser;
  Map? userData = {};
  String _contactText = '';
  String _fbName = "";
  String _fbEmail = "";

  String _gmName = "";
  String _gmEmail = "";
  @override
  void initState() {


    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          color:MyAppColor.bg_color,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 70.0, bottom: 50.0),
                child: Image.asset(
                  "assets/images/logo1.png",
                  width: 218,
                  height: 155,
                  fit: BoxFit.fill,
                ),
              ),

              Expanded(
                child: _buildBottomDesign(),
                flex: 3,
              ),
            ],
          ),
        ),

        /* add child content here */
      ),
    );
  }

  Widget _buildBottomDesign() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
          color:Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                    SizedBox(
                    height: 25.h,
                  ),
                  //dfg
                    Align(
                    alignment: Alignment.topLeft,
                    child: Text("Email",
                        style: TextStyle(
                            color:MyAppColor.level_color,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400)),
                  ),

                    SizedBox(
                    height: 10.h,
                  ),

                  userInputEmail(
                      _emailController!, 'Email', TextInputType.emailAddress),

                    SizedBox(
                    height: 5.h,
                  ),
                  //password input
                    Align(
                    alignment: Alignment.topLeft,
                    child: Text("Password",
                        style: TextStyle(
                            color: MyAppColor.level_color,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400)),
                  ),

                   SizedBox(
                    height: 10.h,
                  ),

                  userInputPassword(passwordController!, 'Password',
                      TextInputType.visiblePassword),

                  Align(
                    alignment: Alignment.topRight,
                    child: InkResponse(
                      onTap: () {

                      },
                      child: Text("Forget Password?",
                          style: TextStyle(
                              color: text_color,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                   SizedBox(
                    height: 30.h,
                  ),
                  _buildSignInButton(),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin:   EdgeInsets.only(top: 20.h, bottom: 10.h),
                      child: InkResponse(
                        onTap: () {},
                        child: Text("OR",
                            style: TextStyle(
                                color: text_color ,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin:   EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                           Text("Don't have an account?",
                              style: TextStyle(
                                  color: text_color ,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600)),
                          InkResponse(
                            onTap: () {

                            },
                            child:   Text(" Sign Up",
                                style: TextStyle(
                                    color: MyAppColor.bg_color,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _buildSignInButton() {
    return Container(
      margin:  EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: ElevatedButton(
        onPressed: () {
          String emailTxt = _emailController!.text;
          String passwordTxt = passwordController!.text;
          if (_inputValid(emailTxt, passwordTxt) == false) {
          //  _userLogIn(email: emailTxt, password: passwordTxt);
            //Navigator.push(context,MaterialPageRoute(builder: (context)=> NavigationBarScreen(0,HomeScreen()),));

          } else {}
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r))),
        child: Ink(
          decoration: BoxDecoration(
              color: MyAppColor.bg_color,
              borderRadius: BorderRadius.circular(7.0.r)),
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            child:  Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _inputValid(String email, String password) {
    if (email.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Email can't empty");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(email)) {
      Fluttertoast.cancel();
      _showToast("Enter valid email");
      return;
    }

    if (password.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Password can't empty");
      return;
    }
    if (password.length < 8) {
      Fluttertoast.cancel();
      _showToast("Password must be 8 character");
      return;
    }

    return false;
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }





  Widget userInputEmail(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55.h,
      alignment: Alignment.center,
      margin:   EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
          color:MyAppColor.input_box_bg_color,
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding:
           EdgeInsets.only(left: 25.0.w, top: 0.h, bottom: 0.h, right: 20.w),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: text_color ,
          style: TextStyle(
              color: text_color
          ),
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIconConstraints:   BoxConstraints(
              minHeight: 15.h,
              minWidth: 15.h,
            ),
            suffixIcon: Image(
              image: const AssetImage(
                'assets/images/icon_email.png',

              ),
             color:MyAppColor.bg_color,
              height: 18.h,
              width: 22.w,
              fit: BoxFit.fill,
            ),

            // suffixIcon: Icon(Icons.email,color: Colors.hint_color,),
            // color: _darkOrLightStatus==1?intello_text_color:intello_bg_color_for_dark,
            hintText: hintTitle,
            hintStyle:   TextStyle(
                fontSize: 16.sp, color: hint_color, fontStyle: FontStyle.normal),

          ),

          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget userInputPassword(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55.h,
      alignment: Alignment.center,
      margin:   EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
          color: MyAppColor.input_box_bg_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:
          EdgeInsets.only(left: 25.0.w, top: 0.h, bottom: 0.h, right: 10.w),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          obscureText: _isObscure,
          obscuringCharacter: "*",
          enableSuggestions: false,
          autofocus: false,
          cursorColor: text_color ,
          style: TextStyle(
              color: text_color
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
                color: MyAppColor.bg_color,
                icon:
                Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            hintText: hintTitle,
            hintStyle:  TextStyle(
                fontSize: 16.sp, color: hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }








}
