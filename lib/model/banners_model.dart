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