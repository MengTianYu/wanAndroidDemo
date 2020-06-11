

import 'ArticleListBean.dart';

class TopArticleListBean {
  List<DatasListBean> data;

  TopArticleListBean({this.data});

  TopArticleListBean.fromJson(Map<String, dynamic> json) {    
    this.data = (json['data'] as List)!=null?(json['data'] as List).map((i) => DatasListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data != null?this.data.map((i) => i.toJson()).toList():null;
    return data;
  }

}

