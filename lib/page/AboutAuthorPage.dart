

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Util/theme_utils.dart';
import 'package:flutterapp/constant/Constant.dart';

class AboutAuthorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于作者"),
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(10),
                ScreenUtil.getInstance().setWidth(50),
                ScreenUtil.getInstance().setWidth(10),
                ScreenUtil.getInstance().setWidth(50)),
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: ScreenUtil.getInstance().setWidth(280),
                  height: ScreenUtil.getInstance().setWidth(280),
                  child: ClipOval(
                    child: Image(
                        image: NetworkImage(
                            "http://b-ssl.duitang.com/uploads/item/201702/17/20170217221145_aMtmh.jpeg")),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setWidth(50),
                ),
                Text(
                  "TianYu",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.getInstance().setSp(80)),
                ),
                ListTile(
                  leading: Icon(
                    Constant.github,
                    color: Colors.black,
                  ),
                  title: Text("Github"),
                  trailing: Text("https://github.com/MengTianYu"),
                ),
                ListTile(
                  leading: Icon(
                    Constant.csdn,
                    color: Colors.red,
                  ),
                  title: Text("CDSD"),
                  trailing: Text("https://blog.csdn.net/yunyuliunian"),
                ),
                ListTile(
                  leading: Icon(
                    Constant.wx,
                    color: Colors.green,
                  ),
                  title: Text("微信"),
                  trailing: Text("TianYu_miss_you"),
                ),
                ListTile(
                  leading: Icon(
                    Constant.aixin,
                    color: Colors.red,
                  ),
                  title: Text("请我喝咖啡"),
                  trailing: Text("对你有用的话就点击吧!"),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Container(
                            width: double.infinity,
                            height: ScreenUtil.getInstance().setWidth(530),
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        ScreenUtil.getInstance().setWidth(80),
                                        ScreenUtil.getInstance().setWidth(20),
                                        ScreenUtil.getInstance().setWidth(80),
                                        0),
                                    height:
                                    ScreenUtil.getInstance().setWidth(130),
                                    width: double.infinity,
                                    child: FlatButton(shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25))
                                    ),
                                        onPressed: ()=>_showPayPic(context,0),
                                        color: Colors.white,
                                        child: Text("支付宝"))),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        ScreenUtil.getInstance().setWidth(80),
                                        0,
                                        ScreenUtil.getInstance().setWidth(80),
                                        0),
                                    height:
                                    ScreenUtil.getInstance().setWidth(130),
                                    width: double.infinity,
                                    child: FlatButton(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),)
                          ),
                                        onPressed:()=>_showPayPic(context,1),
                                        color: Colors.white,
                                        child: Text("微信"))),
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        ScreenUtil.getInstance().setWidth(80),
                                        ScreenUtil.getInstance().setWidth(80),
                                        ScreenUtil.getInstance().setWidth(80),
                                        ScreenUtil.getInstance().setWidth(20)),
                                    height:
                                    ScreenUtil.getInstance().setWidth(130),
                                    width: double.infinity,
                                    child: FlatButton(shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(35),
                                          bottomRight: Radius.circular(35),
                                          topLeft: Radius.circular(35),
                                          topRight: Radius.circular(35))
                                    ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: Colors.white,
                                        child: Text("取消"))),
                              ],
                            ),
                          );
                        },
                        isDismissible: true,
                        barrierColor: Colors.black26,
                        backgroundColor: Colors.transparent);
                  },
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                    EdgeInsets.all(ScreenUtil.getInstance().setWidth(80)),
                    child: Image(
                        image: AssetImage("assetss/images/we_chart_mark.jpg")),
                  ),
                )
              ],
            ));
      }),
    );
  }

  _showPayPic(BuildContext context,int type){
    Navigator.pop(context);
    showModalBottomSheet(context: context, builder: (_){
      return Container(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(100)),
        height: ScreenUtil.getInstance().setWidth(1000),
        width: double.infinity,
        child: Image(image: AssetImage(type==0?"assetss/images/alipay.jpg":"assetss/images/we_chart_pay.jpg")),
      );
    });
  }
}
