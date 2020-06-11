
import 'dart:async';

import 'package:flutterapp/Util/data_utils.dart';
import 'package:flutterapp/bean/UserInfo.dart';
import 'package:flutterapp/http/DioUtils.dart';
import 'package:flutterapp/http/HttpApi.dart';

class UserInfoBLoC{

  UserInfoDataBean  _data;

  //流控制
  final _counterStreamController =new StreamController<UserInfoDataBean>.broadcast();

  //流
  Stream<UserInfoDataBean> get stream_counter=> _counterStreamController.stream;


  // 通过sink.add发布一个流事件
  void getUserinfo(){
    DioUtils.getInstance().get(HttpApi.coin, null, (data) {
      UserInfo userInfo = UserInfo.fromJson(data);
      _data=userInfo.data;
      _counterStreamController.sink.add(_data);
    }, (error) {
      DataUtils.clearLoginInfo();
    });

  }

  // 通过sink.add发布一个流事件
  void clearUserinfo(){
    _data=new UserInfoDataBean();
    _counterStreamController.sink.add(_data);
  }


  //释放流
  void dispose(){
    _counterStreamController.close();
  }

}