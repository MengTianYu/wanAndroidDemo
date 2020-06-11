import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Util/CustomDialog.dart';
import 'package:flutterapp/Util/data_utils.dart';
import 'package:flutterapp/Util/event_bus.dart';
import 'package:flutterapp/bean/LoginBean.dart';
import 'package:flutterapp/bean/UserInfo.dart';
import 'package:flutterapp/bloc/UserInfoBLoC.dart';
import 'package:flutterapp/http/DioUtils.dart';
import 'package:flutterapp/http/HttpApi.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FourTab extends StatefulWidget {
  @override
  _FourTabState createState() => _FourTabState();
}

class _FourTabState extends State<FourTab> {
  String userAvatar;
  String userName;

  List menuTitles = [
    "我的积分",
    "我的收藏",
    "我的博客",
    "主题设置",
    "关于作者",
    "退出登录",
  ];

  List menuIcons = [
    Icons.message,
    Icons.map,
    Icons.account_balance_wallet,
    Icons.settings,
    Icons.info,
    Icons.backspace
  ];

  UserInfoBLoC bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          new Padding(
            padding: new EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Icon(Icons.assessment),
          )
        ],
      ),
      body: buildListView(),
    );
  }

  Container TopContainer() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().setWidth(40),
                bottom: ScreenUtil.getInstance().setWidth(70)),
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    DataUtils.isLogin().then((value) => value
                        ? null
                        : Navigator.of(context).pushNamed("/login"));
                  },
                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(200),
                    height: ScreenUtil.getInstance().setWidth(200),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 0),
                        image: DecorationImage(
                            image: userAvatar == null || userAvatar == ""
                                ? AssetImage("assetss/images/ic_head.jpeg")
                                : NetworkImage(userAvatar),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                Text(userName ??= "未登录", style: TextStyle(color: Colors.white)),
                SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                StreamBuilder(
                initialData: UserInfoDataBean(),
                  builder: (c, AsyncSnapshot<UserInfoDataBean> s) {
                      return s.data.level==null? Container():Text(
                          "等级 ${s.data.level}   排名 ${s.data.rank}   积分 ${s.data.coinCount}",
                          style: TextStyle(color: Colors.white));
                  },
                  stream: bloc.stream_counter,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView buildListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return TopContainer();
          }
          return ListTile(
            leading: new Icon(menuIcons[index - 1]),
            title: new Text(menuTitles[index - 1]),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () {
              switch (index) {
                case 1:
                  DataUtils.isLogin().then((value) => value
                      ? Navigator.of(context).pushNamed("/my_integral")
                      : Navigator.of(context).pushNamed("/login"));
                  break;
                case 2:
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                      timeInSecForIos: 1,
                      msg: menuTitles[index - 1],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER);
                  break;
                case 3:
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                      msg: menuTitles[index - 1],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER);
                  break;
                case 4:
                  Navigator.of(context).pushNamed("/set_theme");
                  break;
                case 5:
                  Navigator.of(context).pushNamed("/about_author");
                  break;
                case 6:
                  _LoginOut();
                  break;
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
          );
        },
        itemCount:
            DataUtils.isLoginna() ? menuIcons.length + 1 : menuIcons.length);
  }

  void _LoginOut() {
    showDialog(
        barrierDismissible: false,
        context: context,
        child: CustomDialog(
            txt: "是否确认退出登录",
            pCallBack: () {
              DioUtils.getInstance().get(HttpApi.logout, null, (data) {
                DataUtils.clearLoginInfo();
                _getUserinfo();
                Fluttertoast.showToast(msg: "退出");
              }, (error) {
                Fluttertoast.showToast(msg: error);
              });
            },
            calCallBack: () {}));
  }

  void _getUserinfo() {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        LoginBean loginBean = DataUtils.getLoginInfo();
        if (this.mounted) {
          setState(() {
            userAvatar = loginBean.data.icon;
            userName = loginBean.data.username;
          });
        }
        bloc.getUserinfo();
      } else {
        setState(() {
          userAvatar = null;
          userName = null;
        });
        bloc.clearUserinfo();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = new UserInfoBLoC();
    _getUserinfo();
    eventBus.on<LoginEvent>().listen((event) {
      _getUserinfo();
    });
    eventBus.on<LogoutEvent>().listen((event) {
      _getUserinfo();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }
}
