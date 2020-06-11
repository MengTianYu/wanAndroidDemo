import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Util/data_utils.dart';
import 'package:flutterapp/Util/event_bus.dart';
import 'package:flutterapp/Util/theme_utils.dart';
import 'package:flutterapp/bean/BaseData.dart';
import 'package:flutterapp/bean/LoginBean.dart';
import 'package:flutterapp/http/DioUtils.dart';
import 'package:flutterapp/http/HttpApi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  bool _showpass = false, isonlogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isonlogin,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588136407455&di=5cb261f79fd9a7624ad30626295c2beb&imgtype=0&src=http%3A%2F%2Fpic.616pic.com%2Fbg_w1180%2F00%2F15%2F59%2FXfSK9dknn5.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenUtil.getInstance().setHeight(500)),
              Text("玩Android",
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              SizedBox(height: ScreenUtil.getInstance().setHeight(200)),
              Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenUtil.getInstance().setWidth(80),
                    0,
                    ScreenUtil.getInstance().setWidth(80),
                    0),
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil.getInstance().setWidth(80),
                    ScreenUtil.getInstance().setWidth(40),
                    ScreenUtil.getInstance().setWidth(80),
                    ScreenUtil.getInstance().setWidth(40)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: namecontroller,
                      maxLines: 1,
                      style: TextStyle(color: Colors.blue),
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                        LengthLimitingTextInputFormatter(20)
                      ],
                      decoration: InputDecoration(
                          hintText: "请输入用户名", border: InputBorder.none),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                    Divider(
                      height: 1.0,
                      color: Colors.red,
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                    TextField(
                      obscureText: !_showpass,
                      controller: passcontroller,
                      maxLines: 1,
                      style: TextStyle(color: Colors.blue),
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                        LengthLimitingTextInputFormatter(20)
                      ],
                      decoration: InputDecoration(
                          hintText: "请输入密码",
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showpass = !_showpass;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              color: _showpass ? Colors.blue : Colors.grey,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil.getInstance().setHeight(80)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text("注册"),
                    color: ThemeUtils.currentColorTheme,
                    textColor: Colors.white,
                    onPressed: _regist,
                  ),
                  SizedBox(
                    width: ScreenUtil.getInstance().setWidth(200),
                  ),
                  RaisedButton(
                    child: Text("登录"),
                    color: ThemeUtils.currentColorTheme,
                    textColor: Colors.white,
                    onPressed: _loging,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  //登录
  void _loging() async {
    setState(() {
      isonlogin = true;
    });
    Map<String, dynamic> map = new Map();
    map.putIfAbsent("username", () => namecontroller.text);
    map.putIfAbsent("password", () => passcontroller.text);
//    map.putIfAbsent("username", () => "qq617433927");
//    map.putIfAbsent("password", () =>  "mengtianyu");

    DioUtils.getInstance().post(HttpApi.login, map, (data) {
      LoginBean bean = LoginBean.fromJson(data);
      DataUtils.saveLoginInfo(bean);
      Navigator.of(context).pop();
      eventBus.fire(LoginEvent());
      Fluttertoast.showToast(msg: "登录成功！");
      setState(() {
        isonlogin = false;
      });
    }, (error) {
      Fluttertoast.showToast(msg: error);
      setState(() {
        isonlogin = false;
      });
    });
  }

  //注册
  void _regist() async {
    LoginBean data =
        await Navigator.of(context).pushNamed("/regist") as LoginBean;
    setState(() {
      namecontroller.text = data.data.username;
      passcontroller.text = data.data.password;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    namecontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }
}
