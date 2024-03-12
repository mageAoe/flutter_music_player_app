class PlaylistTrackAllModel {
  PlaylistTrackAllModel({
    this.songs,
    this.code,
  });
  List<Songs>? songs;
  int? code;
  
  PlaylistTrackAllModel.fromJson(Map<String, dynamic> json){
    songs = List.from(json['songs']).map((e)=>Songs.fromJson(e)).toList();
    code = json['code'];
  }
}

class Songs {
  Songs({
    this.name,
    this.id,
    this.pst,
    this.t,
    this.ar,
    this.alia,
    this.pop,
    this.st,
    this.rt,
    this.fee,
    this.v,
    this.cf,
    this.al,
    this.dt,
    // this.h,
    // this.m,
    this.l,
    // this.sq,
    this.cd,
    this.no,
    this.ftype,
    this.rtUrls,
    this.djId,
    this.copyright,
    this.sId,
    this.mark,
    this.originCoverType,
    this.resourceState,
    this.version,
    this.single,
    this.mv,
    this.mst,
    this.cp,
    this.rtype,
    this.publishTime,
    this.tns,
  });
  String? name;
  int? id;
  int? pst;
  int? t;
  List<Ar>? ar;
  List<String>? alia;
  int? pop;
  int? st;
  String? rt;
  int? fee;
  int? v;
  String? cf;
  Al? al;
  int? dt;
  // H? h;
  // M? m;
  L? l;
  // Sq? sq;
  String? cd;
  int? no;
  int? ftype;
  List<dynamic>? rtUrls;
  int? djId;
  int? copyright;
  int? sId;
  int? mark;
  int? originCoverType;
  bool? resourceState;
  int? version;
  int? single;
  int? mv;
  int? mst;
  int? cp;
  int? rtype;
  int? publishTime;
  List<String>? tns;
  
  Songs.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['id'];
    pst = json['pst'];
    t = json['t'];
    ar = List.from(json['ar']).map((e)=>Ar.fromJson(e)).toList();
    alia = List.castFrom<dynamic, String>(json['alia']);
    pop = json['pop'];
    st = json['st'];
    rt = json['rt'];
    fee = json['fee'];
    v = json['v'];
    cf = json['cf'];
    al = Al.fromJson(json['al']);
    dt = json['dt'];
    // h = H.fromJson(json['h']);
    // m = M.fromJson(json['m']);
    l = L.fromJson(json['l']);
    // sq = Sq.fromJson(json['sq']);
    cd = json['cd'];
    no = json['no'];
    ftype = json['ftype'];
    rtUrls = List.castFrom<dynamic, dynamic>(json['rtUrls']);
    djId = json['djId'];
    copyright = json['copyright'];
    sId = json['s_id'];
    mark = json['mark'];
    originCoverType = json['originCoverType'];
    resourceState = json['resourceState'];
    version = json['version'];
    single = json['single'];
    mv = json['mv'];
    mst = json['mst'];
    cp = json['cp'];
    rtype = json['rtype'];
    publishTime = json['publishTime'];
    // tns = List.castFrom<dynamic, String>(json['tns']);
    if (json['tns'] != null) {
      tns = <String>[];
      json['tns'].forEach((v) {
        tns!.add(v);
      });
    }
  }
}

class Ar {
  Ar({
    this.id,
    this.name,
    this.tns,
    this.alias,
  });
  int? id;
  String? name;
  List<dynamic>? tns;
  List<dynamic>? alias;
  
  Ar.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    tns = List.castFrom<dynamic, dynamic>(json['tns']);
    alias = List.castFrom<dynamic, dynamic>(json['alias']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tns'] = tns;
    data['alias'] = alias;
    return data;
  }
}

class Al {
  Al({
    this.id,
    this.name,
    this.picUrl,
    this.tns,
    this.picStr,
    this.pic,
  });
  int? id;
  String? name;
  String? picUrl;
  List<dynamic>? tns;
  String? picStr;
  int? pic;
  
  Al.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    tns = List.castFrom<dynamic, dynamic>(json['tns']);
    picStr = json['pic_str'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['picUrl'] = picUrl;
    data['tns'] = tns;
    data['pic_str'] = picStr;
    data['pic'] = pic;
    return data;
  }
}

class H {
  H({
    this.br,
    this.fid,
    this.size,
    this.vd,
    this.sr,
  });
  int? br;
  int? fid;
  int? size;
  int? vd;
  int? sr;
  
  H.fromJson(Map<String, dynamic> json){
    br = json['br'];
    fid = json['fid'];
    size = json['size'];
    vd = json['vd'];
    sr = json['sr'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    data['sr'] = sr;
    return data;
  }
}

class M {
  M({
    this.br,
    this.fid,
    this.size,
    this.vd,
    this.sr,
  });
  int? br;
  int? fid;
  int? size;
  int? vd;
  int? sr;
  
  M.fromJson(Map<String, dynamic> json){
    br = json['br'];
    fid = json['fid'];
    size = json['size'];
    vd = json['vd'];
    sr = json['sr'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    data['sr'] = sr;
    return data;
  }
}

class L {
  L({
    this.br,
    this.fid,
    this.size,
    this.vd,
    this.sr,
  });
  int? br;
  int? fid;
  int? size;
  int? vd;
  int? sr;
  
  L.fromJson(Map<String, dynamic> json){
    br = json['br'];
    fid = json['fid'];
    size = json['size'];
    vd = json['vd'];
    sr = json['sr'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    data['sr'] = sr;
    return data;
  }
}

class Sq {
  Sq({
    this.br,
    this.fid,
    this.size,
    this.vd,
    this.sr,
  });
  int? br;
  int? fid;
  int? size;
  int? vd;
  int? sr;
  
  Sq.fromJson(Map<String, dynamic> json){
    br = json['br'];
    fid = json['fid'];
    size = json['size'];
    vd = json['vd'];
    sr = json['sr'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    data['sr'] = sr;
    return data;
  }
}
