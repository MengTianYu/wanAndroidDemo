class LoginBean {
  String errorMsg;
  int errorCode;
  DataBean data;

  LoginBean({this.errorMsg, this.errorCode, this.data});

  LoginBean.fromJson(Map<String, dynamic> json) {
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
  String email;
  String icon;
  String nickname;
  String password;
  String publicName;
  String token;
  String username;
  bool admin;
  int id;
  int type;

  DataBean({this.email, this.icon, this.nickname, this.password, this.publicName, this.token, this.username, this.admin, this.id, this.type});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.email = json['email'];
    this.icon = json['icon'];
    this.nickname = json['nickname'];
    this.password = json['password'];
    this.publicName = json['publicName'];
    this.token = json['token'];
    this.username = json['username'];
    this.admin = json['admin'];
    this.id = json['id'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['icon'] = this.icon;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['publicName'] = this.publicName;
    data['token'] = this.token;
    data['username'] = this.username;
    data['admin'] = this.admin;
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
