class SongUrlModel {
  SongUrlModel({
    this.code,
    this.data,
  });
  int? code;
  List<Data>? data;
  
  SongUrlModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }
}

class Data {
  Data({
    this.id,
    this.url,
    this.br,
    this.size,
    this.md5,
    this.code,
    this.expi,
    this.type,
    this.gain,
    this.peak,
    this.fee,
    this.payed,
    this.flag,
    this.canExtend,
    this.freeTrialInfo,
    this.level,
    this.encodeType,
    this.freeTrialPrivilege,
    this.freeTimeTrialPrivilege,
    this.urlSource,
    this.rightSource,
    this.time,
  });
  int? id;
  String? url;
  int? br;
  int? size;
  String? md5;
  int? code;
  int? expi;
  String? type;
  double? gain;
  int? peak;
  int? fee;
  int? payed;
  int? flag;
  bool? canExtend;
  FreeTrialInfo? freeTrialInfo;
  String? level;
  String? encodeType;
  FreeTrialPrivilege? freeTrialPrivilege;
  FreeTimeTrialPrivilege? freeTimeTrialPrivilege;
  int? urlSource;
  int? rightSource;
  int? time;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    url = json['url'];
    br = json['br'];
    size = json['size'];
    md5 = json['md5'];
    code = json['code'];
    expi = json['expi'];
    type = json['type'];
    gain = json['gain'];
    peak = json['peak'];
    fee = json['fee'];
    payed = json['payed'];
    flag = json['flag'];
    canExtend = json['canExtend'];
    level = json['level'];
    encodeType = json['encodeType'];
    freeTrialPrivilege = FreeTrialPrivilege?.fromJson(json['freeTrialPrivilege']);
    freeTimeTrialPrivilege = FreeTimeTrialPrivilege?.fromJson(json['freeTimeTrialPrivilege']);
    urlSource = json['urlSource'];
    rightSource = json['rightSource'];
    time = json['time'];
    if(json['freeTrialInfo'] != null){
      freeTrialInfo = FreeTrialInfo?.fromJson(json['freeTrialInfo']);
    }
  }

}

class FreeTrialInfo {
  FreeTrialInfo({
    this.fragmentType,
    this.start,
    this.end,
  });
  int? fragmentType;
  int? start;
  int? end;
  
  FreeTrialInfo.fromJson(Map<String, dynamic> json){
    fragmentType = json['fragmentType'];
    start = json['start'];
    end = json['end'];
  }

}

class FreeTrialPrivilege {
  FreeTrialPrivilege({
    this.resConsumable,
    this.userConsumable,
  });
  bool? resConsumable;
  bool? userConsumable;
  
  FreeTrialPrivilege.fromJson(Map<String, dynamic> json){
    resConsumable = json['resConsumable'];
    userConsumable = json['userConsumable'];
  }

}

class FreeTimeTrialPrivilege {
  FreeTimeTrialPrivilege({
    this.resConsumable,
    this.userConsumable,
    this.type,
    this.remainTime,
  });
  bool? resConsumable;
  bool? userConsumable;
  int? type;
  int? remainTime;
  
  FreeTimeTrialPrivilege.fromJson(Map<String, dynamic> json){
    resConsumable = json['resConsumable'];
    userConsumable = json['userConsumable'];
    type = json['type'];
    remainTime = json['remainTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['resConsumable'] = resConsumable;
    data['userConsumable'] = userConsumable;
    data['type'] = type;
    data['remainTime'] = remainTime;
    return data;
  }
}