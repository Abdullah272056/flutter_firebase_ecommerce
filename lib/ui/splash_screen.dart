import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../const/Colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late String userId;



  @override
  @mustCallSuper
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColor.bg_color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              "My Ecommerce",
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 35.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
              height: 45.h,
              width: 45.h,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3.w,

              ),
            )




          ],
        ),
      )
    );
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



}
