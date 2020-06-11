
class BaseData  {
  dynamic data;
  String errorMsg;
  int errorCode;

  BaseData({this.data, this.errorMsg, this.errorCode});

  BaseData.fromJson(Map<String, dynamic> json) {
    this.data = json['data'];
    this.errorMsg = json['errorMsg'];
    this.errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['errorMsg'] = this.errorMsg;
    data['errorCode'] = this.errorCode;
    return data;
  }

}
