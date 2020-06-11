import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp/bean/ArticleListBean.dart';
import 'package:flutterapp/bean/BannerBean.dart';
import 'package:flutterapp/bean/TopArticleListBean.dart';
import 'package:flutterapp/bean/WebBean.dart';
import 'package:flutterapp/http/DioUtils.dart';
import 'package:flutterapp/http/HttpApi.dart';
import 'package:flutterapp/weigth/CommonLoading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'HomeBanner.dart';

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  List<DataListBean> banner = new List();
  List<DatasListBean> arlist = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    if (swiperController != null) {
      swiperController.startAutoplay();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (swiperController != null) {
      swiperController.stopAutoplay();
      swiperController = null;
    }
  }

  SwiperController swiperController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        title: Text('首页'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: new Column(
        children: banner.length > 0 && arlist.length > 0
            ? <Widget>[
                HomeBanner(data: banner),
                new Expanded(
                    child: new SmartRefresher(
                  enablePullUp: true,
                  onRefresh: _onRefresh,
                  onLoading: _loading,
                  controller: _refreshController,
                  child: ListView.builder(
                    itemBuilder: (context, i) => new Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/webview",arguments: new WebBean(arlist[i].title,arlist[i].link));
                        },
                        child: new Container(
                          padding: EdgeInsets.all(
                              ScreenUtil.getInstance().setWidth(20)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Html(
                                  data: arlist[i].title == null
                                      ? ""
                                      : arlist[i].title,
                                  customTextStyle: (node, TextStyle baseStyle) {
                                    return baseStyle.merge(TextStyle(
                                        fontSize: ScreenUtil.getInstance()
                                            .setSp(40)));
                                  },
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(25),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        arlist[i].fresh != null &&
                                                arlist[i].fresh
                                            ? Text(
                                                "最新 ",
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )
                                            : Container(),
                                        arlist[i].type != null &&
                                                arlist[i].type != 0
                                            ? Text(
                                                "置顶 ",
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )
                                            : Container(),
                                        (arlist[i].author != null &&
                                                    arlist[i].author != "") ||
                                                arlist[i].shareUser != null &&
                                                    arlist[i].shareUser != ""
                                            ? Text(
                                                arlist[i].author != null &&
                                                        arlist[i].author != ""
                                                    ? arlist[i].author
                                                    : arlist[i].shareUser,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    arlist[i].niceDate != null &&
                                            arlist[i].niceDate != ""
                                        ? Text(
                                            arlist[i].niceDate,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        : Container(),
                                  ],
                                )
                              ]),
                        ),
                      ),
                    ),
                    itemCount: arlist.length,
                  ),
                ))
              ]
            : <Widget>[
                CommonLoading(),
              ],
      ),
    );
  }

  void init() async {
    swiperController = new SwiperController();
    _refreshController = new RefreshController();
    if (banner.length <= 0) {
      getBanner();
    }
    if (arlist.length <= 0) {
      _onRefresh();
    }
  }

  void getBanner() async {
    await DioUtils.getInstance().get(HttpApi.banner, null, (data) {
      BannerBean bean = BannerBean.fromJson(data);
      if (this.mounted) {
        setState(() {
          banner.clear();
          bean.data.forEach((f) {
            banner.add(f);
          });
        });
      }
    }, (error) {
      print(error);
    });
  }

  int _page = 0;
  RefreshController _refreshController;

  void _getArticleList() async {
    if (_page == 0) {
      arlist.clear();
      await DioUtils.getInstance().get(HttpApi.articleTopList, null, (data) {
        TopArticleListBean top = TopArticleListBean.fromJson(data);
        if (this.mounted) {
          setState(() {
            arlist.addAll(top.data);
          });
        }
      }, (error) {
        print(error);
      });
    }
    await DioUtils.getInstance()
        .get(HttpApi.articleList + _page.toString() + "/json", null, (data) {
      ArticleListBean bean = ArticleListBean.fromJson(data);
      if (this.mounted) {
        setState(() {
          arlist.addAll(bean.data.datas);
        });
      }
    }, (error) {
      print(error);
    });
  }

  void _onRefresh() async {
    _page = 0;
    _getArticleList();
    _refreshController.refreshCompleted();
  }

  void _loading() async {
    _page++;
    _getArticleList();
    _refreshController.loadComplete();
  }
}
