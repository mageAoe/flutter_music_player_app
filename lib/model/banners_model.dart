class BannersModel {
  BannersModel({
    required this.banners,
    required this.code,
  });
  late final List<Banners> banners;
  late final int code;
  
  BannersModel.fromJson(Map<String, dynamic> json){
    banners = List.from(json['banners']).map((e)=>Banners.fromJson(e)).toList();
    code = json['code'];
  }
}

class Banners {
 String? pic;
 int? targetId;
 String? mainTitle;
 String? adid;
 int? targetType;
 String? titleColor;
 String? typeTitle;
 String? url;
 String? adurlV2;
 bool? exclusive;
 String? monitorImpress;
 String? monitorClick;
 String? monitorType;
 List<dynamic>? monitorImpressList;
 List<dynamic>? monitorClickList;
 String? monitorBlackList;
 String? extMonitor;
 String? extMonitorInfo;
 String? adSource;
 String? adLocation;
 String? encodeId;
 String? program;
 String? event;
 String? video;
 String? dynamicVideoData;
//  Song? song;
 String? bannerId;
 String? alg;
 String? scm;
 String? requestId;
 bool? showAdTag;
 String? pid;
 String? showContext;
 String? adDispatchJson;
 String? sCtrp;
 String? logContext;
 String? bannerBizType;
  Banners({
     this.pic,
     this.targetId,
     this.mainTitle,
     this.adid,
     this.targetType,
     this.titleColor,
     this.typeTitle,
     this.url,
     this.adurlV2,
     this.exclusive,
     this.monitorImpress,
     this.monitorClick,
     this.monitorType,
     this.monitorImpressList,
     this.monitorClickList,
     this.monitorBlackList,
     this.extMonitor,
     this.extMonitorInfo,
     this.adSource,
     this.adLocation,
     this.encodeId,
     this.program,
     this.event,
     this.video,
     this.dynamicVideoData,
    //  this.song,
     this.bannerId,
     this.alg,
     this.scm,
     this.requestId,
     this.showAdTag,
     this.pid,
     this.showContext,
     this.adDispatchJson,
     this.sCtrp,
     this.logContext,
     this.bannerBizType,
  });
  
  Banners.fromJson(Map<String, dynamic> json){
    pic = json['pic'];
    targetId = json['targetId'];
    mainTitle = json['mainTitle'];
    adid = json['adid'];
    targetType = json['targetType'];
    titleColor = json['titleColor'];
    typeTitle = json['typeTitle'];
    url = json['url'];
    adurlV2 = json['adurlV2'];
    exclusive = json['exclusive'];
    monitorImpress = json['monitorImpress'];
    monitorClick = json['monitorClick'];
    monitorType = json['monitorType'];
    monitorImpressList = List.castFrom<dynamic, dynamic>(json['monitorImpressList']);
    monitorClickList = List.castFrom<dynamic, dynamic>(json['monitorClickList']);
    monitorBlackList = json['monitorBlackList'];
    extMonitor = json['extMonitor'];
    extMonitorInfo = json['extMonitorInfo'];
    adSource = json['adSource'];
    adLocation = json['adLocation'];
    encodeId = json['encodeId'];
    program = json['program'];
    event = json['event'];
    video = json['video'];
    dynamicVideoData = json['dynamicVideoData'];
    // song = json['song'] == null
    //       ? null
    //       : Song.fromJson(json['song']);
    bannerId = json['bannerId'];
    alg = json['alg'];
    scm = json['scm'];
    requestId = json['requestId'];
    showAdTag = json['showAdTag'];
    pid = json['pid'];
    showContext = json['showContext'];
    adDispatchJson = json['adDispatchJson'];
    sCtrp = json['s_ctrp'];
    logContext = json['logContext'];
    bannerBizType = json['bannerBizType'];
  }
}

// class Song {
//   Song({
//     required this.name,
//     required this.id,
//     required this.pst,
//     required this.t,
//     required this.ar,
//     required this.alia,
//     required this.pop,
//     required this.st,
//     required this.rt,
//     required this.fee,
//     required this.v,
//      this.crbt,
//     required this.cf,
//     required this.al,
//     required this.dt,
//     required this.h,
//     required this.m,
//     required this.l,
//      this.sq,
//      this.hr,
//      this.a,
//     required this.cd,
//     required this.no,
//      this.rtUrl,
//     required this.ftype,
//     required this.rtUrls,
//     required this.djId,
//     required this.copyright,
//     required this.sId,
//     required this.mark,
//     required this.originCoverType,
//      this.originSongSimpleData,
//      this.tagPicList,
//     required this.resourceState,
//     required this.version,
//      this.songJumpInfo,
//      this.entertainmentTags,
//     required this.single,
//      this.noCopyrightRcmd,
//     required this.mst,
//     required this.cp,
//     required this.mv,
//     required this.rtype,
//      this.rurl,
//     required this.publishTime,
//     required this.privilege,
//     required this.alg,
//   });
//   late final String name;
//   late final int id;
//   late final int pst;
//   late final int t;
//   late final List<Ar> ar;
//   late final List<dynamic> alia;
//   late final int pop;
//   late final int st;
//   late final String rt;
//   late final int fee;
//   late final int v;
//   late final String? crbt;
//   late final String cf;
//   late final Al al;
//   late final int dt;
//   late final H h;
//   late final M m;
//   late final L l;
//   late final Sq? sq;
//   late final Hr? hr;
//   late final String? a;
//   late final String cd;
//   late final int no;
//   late final String? rtUrl;
//   late final int ftype;
//   late final List<dynamic> rtUrls;
//   late final int djId;
//   late final int copyright;
//   late final int sId;
//   late final int mark;
//   late final int originCoverType;
//   late final String? originSongSimpleData;
//   late final String? tagPicList;
//   late final bool resourceState;
//   late final int version;
//   late final String? songJumpInfo;
//   late final String? entertainmentTags;
//   late final int single;
//   late final String? noCopyrightRcmd;
//   late final int mst;
//   late final int cp;
//   late final int mv;
//   late final int rtype;
//   late final String? rurl;
//   late final int publishTime;
//   late final Privilege privilege;
//   late final String alg;
  
//   Song.fromJson(Map<String, dynamic> json){
//     name = json['name'];
//     id = json['id'];
//     pst = json['pst'];
//     t = json['t'];
//     ar = List.from(json['ar']).map((e)=>Ar.fromJson(e)).toList();
//     alia = List.castFrom<dynamic, dynamic>(json['alia']);
//     pop = json['pop'];
//     st = json['st'];
//     rt = json['rt'];
//     fee = json['fee'];
//     v = json['v'];
//     crbt = json['crbt'];
//     cf = json['cf'];
//     al = Al.fromJson(json['al']);
//     dt = json['dt'];
//     h = H.fromJson(json['h']);
//     m = M.fromJson(json['m']);
//     l = L.fromJson(json['l']);
//     sq = json['sq'] == null
//           ? null
//           : Sq.fromJson(json['sq']);
//     hr = json['hr'] == null
//           ? null
//           : Hr.fromJson(json['hr']);
//     a = json['a'];
//     cd = json['cd'];
//     no = json['no'];
//     rtUrl = json['rtUrl'];
//     ftype = json['ftype'];
//     rtUrls = List.castFrom<dynamic, dynamic>(json['rtUrls']);
//     djId = json['djId'];
//     copyright = json['copyright'];
//     sId = json['s_id'];
//     mark = json['mark'];
//     originCoverType = json['originCoverType'];
//     originSongSimpleData = json['originSongSimpleData'];
//     tagPicList = json['tagPicList'];
//     resourceState = json['resourceState'];
//     version = json['version'];
//     songJumpInfo = json['songJumpInfo'];
//     entertainmentTags = json['entertainmentTags'];
//     single = json['single'];
//     noCopyrightRcmd = json['noCopyrightRcmd'];
//     mst = json['mst'];
//     cp = json['cp'];
//     mv = json['mv'];
//     rtype = json['rtype'];
//     rurl = json['rurl'];
//     publishTime = json['publishTime'];
//     privilege = Privilege.fromJson(json['privilege']);
//     alg = json['alg'];
//   }
// }

// class Ar {
//   Ar({
//     required this.id,
//     required this.name,
//     required this.tns,
//     required this.alias,
//   });
//   late final int id;
//   late final String name;
//   late final List<dynamic> tns;
//   late final List<dynamic> alias;
  
//   Ar.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//     tns = List.castFrom<dynamic, dynamic>(json['tns']);
//     alias = List.castFrom<dynamic, dynamic>(json['alias']);
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['tns'] = tns;
//     data['alias'] = alias;
//     return data;
//   }
// }

// class Al {
//   Al({
//     required this.id,
//     required this.name,
//     required this.picUrl,
//     required this.tns,
//     required this.picStr,
//     required this.pic,
//   });
//   late final int id;
//   late final String name;
//   late final String picUrl;
//   late final List<dynamic> tns;
//   late final String picStr;
//   late final int pic;
  
//   Al.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//     picUrl = json['picUrl'];
//     tns = List.castFrom<dynamic, dynamic>(json['tns']);
//     picStr = json['pic_str'];
//     pic = json['pic'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['picUrl'] = picUrl;
//     data['tns'] = tns;
//     data['pic_str'] = picStr;
//     data['pic'] = pic;
//     return data;
//   }
// }

// class H {
//   H({
//     required this.br,
//     required this.fid,
//     required this.size,
//     required this.vd,
//     required this.sr,
//   });
//   late final int br;
//   late final int fid;
//   late final int size;
//   late final int vd;
//   late final int sr;
  
//   H.fromJson(Map<String, dynamic> json){
//     br = json['br'];
//     fid = json['fid'];
//     size = json['size'];
//     vd = json['vd'];
//     sr = json['sr'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['br'] = br;
//     data['fid'] = fid;
//     data['size'] = size;
//     data['vd'] = vd;
//     data['sr'] = sr;
//     return data;
//   }
// }

// class M {
//   M({
//     required this.br,
//     required this.fid,
//     required this.size,
//     required this.vd,
//     required this.sr,
//   });
//   late final int br;
//   late final int fid;
//   late final int size;
//   late final int vd;
//   late final int sr;
  
//   M.fromJson(Map<String, dynamic> json){
//     br = json['br'];
//     fid = json['fid'];
//     size = json['size'];
//     vd = json['vd'];
//     sr = json['sr'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['br'] = br;
//     data['fid'] = fid;
//     data['size'] = size;
//     data['vd'] = vd;
//     data['sr'] = sr;
//     return data;
//   }
// }

// class L {
//   L({
//     required this.br,
//     required this.fid,
//     required this.size,
//     required this.vd,
//     required this.sr,
//   });
//   late final int br;
//   late final int fid;
//   late final int size;
//   late final int vd;
//   late final int sr;
  
//   L.fromJson(Map<String, dynamic> json){
//     br = json['br'];
//     fid = json['fid'];
//     size = json['size'];
//     vd = json['vd'];
//     sr = json['sr'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['br'] = br;
//     data['fid'] = fid;
//     data['size'] = size;
//     data['vd'] = vd;
//     data['sr'] = sr;
//     return data;
//   }
// }

// class Sq {
//   Sq({
//     required this.br,
//     required this.fid,
//     required this.size,
//     required this.vd,
//     required this.sr,
//   });
//   late final int br;
//   late final int fid;
//   late final int size;
//   late final int vd;
//   late final int sr;
  
//   Sq.fromJson(Map<String, dynamic> json){
//     br = json['br'];
//     fid = json['fid'];
//     size = json['size'];
//     vd = json['vd'];
//     sr = json['sr'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['br'] = br;
//     data['fid'] = fid;
//     data['size'] = size;
//     data['vd'] = vd;
//     data['sr'] = sr;
//     return data;
//   }
// }

// class Hr {
//   Hr({
//     required this.br,
//     required this.fid,
//     required this.size,
//     required this.vd,
//     required this.sr,
//   });
//   late final int br;
//   late final int fid;
//   late final int size;
//   late final int vd;
//   late final int sr;
  
//   Hr.fromJson(Map<String, dynamic> json){
//     br = json['br'];
//     fid = json['fid'];
//     size = json['size'];
//     vd = json['vd'];
//     sr = json['sr'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['br'] = br;
//     data['fid'] = fid;
//     data['size'] = size;
//     data['vd'] = vd;
//     data['sr'] = sr;
//     return data;
//   }
// }

// class Privilege {
//   Privilege({
//     required this.id,
//     required this.fee,
//     required this.payed,
//     required this.st,
//     required this.pl,
//     required this.dl,
//     required this.sp,
//     required this.cp,
//     required this.subp,
//     required this.cs,
//     required this.maxbr,
//     required this.fl,
//     required this.toast,
//     required this.flag,
//     required this.preSell,
//     required this.playMaxbr,
//     required this.downloadMaxbr,
//     required this.maxBrLevel,
//     required this.playMaxBrLevel,
//     required this.downloadMaxBrLevel,
//     required this.plLevel,
//     required this.dlLevel,
//     required this.flLevel,
//     required this.rscl,
//     required this.freeTrialPrivilege,
//     required this.rightSource,
//     required this.chargeInfoList,
//   });
//   late final int id;
//   late final int fee;
//   late final int payed;
//   late final int st;
//   late final int pl;
//   late final int dl;
//   late final int sp;
//   late final int cp;
//   late final int subp;
//   late final bool cs;
//   late final int maxbr;
//   late final int fl;
//   late final bool toast;
//   late final int flag;
//   late final bool preSell;
//   late final int playMaxbr;
//   late final int downloadMaxbr;
//   late final String maxBrLevel;
//   late final String playMaxBrLevel;
//   late final String downloadMaxBrLevel;
//   late final String plLevel;
//   late final String dlLevel;
//   late final String flLevel;
//   late final int rscl;
//   late final FreeTrialPrivilege freeTrialPrivilege;
//   late final int rightSource;
//   late final List<ChargeInfoList> chargeInfoList;
  
//   Privilege.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     fee = json['fee'];
//     payed = json['payed'];
//     st = json['st'];
//     pl = json['pl'];
//     dl = json['dl'];
//     sp = json['sp'];
//     cp = json['cp'];
//     subp = json['subp'];
//     cs = json['cs'];
//     maxbr = json['maxbr'];
//     fl = json['fl'];
//     toast = json['toast'];
//     flag = json['flag'];
//     preSell = json['preSell'];
//     playMaxbr = json['playMaxbr'];
//     downloadMaxbr = json['downloadMaxbr'];
//     maxBrLevel = json['maxBrLevel'];
//     playMaxBrLevel = json['playMaxBrLevel'];
//     downloadMaxBrLevel = json['downloadMaxBrLevel'];
//     plLevel = json['plLevel'];
//     dlLevel = json['dlLevel'];
//     flLevel = json['flLevel'];
//     rscl = json['rscl'];
//     freeTrialPrivilege = FreeTrialPrivilege.fromJson(json['freeTrialPrivilege']);
//     rightSource = json['rightSource'];
//     chargeInfoList = List.from(json['chargeInfoList']).map((e)=>ChargeInfoList.fromJson(e)).toList();
//   }
// }

// class FreeTrialPrivilege {
//   FreeTrialPrivilege({
//     required this.resConsumable,
//     required this.userConsumable,
//      this.listenType,
//      this.cannotListenReason,
//      this.playReason,
//   });
//   late final bool resConsumable;
//   late final bool userConsumable;
//   late final void listenType;
//   late final int? cannotListenReason;
//   late final void playReason;
  
//   FreeTrialPrivilege.fromJson(Map<String, dynamic> json){
//     resConsumable = json['resConsumable'];
//     userConsumable = json['userConsumable'];
//     listenType = json['listenType'];
//     cannotListenReason = json['cannotListenReason'];
//     playReason = json['playReason'];
//   }
// }

// class ChargeInfoList {
//   ChargeInfoList({
//     required this.rate,
//      this.chargeUrl,
//      this.chargeMessage,
//     required this.chargeType,
//   });
//   late final int rate;
//   late final void chargeUrl;
//   late final void chargeMessage;
//   late final int chargeType;
  
//   ChargeInfoList.fromJson(Map<String, dynamic> json){
//     rate = json['rate'];
//     chargeUrl = json['chargeUrl'];
//     chargeMessage = json['chargeMessage'];
//     chargeType = json['chargeType'];
//   }
// }