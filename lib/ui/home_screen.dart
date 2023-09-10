import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../const/Colors.dart';
import 'log_in.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
              "Home Screen",
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 35.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),





          ],
        ),
      )
    );
  }





}
