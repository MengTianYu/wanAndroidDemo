import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/page/AboutAuthorPage.dart';
import 'package:flutterapp/page/FirstTab.dart';
import 'package:flutterapp/page/FourTab.dart';
import 'package:flutterapp/page/LoginPage.dart';
import 'package:flutterapp/page/MyIntegralPage.dart';
import 'package:flutterapp/page/RegistPage.dart';
import 'package:flutterapp/page/SecondTab.dart';
import 'package:flutterapp/page/SetThemePage.dart';
import 'package:flutterapp/page/ThirdTab.dart';
import 'package:flutterapp/page/WebViewPage.dart';
import 'package:flutterapp/page/home_page.dart';
import 'package:flutterapp/page/welPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Util/data_utils.dart';
import 'Util/event_bus.dart';
import 'Util/theme_utils.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    if (true) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor themeColor = ThemeUtils.currentColorTheme;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) => {
          DataUtils.sp = value,
          DataUtils.getColorThemeIndex().then((index) {
            if (index != null) {
              ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
              eventBus.fire(ChangeThemeEvent(ThemeUtils.supportColors[index]));
            }
          })
        });
    eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false; //显示布局边界
    return RefreshConfiguration(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //显示右上角debug图标
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new MyHomePage(),
          '/firstTab': (BuildContext context) => new FirstTab(),
          '/secondTab': (BuildContext context) => new SecondTab(),
          '/thirdTab': (BuildContext context) => new ThirdTab(),
          '/fourTab': (BuildContext context) => new FourTab(),
          '/login': (BuildContext context) => new LoginPage(),
          '/regist': (BuildContext context) => new RegistPage(),
          '/about_author': (BuildContext context) => new AboutAuthorPage(),
          '/set_theme': (BuildContext context) => new SetThemePage(),
          '/my_integral': (BuildContext context) => new MyIntegralPage(),
          '/webview': (BuildContext context) => new WebViewPage(),

        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: themeColor,
          platform: TargetPlatform.iOS,
        ),
        home: new welPage(),
      ),
    );
  }
}
