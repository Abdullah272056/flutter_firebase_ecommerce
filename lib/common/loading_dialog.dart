import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/Colors.dart';

void showLoadingDialog(BuildContext context,String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 20),
            child:Column(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height:45.w,
                  width: 45.w,
                  margin: EdgeInsets.only(top: 10.h),
                  child: CircularProgressIndicator(
                    backgroundColor: MyAppColor.bg_color.withOpacity(0.1),
                    color: MyAppColor.bg_color,
                    strokeWidth: 6.h,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child:Text(
                    message,
                    style:   TextStyle(fontSize: 22.sp,color: text_color),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

