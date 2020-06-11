import 'package:flutter/cupertino.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget widget;

  //构造方法
  CustomRoute(this.widget)
      : super(
            transitionDuration: Duration(milliseconds: 600), //过渡时间
            pageBuilder: (
              //构造器
              BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
            ) {

              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return FadeTransition(
//          turns: Tween(begin: 0.0,end: 1.0)
//          scale: Tween(begin: 0.0,end: 1.0)
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation1,
                  curve: Curves.fastOutSlowIn, //动画曲线
                )),
                child: child,
              );
            });
}
