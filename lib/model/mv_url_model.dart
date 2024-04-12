class MvUrlModel {
  MvUrlModel({
    this.code,
    this.data,
  });
  int? code;
  Data? data;
  
  MvUrlModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    this.id,
    this.url,
    this.r,
    this.size,
    this.md5,
    this.code,
    this.expi,
    this.fee,
    this.mvFee,
    this.st,
    this.msg,
  });
  int? id;
  String? url;
  int? r;
  int? size;
  String? md5;
  int? code;
  int? expi;
  int? fee;
  int? mvFee;
  int? st;
  String? msg;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    url = json['url'];
    r = json['r'];
    size = json['size'];
    md5 = json['md5'];
    code = json['code'];
    expi = json['expi'];
    fee = json['fee'];
    mvFee = json['mvFee'];
    st = json['st'];
    msg = json['msg'];
  }
}