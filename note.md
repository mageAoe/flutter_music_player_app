# flutter_music_player_app

### andriod

```
compileSdkVersion flutter.compileSdkVersion
```

### 插件

- 网络请求：dio
- 图片缓存cached_network_image(实现图片持久化到本地，Flutter默认缓存到内存，但不持久化)
- 音乐播放：audioplayer
- 视频播放：video_player (底层原理是各平台实现对应播放器，例如Android端使用EXOPlayer)
- appinio_video_player
- 网络连接检测：connectivity_plus
- 横竖屏切换：orientation
- 屏幕适配方案： flutter_screenutil（适配文字大小、padding、margin）
- 刷新动画：liquid_pull_to_refresh
- 持久化存储: shared_preferences
- md5加密：crypto
- 文件读取：path_provider + dart:io
- 轮播图： flutter_swiper_view
- 骨架屏： skeletonizer
- 状态管理： provider (全局状态维护，全局皮肤、播放状态)
- 加载动画： flutter_spinkit
- 用于提取图片上的主色： palette_generator
- Toast提示：fluttertoast

### 目录结构: 

- custom_drawer 侧边栏
- navigation_home_screen 首页导航


### 学习&参考

- https://github.com/YYFlutter/flutter-article
- https://github.com/YYFlutter/flutter-animation-set
- https://blog.csdn.net/yuzhiqiang_1993/article/details/88204031
- https://niyangup.github.io/2020/02/18/Flutter%E4%B8%AD%E5%BA%95%E9%83%A8Tab%E5%88%87%E6%8D%A2%E4%BF%9D%E6%8C%81%E9%A1%B5%E9%9D%A2%E7%8A%B6%E6%80%81-%E7%BC%93%E5%AD%98-%E7%9A%84%E4%B8%A4%E7%A7%8D%E6%96%B9%E6%B3%95/
- https://juejin.cn/post/6979972557575782407
- https://www.flutter-study.dev/firebase-app/provider
- https://hiyoko-programming.com/2059/

Flutter Theme : https://itome.team/blog/2019/12/flutter-advent-calendar-day12/

### 功能

#### tabbar 透明
https://github.com/webabcd/flutter_demo

#### flutter主题设置
https://cloud.tencent.com/developer/article/2113811

#### 渐变色

#eeaeca -  #94bbe9 - #b0e0d7

- https://www.jianshu.com/p/d78d7e5db07f
- https://juejin.cn/post/6847902216871739400


### flutter 特殊组件

- SafeArea
- BackdropFilter
- ImageFilter
- PreferredSize
- Slider
- ConstrainedBox
- CustomScrollView
- SliverList


### 参数详解

#### ThemeData

```dart
factory ThemeData({
  Brightness brightness, // 应用整体主题的亮度。用于按钮之类的小部件，以确定在不使用主色或强调色时选择什么颜色。
  MaterialColor primarySwatch,// 定义一个单一的颜色以及十个色度的色块。
  Color primaryColor, // 应用程序主要部分的背景颜色(toolbars、tab bars 等)
  Brightness primaryColorBrightness, // primaryColor的亮度。用于确定文本的颜色和放置在主颜色之上的图标(例如工具栏文本)。
  Color primaryColorLight, // primaryColor的浅色版
  Color primaryColorDark, // primaryColor的深色版
  Color accentColor, // 小部件的前景色(旋钮、文本、覆盖边缘效果等)。
  Brightness accentColorBrightness, // accentColor的亮度。
  Color canvasColor, //  MaterialType.canvas 的默认颜色
  Color scaffoldBackgroundColor, // Scaffold的默认颜色。典型Material应用程序或应用程序内页面的背景颜色。
  Color bottomAppBarColor, // BottomAppBar的默认颜色
  Color cardColor, // Card的颜色
  Color dividerColor, // Divider和PopupMenuDivider的颜色，也用于ListTile之间、DataTable的行之间等。
  Color highlightColor, // 选中在泼墨动画期间使用的突出显示颜色，或用于指示菜单中的项。
  Color splashColor,  // 墨水飞溅的颜色。InkWell
  InteractiveInkFeatureFactory splashFactory, // 定义由InkWell和InkResponse反应产生的墨溅的外观。
  Color selectedRowColor, // 用于突出显示选定行的颜色。
  Color unselectedWidgetColor, // 用于处于非活动(但已启用)状态的小部件的颜色。例如，未选中的复选框。通常与accentColor形成对比。也看到disabledColor。
  Color disabledColor, // 禁用状态下部件的颜色，无论其当前状态如何。例如，一个禁用的复选框(可以选中或未选中)。
  Color buttonColor, // RaisedButton按钮中使用的Material 的默认填充颜色。
  ButtonThemeData buttonTheme, // 定义按钮部件的默认配置，如RaisedButton和FlatButton。
  Color secondaryHeaderColor, // 选定行时PaginatedDataTable标题的颜色。
  Color textSelectionColor, // 文本框中文本选择的颜色，如TextField
  Color cursorColor, // 文本框中光标的颜色，如TextField
  Color textSelectionHandleColor,  // 用于调整当前选定的文本部分的句柄的颜色。
  Color backgroundColor, // 与主色形成对比的颜色，例如用作进度条的剩余部分。
  Color dialogBackgroundColor, // Dialog 元素的背景颜色
  Color indicatorColor, // 选项卡中选定的选项卡指示器的颜色。
  Color hintColor, // 用于提示文本或占位符文本的颜色，例如在TextField中。
  Color errorColor, // 用于输入验证错误的颜色，例如在TextField中
  Color toggleableActiveColor, // 用于突出显示Switch、Radio和Checkbox等可切换小部件的活动状态的颜色。
  String fontFamily, // 文本字体
  TextTheme textTheme, // 文本的颜色与卡片和画布的颜色形成对比。
  TextTheme primaryTextTheme, // 与primaryColor形成对比的文本主题
  TextTheme accentTextTheme, // 与accentColor形成对比的文本主题。
  InputDecorationTheme inputDecorationTheme, // 基于这个主题的 InputDecorator、TextField和TextFormField的默认InputDecoration值。
  IconThemeData iconTheme, // 与卡片和画布颜色形成对比的图标主题
  IconThemeData primaryIconTheme, // 与primaryColor形成对比的图标主题
  IconThemeData accentIconTheme, // 与accentColor形成对比的图标主题。
  SliderThemeData sliderTheme,  // 用于呈现Slider的颜色和形状
  TabBarTheme tabBarTheme, // 用于自定义选项卡栏指示器的大小、形状和颜色的主题。
  CardTheme cardTheme, // Card的颜色和样式
  ChipThemeData chipTheme, // Chip的颜色和样式
  TargetPlatform platform, 
  MaterialTapTargetSize materialTapTargetSize, // 配置某些Material部件的命中测试大小
  PageTransitionsTheme pageTransitionsTheme, 
  AppBarTheme appBarTheme, // 用于自定义Appbar的颜色、高度、亮度、iconTheme和textTheme的主题。
  BottomAppBarTheme bottomAppBarTheme, // 自定义BottomAppBar的形状、高度和颜色的主题。
  ColorScheme colorScheme, // 拥有13种颜色，可用于配置大多数组件的颜色。
  DialogTheme dialogTheme, // 自定义Dialog的主题形状
  Typography typography, // 用于配置TextTheme、primaryTextTheme和accentTextTheme的颜色和几何TextTheme值。
  CupertinoThemeData cupertinoOverrideTheme 
})

```