class UserInfo {
  String errorMsg;
  int errorCode;
  UserInfoDataBean data;

  UserInfo({this.errorMsg, this.errorCode, this.data});

  UserInfo.fromJson(Map<String, dynamic> json) {    
    this.errorMsg = json['errorMsg'];
    this.errorCode = json['errorCode'];
    this.data = json['data'] != null ? UserInfoDataBean.fromJson(json['data']) : null;
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

class UserInfoDataBean {
  String username;
  int coinCount;
  int level;
  String rank;
  int userId;

  UserInfoDataBean({this.username, this.coinCount, this.level, this.rank, this.userId});

  UserInfoDataBean.fromJson(Map<String, dynamic> json) {
    this.username = json['username'];
    this.coinCount = json['coinCount'];
    this.level = json['level'];
    this.rank = json['rank'];
    this.userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['coinCount'] = this.coinCount;
    data['level'] = this.level;
    data['rank'] = this.rank;
    data['userId'] = this.userId;
    return data;
  }
}
