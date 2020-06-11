import 'dart:async';

import 'package:flutterapp/bean/LoginBean.dart';
import 'package:flutterapp/http/DioUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {
  static const String SP_COLOR_THEME_INDEX = "colorThemeIndex";

  //用户信息字段
  static const String SP_USERNAME = 'username';
  static const String SP_PASSWORD = 'password';

  static const String SP_IS_LOGIN = "isLogin";
  static const String SP_ADMIN = "admin";
  static const String SP_CHAPTERTOPS = "chapterTops";
  static const String SP_COLLECTIDS = "collectIds";
  static const String SP_EMAIL = "email";
  static const String SP_ICON = "icon";
  static const String SP_ID = "id";
  static const String SP_NICKNAME = "nickname";
  static const String SP_password = "password";
  static const String SP_PUBLICNAME = "publicName";
  static const String SP_TOKEN = "token";
  static const String SP_TYPE = "type";
  static const String SP_username = "username";
  static const String SP_COOKIE = "Cookie";

  // 设置选择的主题色
  static setColorTheme(int colorThemeIndex) async {
    sp.setInt(SP_COLOR_THEME_INDEX, colorThemeIndex);
  }

  static Future<int> getColorThemeIndex() async {
    int i=sp.getInt(SP_COLOR_THEME_INDEX);
    if(i!=null){
      return i;
    }
    return 0;
  }

  //是否登录
  static Future<bool> isLogin() async {
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    return isLogin != null && isLogin;
  }

  //是否登录
  static bool isLoginna()  {
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    return isLogin != null && isLogin;
  }

  //登录成功
  static void saveLoginInfo(LoginBean bean) {
    sp
      ..setString(SP_USERNAME, bean.data.username)
      ..setString(SP_PASSWORD, bean.data.password)
      ..setString(SP_ICON, bean.data.icon)
      ..setString(SP_PUBLICNAME, bean.data.publicName)
      ..setBool(SP_ADMIN, bean.data.admin)
      ..setString(SP_EMAIL, bean.data.email)
      ..setInt(SP_ID, bean.data.id)
      ..setString(SP_TOKEN, bean.data.token)
      ..setBool(SP_IS_LOGIN, true)
      ..setString(SP_NICKNAME, bean.data.nickname);
  }

  //登录成功
  static void clearLoginInfo() {
    sp
      ..setString(SP_USERNAME, null)
      ..setString(SP_PASSWORD, null)
      ..setString(SP_ICON, null)
      ..setString(SP_PUBLICNAME, null)
      ..setBool(SP_ADMIN, null)
      ..setString(SP_EMAIL, null)
      ..setInt(SP_ID, null)
      ..setString(SP_TOKEN, null)
      ..setBool(SP_IS_LOGIN, false)
      ..setString(SP_NICKNAME, null);
    saveCookie(null);
    DioUtils.getInstance().clearCookie();
  }

  //登录成功
  static LoginBean getLoginInfo() {
    if (!sp.getBool(SP_IS_LOGIN)) {
      return null;
    }
    LoginBean loginBean = new LoginBean();
    loginBean.data = new DataBean();
    loginBean.data.admin = sp.getBool(SP_ADMIN);
    loginBean.data.email = sp.getString(SP_EMAIL);
    loginBean.data.icon = sp.getString(SP_ICON);
    loginBean.data.id = sp.getInt(SP_ID);
    loginBean.data.nickname = sp.getString(SP_NICKNAME);
    loginBean.data.password = sp.getString(SP_password);
    loginBean.data.publicName = sp.getString(SP_PUBLICNAME);
    loginBean.data.token = sp.getString(SP_TOKEN);
    loginBean.data.type = sp.getInt(SP_TYPE);
    loginBean.data.username = sp.getString(SP_username);
    return loginBean;
  }

  static SharedPreferences sp;

  //保存cookie
  static void saveCookie(List<String> cookie) {
    sp..setStringList(SP_COOKIE, cookie);
  }

  //获取cookie
  static List<String> getCookie() {
    return sp.getStringList(SP_COOKIE);
  }
}
