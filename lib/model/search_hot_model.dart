class SearchHotModel {
  SearchHotModel({
    this.code,
    this.data,
    this.message,
  });
  int? code;
  List<Data>? data;
  String? message;
  
  SearchHotModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
  }
}

class Data {
  Data({
    this.searchWord,
    this.score,
    this.content,
    this.source,
    this.iconType,
    this.iconUrl,
    this.url,
    this.alg,
  });
  String? searchWord;
  int? score;
  String? content;
  int? source;
  int? iconType;
  String? iconUrl;
  String? url;
  String? alg;
  
  Data.fromJson(Map<String, dynamic> json){
    searchWord = json['searchWord'];
    score = json['score'];
    content = json['content'];
    source = json['source'];
    iconType = json['iconType'];
    iconUrl = json['iconUrl'];
    url = json['url'];
    alg = json['alg'];
  }
}