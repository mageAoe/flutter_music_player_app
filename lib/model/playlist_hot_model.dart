import 'package:flutter_music_player_app/model/top_playlist_model.dart';

class PlaylistHotModel {
  PlaylistHotModel({
    this.tags,
    this.code,
  });
  List<Tags>? tags;
  int? code;
  
  PlaylistHotModel.fromJson(Map<String, dynamic> json){
    tags = List.from(json['tags']).map((e)=>Tags.fromJson(e)).toList();
    code = json['code'];
  }
}

class Tags {
  Tags({
    required this.playlistTag,
    required this.activity,
    required this.createTime,
    required this.usedCount,
    required this.hot,
    required this.position,
    required this.category,
    required this.name,
    required this.id,
    required this.type,
  });

  late final PlaylistTag playlistTag;
  late final bool activity;
  late final int createTime;
  late final int usedCount;
  late final bool hot;
  late final int position;
  late final int category;
  late final String name;
  late final int id;
  late final int type;
  
  Tags.fromJson(Map<String, dynamic> json){
    playlistTag = PlaylistTag.fromJson(json['playlistTag']);
    activity = json['activity'];
    createTime = json['createTime'];
    usedCount = json['usedCount'];
    hot = json['hot'];
    position = json['position'];
    category = json['category'];
    name = json['name'];
    id = json['id'];
    type = json['type'];
  }
}

class PlaylistTag {
  PlaylistTag({
    required this.id,
    required this.name,
    required this.category,
    required this.usedCount,
    required this.type,
    required this.position,
    required this.createTime,
    required this.highQuality,
    required this.highQualityPos,
    required this.officialPos,
  });
  late final int id;
  late final String name;
  late final int category;
  late final int usedCount;
  late final int type;
  late final int position;
  late final int createTime;
  late final int highQuality;
  late final int highQualityPos;
  late final int officialPos;
  
  PlaylistTag.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    category = json['category'];
    usedCount = json['usedCount'];
    type = json['type'];
    position = json['position'];
    createTime = json['createTime'];
    highQuality = json['highQuality'];
    highQualityPos = json['highQualityPos'];
    officialPos = json['officialPos'];
  }
}