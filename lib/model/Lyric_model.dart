class LyricModel {
  LyricModel({
    this.sgc,
    this.sfy,
    this.qfy,
    this.lyricUser,
    this.lrc,
    this.tlyric,
    this.romalrc,
    this.code,
  });
  bool? sgc;
  bool? sfy;
  bool? qfy;
  LyricUser? lyricUser;
  Lrc? lrc;
  Tlyric? tlyric;
  Romalrc? romalrc;
  int? code;
  
  LyricModel.fromJson(Map<String, dynamic>? json){
    if(json != null){
      sgc = json['sgc'];
      sfy = json['sfy'];
      qfy = json['qfy'];
      lyricUser = LyricUser.fromJson(json['lyricUser']);
      lrc = Lrc.fromJson(json['lrc']);
      tlyric = Tlyric.fromJson(json['tlyric']);
      romalrc = Romalrc.fromJson(json['romalrc']);
      code = json['code'];
    }
  }
}

class LyricUser {
  LyricUser({
    this.id,
    this.status,
    this.demand,
    this.userid,
    this.nickname,
    this.uptime,
  });
  int? id;
  int? status;
  int? demand;
  int? userid;
  String? nickname;
  int? uptime;
  
  LyricUser.fromJson(Map<String, dynamic>? json){
    if(json != null){
      id = json['id'];
      status = json['status'];
      demand = json['demand'];
      userid = json['userid'];
      nickname = json['nickname'];
      uptime = json['uptime'];
    }
  }
}

class Lrc {
  Lrc({
    this.version,
    this.lyric,
  });
  int? version;
  String? lyric;
  
  Lrc.fromJson(Map<String, dynamic>? json){
    if(json != null){
      version = json['version'];
      lyric = json['lyric'];
    }
  }
}

class Tlyric {
  Tlyric({
    this.version,
    this.lyric,
  });
  int? version;
  String? lyric;
  
  Tlyric.fromJson(Map<String, dynamic>? json){
    if(json != null){
      version = json['version'];
      lyric = json['lyric'];
    }
  }
}

class Romalrc {
  Romalrc({
    this.version,
    this.lyric,
  });
  int? version;
  String? lyric;
  
  Romalrc.fromJson(Map<String, dynamic>? json){
    if(json != null){
      version = json['version'];
      lyric = json['lyric'];
    }
  }
}