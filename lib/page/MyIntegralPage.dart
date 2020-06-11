import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Util/data_utils.dart';
import 'package:flutterapp/bean/CoinBean.dart';
import 'package:flutterapp/bean/UserInfo.dart';
import 'package:flutterapp/bloc/UserInfoBLoC.dart';
import 'package:flutterapp/http/DioUtils.dart';
import 'package:flutterapp/http/HttpApi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyIntegralPage extends StatefulWidget {
  @override
  _MyIntegralPageState createState() => _MyIntegralPageState();
}

class _MyIntegralPageState extends State<MyIntegralPage> {
  RefreshController controller = new RefreshController();
  int page = 1;
  List<DatasListBean> list = new List();


  UserInfoBLoC _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的积分"),
        actions: [
          IconButton(icon: Icon(Icons.playlist_play), onPressed: () {})
        ],
      ),
      body: Container(
        child: SmartRefresher(
          controller: controller,
          header: WaterDropHeader(),
          footer: ClassicFooter(),
          enablePullUp: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.separated(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: 120,
                    child: Center(
                      child: StreamBuilder(
                        builder: (c,   AsyncSnapshot<UserInfoDataBean> s) {
                          return Text("等级 ${s.data.level}   排名 ${s.data.rank}   积分 ${s.data.coinCount}",
                              style: TextStyle(color: Colors.white));
                        },
                        stream: _bloc.stream_counter,
                      ),
                    ),
                  );
                }
                return Card(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil.getInstance().setWidth(20),
                        ScreenUtil.getInstance().setWidth(10),
                        ScreenUtil.getInstance().setWidth(20),
                        ScreenUtil.getInstance().setWidth(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("用户: "+list[index - 1].userName),
                            Text("总积分: "+list[index - 1].coinCount.toString()),
                          ],
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(30)),
                        Text(list[index - 1].desc),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(height: index == 0 ? 0 : 1);
              },
              itemCount: list.length + 1),
        ),
      ),
    );
  }

  void _onRefresh() {
    page = 1;
    _getIntegral();
    controller.refreshCompleted();
  }

  void _onLoading() {
    page++;
    _getIntegral();
    controller.loadComplete();
  }

  void _getIntegral() {
    DioUtils.getInstance().get(
        HttpApi.coin_list.replaceAll("page", page.toString()), null, (data) {
      CoinBean coinBean = CoinBean.fromJson(data);
      if (page == 1) {
        list.clear();
      }
      if (this.mounted) {
        setState(() {
          list.addAll(coinBean.data.datas);
        });
      }
    }, (error) {
      Fluttertoast.showToast(msg: error);
    });
  }


}
