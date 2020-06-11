import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/page/home_page.dart';

class welPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    Future.delayed(new Duration(seconds: 3),(){
      //跳转并关闭当前页面
      Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new MyHomePage()),
            (route) => route == null,
      );
    });
    return new Image.asset("assetss/images/welcome_bg.jpeg",fit: BoxFit.fill);
  }


}
