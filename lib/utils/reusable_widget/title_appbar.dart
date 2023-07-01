import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

PreferredSizeWidget? titleAppbar(String title){
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.colorBlackHighEmp,
      ),
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: AppColors.colorWhiteHighEmp,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
