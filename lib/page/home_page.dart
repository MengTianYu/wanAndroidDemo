import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Util/CustomRoute.dart';
import 'package:flutterapp/page/FirstTab.dart';
import 'package:flutterapp/page/SecondTab.dart';
import 'package:flutterapp/page/ThirdTab.dart';
import 'package:flutterapp/weigth/NavigationIconView.dart';

import 'FourTab.dart';

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{


  int _currentIndex = 0;

  List<Widget> list = List();

  @override
  void initState() {
    // TODO: implement initState
    list.clear();
    list.add(new FirstTab());
    list.add(new SecondTab());
    list.add(new ThirdTab());
    list.add(new FourTab());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("流云"),
              accountEmail: new Text('617433927@qq.com'),
              currentAccountPicture: new GestureDetector(
                onTap: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: new Text("头像被点击了"),
                    action: new SnackBarAction(
                        label: "撤销",
                        onPressed: () {
                          print("撤销");
                        }),
                  ));
                },
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      "https://upload.jianshu.io/users/upload_avatars/7700793/dbcf94ba-9e63-4fcf-aa77-361644dd5a87?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"),
                ),
              ),
            ),
            new ListTile(
              title: new Text("First Page"),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new CustomRoute(new FourTab()));
              },
            ),
            new ListTile(
              title: new Text("Second Page"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/four");//arguments: testpush("第二个")
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("close"),
              trailing: new Icon(Icons.cancel),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        children: list,
        index: _currentIndex,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: <NavigationIconView>[
          new NavigationIconView(icon: new Icon(Icons.home),title: new Text("首页"),vsync:this),
          new NavigationIconView(icon: new Icon(Icons.perm_contact_calendar),title: new Text("项目"),vsync:this),
          new NavigationIconView(icon: new Icon(Icons.account_balance_wallet),title: new Text("公众号"),vsync:this),
          new NavigationIconView(icon: new Icon(Icons.person),title: new Text("我的"),vsync:this),
        ].map((e) => e.item).toList(),
        currentIndex: _currentIndex, // 当前点击的索引值
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          // 添加点击事件
          setState(() {
            // 点击之后，需要触发的逻辑事件
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
