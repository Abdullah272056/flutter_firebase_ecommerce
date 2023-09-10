import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ecommerce/common/toast.dart';
import 'package:flutter_firebase_ecommerce/ui/registration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../common/loading_dialog.dart';
import '../const/Colors.dart';
import 'home_screen.dart';





class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}



class _LogInScreenState extends State<LogInScreen> {
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool _isObscure = true;
  String _userId = "";

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
                margin:   EdgeInsets.only(top: 50.0.h, bottom: 40.0.h),
                child: Image.asset(
                  "assets/images/logo1.png",
                  width: 120.w,
                  height: 140.h,
                  fit: BoxFit.fill,
                ),
              ),

              Expanded(
                child: _buildBottomDesign(),

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
          borderRadius:   BorderRadius.only(
            topLeft: Radius.circular(30.0.r),
            topRight: Radius.circular(30.0.r),
          ),
        ),
        child: Padding(
            padding:
              EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w, bottom: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: text_color,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

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
                              Navigator.push(context,CupertinoPageRoute(builder:(_)=> RegistrationScreen()));
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
            showLoadingDialog(context,"Checking...");
            signIn(email: emailTxt, password: passwordTxt);
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
      showToastShort("Email can't empty");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(email)) {
      Fluttertoast.cancel();
      showToastShort("Enter valid email");
      return;
    }

    if (password.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Password can't empty");
      return;
    }
    if (password.length < 8) {
      Fluttertoast.cancel();
      showToastShort("Password must be 8 character");
      return;
    }

    return false;
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
           EdgeInsets.only(left: 25.0.w, top: 0.h, bottom: 0.h, right: 10.w),
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
            suffixIcon:IconButton(
                color: MyAppColor.bg_color,
                icon:
                Icon( Icons.email_outlined ,
                  size: 25.h,
                ),
                onPressed: () {

                }),

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
                Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
                size: 25.h,

                ),
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



  signIn({required String email,required String password})async{

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      var authCredential=userCredential.user;
      Navigator.pop(context);
      if(authCredential!.uid.isNotEmpty){


        Navigator.push(context,CupertinoPageRoute(builder:(_)=> HomeScreen()));

      }else{
        showToastShort("Something is wrong!");
      }


    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showToastShort('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToastShort('Wrong password provided for that user.');
      }
    } catch (e) {

      print(e);
    }

  }





}
