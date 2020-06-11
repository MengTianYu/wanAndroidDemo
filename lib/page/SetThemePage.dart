import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Util/data_utils.dart';
import 'package:flutterapp/Util/event_bus.dart';
import 'package:flutterapp/Util/theme_utils.dart';

class SetThemePage extends StatefulWidget {
  @override
  _SetThemePageState createState() => _SetThemePageState();
}

class _SetThemePageState extends State<SetThemePage> {

  List<MaterialColor> clist=ThemeUtils.supportColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置主题"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(50)),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,mainAxisSpacing: 10,crossAxisSpacing: 10
        ), itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              eventBus.fire(ChangeThemeEvent(clist[index]));
              DataUtils.setColorTheme(index);
            },
            child: Container(
              color: clist[index],
            ),
          );
        },itemCount: 10,),
      ),
    );
  }
}
