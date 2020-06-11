class CoinBean {
  String errorMsg;
  int errorCode;
  DataBean data;

  CoinBean({this.errorMsg, this.errorCode, this.data});

  CoinBean.fromJson(Map<String, dynamic> json) {    
    this.errorMsg = json['errorMsg'];
    this.errorCode = json['errorCode'];
    this.data = json['data'] != null ? DataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorMsg'] = this.errorMsg;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

}

class DataBean {
  bool over;
  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  List<DatasListBean> datas;

  DataBean({this.over, this.curPage, this.offset, this.pageCount, this.size, this.total, this.datas});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.over = json['over'];
    this.curPage = json['curPage'];
    this.offset = json['offset'];
    this.pageCount = json['pageCount'];
    this.size = json['size'];
    this.total = json['total'];
    this.datas = (json['datas'] as List)!=null?(json['datas'] as List).map((i) => DatasListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over'] = this.over;
    data['curPage'] = this.curPage;
    data['offset'] = this.offset;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    data['datas'] = this.datas != null?this.datas.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class DatasListBean {
  String desc;
  String reason;
  String userName;
  int coinCount;
  int id;
  int type;
  int userId;
  num date;

  DatasListBean({this.desc, this.reason, this.userName, this.coinCount, this.id, this.type, this.userId, this.date});

  DatasListBean.fromJson(Map<String, dynamic> json) {    
    this.desc = json['desc'];
    this.reason = json['reason'];
    this.userName = json['userName'];
    this.coinCount = json['coinCount'];
    this.id = json['id'];
    this.type = json['type'];
    this.userId = json['userId'];
    this.date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['reason'] = this.reason;
    data['userName'] = this.userName;
    data['coinCount'] = this.coinCount;
    data['id'] = this.id;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['date'] = this.date;
    return data;
  }
}
