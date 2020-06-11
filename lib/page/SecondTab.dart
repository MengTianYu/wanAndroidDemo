import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Util/theme_utils.dart';
import 'package:flutterapp/bean/ProjectList.dart';
import 'package:flutterapp/bean/ProjectTree.dart';
import 'package:flutterapp/bean/WebBean.dart';
import 'package:flutterapp/http/DioUtils.dart';
import 'package:flutterapp/http/HttpApi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab>
    with SingleTickerProviderStateMixin {
  Map<String, List<DatasListBean>> data = new Map();

  List<DataListBean> treelist = new List();
  TabController mController;
  RefreshController controller = new RefreshController();
  ScrollController listviewcontroller=new ScrollController();
  int _checkIndex = 0;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProjectTree();
  }

  _onTabChanged(index) {
    if (mController.indexIsChanging) {
      if (this.mounted) {
        setState(() {
          _checkIndex = mController.index;
        });
        if (data[treelist[_checkIndex].id.toString()] == null) {
          //加载
          _onRefresh();
        }else{
          listviewcontroller.jumpTo(0);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (treelist.length > 0 && mController != null)
            ? TabBar(
                controller: mController,
                isScrollable: true,
                onTap: _onTabChanged,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicatorWeight: 2,
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                tabs: treelist.map((e) {
                  return Tab(
                    text: e.name,
                  );
                }).toList(),
              )
            : Text("项目"),
      ),
      body: Container(
        child: (treelist == null || data[treelist[_checkIndex].id.toString()] == null)
            ? Container()
            : SmartRefresher(
                header: WaterDropHeader(),
                enablePullUp: true,
                controller: controller,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.separated(
                  controller: listviewcontroller,
                    itemBuilder: (context, index) {
                      return Card(
                          child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/webview",arguments: new WebBean(data[treelist[_checkIndex].id.toString()][index].title,data[treelist[_checkIndex].id.toString()][index].link));
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                              ScreenUtil.getInstance().setWidth(20)),
                          height: ScreenUtil.getInstance().setWidth(300),
                          child: Row(
                            children: [
                              Image(
                                  width: ScreenUtil.getInstance().setWidth(140),
                                  height:
                                      ScreenUtil.getInstance().setWidth(260),
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      data[treelist[_checkIndex].id.toString()][index].envelopePic)),
                              SizedBox(
                                width: ScreenUtil.getInstance().setWidth(30),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[treelist[_checkIndex].id.toString()]
                                      [index]
                                          .title,
                                      style: TextStyle(
                                          fontSize:
                                          ScreenUtil.getInstance().setSp(40)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data[treelist[_checkIndex].id.toString()][index].author,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          data[treelist[_checkIndex].id.toString()][index].niceDate,
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0,
                        color: Colors.transparent,
                      );
                    },
                    itemCount: data[treelist[_checkIndex].id.toString()].length),
              ),
      ),
    );
  }

  void _onRefresh() {
    if (treelist.length <= 0) {
      _getProjectTree();
      return;
    }
    page = 1;
    _loadProject();
    controller.refreshCompleted();
  }

  void _onLoading() {
    page++;
    _loadProject();
    controller.loadComplete();
  }

  _loadProject() {
    DioUtils.getInstance().get(
        HttpApi.project_list
            .replaceAll("page", page.toString())
            .replaceAll("sid", treelist[_checkIndex].id.toString()),
        null, (json) {
      ProjectList projectList = ProjectList.fromJson(json);
      if (page == 1) {
        if (data[treelist[_checkIndex].id.toString()] == null) {
          data.putIfAbsent(treelist[_checkIndex].id.toString(),
              () => new List<DatasListBean>());
        }
        data[treelist[_checkIndex].id.toString()].clear();
      }
      if (this.mounted) {
        setState(() {
          data[treelist[_checkIndex].id.toString()].addAll(projectList.data.datas);
        });
      }
    }, (er) {
      Fluttertoast.showToast(msg: er);
    });
  }

  _getProjectTree() {
    DioUtils.getInstance().get(HttpApi.project_tree, null, (data) {
      ProjectTree projectTree = ProjectTree.fromJson(data);
      if (this.mounted) {
        setState(() {
          treelist.clear();
          treelist.addAll(projectTree.data);
          mController = new TabController(length: treelist.length, vsync: this);
          _onRefresh();
        });
      }
    }, (er) {
      print(er);
    });
  }
}
