import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Util/data_utils.dart';
import 'package:flutterapp/http/HttpApi.dart';
import 'package:flutterapp/http/ResultCode.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DioUtils {
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;
  bool _isDebug = true;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';

  static DioUtils _instance;

  static DioUtils getInstance() {
    if (_instance == null) {
      _instance = DioUtils();
    }
    return _instance;
  }

  Dio _dio = new Dio();

  DioUtils() {
    // Set default configs

    List<String> cookie;
    cookie = DataUtils.getCookie();
    if (cookie != null) {
      for (String s in cookie) {
        _dio.options.headers.putIfAbsent("cookie", () => s);
      }
    }
    _dio.options.baseUrl = HttpApi.baseUrl;
    _dio.options.connectTimeout = CONNECT_TIMEOUT;
    _dio.options.receiveTimeout = RECEIVE_TIMEOUT;
    _dio.interceptors.add(LogInterceptor(responseBody: true)); //是否开启请求日志'
  }

  void clearCookie() {
    _dio.options.headers.remove("cookie");
  }

  //get请求
  get(String url, Map<String, dynamic> params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, GET, params, errorCallBack);
  }

  //post请求
  post(String url, Map<String, dynamic> params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, POST, params, errorCallBack);
  }

  _requstHttp(String url, Function successCallBack,
      [String method,
      Map<String, dynamic> params,
      Function errorCallBack]) async {
    Response response;
    try {
      if (method == 'get') {
        if (params != null && params.isNotEmpty) {
          response = await _dio.get(url, queryParameters: params);
        } else {
          response = await _dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null && params.isNotEmpty) {
          response = await _dio.post(url, queryParameters: params);
        } else {
          response = await _dio.post(url);
        }
      }
    } on DioError catch (error) {
      // 请求错误处理
      if (error.response != null) {
        response = error.response;
      } else {
        response = new Response(statusCode: 666);
      }
      // 请求超时
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        response.statusCode = ResultCode.CONNECT_TIMEOUT;
      }
      // 一般服务器错误
      else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        response.statusCode = ResultCode.RECEIVE_TIMEOUT;
      }

      // debug模式才打印
      if (_isDebug) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ' + _dio.options.headers.toString());
        print('method: ' + _dio.options.method);
      }
      _error(errorCallBack, error.message);
      return '';
    }
    // debug模式打印相关数据
    if (_isDebug) {
      print('请求url: ' + url);
      print('请求头: ' + _dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        debugPrint('返回参数: ' +response.toString().replaceAll("{", "\n{"));
      }
    }
    Map<String, dynamic> dataMap = jsonDecode(response.toString());
    if (dataMap == null || dataMap['state'] == 0 || dataMap['errorCode'] != 0) {
      print(HttpApi.baseUrl + url + "    " + dataMap['errorMsg']);
      _error(errorCallBack, dataMap['errorMsg']);
    } else if (successCallBack != null) {
      if (HttpApi.login == url) {
        List<String> list = response.headers["set-cookie"].toList();
        for (String s in list) {
          _dio.options.headers.putIfAbsent("cookie", () => s);
        }
        DataUtils.saveCookie(list);
      }
      successCallBack(dataMap);
    }
  }

  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }


}
