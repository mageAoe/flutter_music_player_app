import 'package:flutter/material.dart';


class MvData {
  int index;
  String name;
  String type;

  MvData({
    required this.index,
    required this.name,
    this.type = 'video',
  });

  static List<MvData> tabIconsList = <MvData>[
    MvData(
      index: 1,
      name: "官方"
    ),
    MvData(
      index: 2,
      name: "最新"
    ),
    MvData(
      index: 3,
      name: "排行"
    ),
    MvData(
      index: 4,
      name: "全部"
    ),
    MvData(
      index: 5,
      name: "内地"
    ),
    MvData(
      index: 6,
      name: "港台"
    ),
    MvData(
      index: 7,
      name: "欧美"
    ),
    MvData(
      index: 8,
      name: "日本"
    ),
    MvData(
      index: 9,
      name: "韩国"
    ),
  ];
}