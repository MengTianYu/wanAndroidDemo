import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Util/theme_utils.dart';
import 'package:flutterapp/bean/BaseData.dart';
import 'package:flutterapp/bean/LoginBean.dart';
import 'package:flutterapp/http/DioUtils.dart';
import 'package:flutterapp/http/HttpApi.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistPage extends StatefulWidget {
  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController qpassController = new TextEditingController();
  bool _showpass = false, _showqpass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: Container(
        color: Colors.white70,
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image: NetworkImage(
//                    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2216231013,1490844489&fm=26&gp=0.jpg"),
//                fit: BoxFit.fill)
//        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil.getInstance().setWidth(50),
              ScreenUtil.getInstance().setWidth(100),
              ScreenUtil.getInstance().setWidth(50),
              ScreenUtil.getInstance().setWidth(50)),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: ScreenUtil.getInstance().setWidth(180),
                    child: Text("用户名:"),
                  ),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.blue,
                height: 1,
              ),
              Row(
                children: [
                  Container(
                    width: ScreenUtil.getInstance().setWidth(180),
                    child: Text("密码:"),
                  ),
                  Expanded(
                    child: TextField(
                      obscureText: !_showpass,
                      controller: passController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showpass = !_showpass;
                              });
                            },
                            child: Icon(Icons.remove_red_eye,
                                color: _showpass ? Colors.blue : Colors.grey)),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.blue,
                height: 1,
              ),
              Row(
                children: [
                  Container(
                    width: ScreenUtil.getInstance().setWidth(180),
                    child: Text("确认密码:"),
                  ),
                  Expanded(
                    child: TextField(
                      obscureText: !_showqpass,
                      controller: qpassController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showqpass = !_showqpass;
                              });
                            },
                            child: Icon(Icons.remove_red_eye,
                                color: _showqpass ? Colors.blue : Colors.grey)),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.blue,
                height: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setHeight(100)),
              RaisedButton(
                onPressed: _registuser,
                color: ThemeUtils.currentColorTheme,
                textColor: Colors.white,
                child: Text("注册"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _registuser() async {
    Map<String, dynamic> params = new Map();
    params.putIfAbsent("username", () => nameController.text);
    params.putIfAbsent("password", () => passController.text);
    params.putIfAbsent("repassword", () => qpassController.text);
    DioUtils.getInstance().post(HttpApi.register, params, (data) {
      LoginBean baseData = LoginBean.fromJson(data);

      showDialog(
        barrierDismissible: false,
          context: context,
          child: CupertinoAlertDialog(
            content: Text("注册成功"),
            actions: [
              FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(baseData);
                  },
                  child: Text("确认"))
            ],
          ));
    }, (error) {
      Fluttertoast.showToast(msg: error);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    passController.dispose();
    qpassController.dispose();
    super.dispose();
  }
}
