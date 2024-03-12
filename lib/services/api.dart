class Api {
  // 首页banner
  static String URL_BANNER_LIST = 'banner?type=1';
  // 每日推荐歌曲
  static String URL_RECMMEND_SONGS = 'recommend/songs';
  // 发送验证码
  static String URL_CAPTCHA_SENT = 'captcha/sent'; // phone=
  // 手机登录
  static String URL_LOGIN_CELLPHONE = 'login/cellphone'; // phone=xxx&captcha=123
  // 获取用户详情
  static String URL_USER_DETAIL = 'user/detail'; // uid=32953014
  // 获取用户歌单
  static String URL_USER_PLAYLIST = 'user/playlist'; // uid=585138859
  // 获取歌单所有歌曲
  static String URL_PLAYLIST_TRACK_ALL = 'playlist/track/all'; // id=24381616&limit=10&offset=0
  // 调用此接口 , 可获取 APP 首页信息
  static String URL_HOMEPAGE_BLOCK_PAGE = 'homepage/block/page';
  // 获取歌手单曲
  static String URL_ARTISTS = 'artists'; // id=6452
  // 获取歌手 mv
  static String URL_ARTISTS_MV = 'artist/mv'; // artist/mv?id=6452
  // 获取歌手专辑
  static String URL_ARTIST_ALBUM = 'artist/album'; // artist/album?id=6452&limit=5&offset=0
  // 获取热门歌手
  static String URL_TOP_ARTISTS = 'top/artists'; // top/artists?offset=0&limit=30
  // 推荐歌单
  static String URL_PERSONALIZED = 'personalized'; //  personalized?limit=10&offset=2
  // 推荐新音乐
  static String URL_PERSONALIZED_NEWSONG = 'personalized/newsong'; //  /personalized/newsong?limit=10&offset=2
  // mv 地址
  static String URL_MV_URL = 'mv/url'; // mv/url?id=10896407&r=1080 `r`: 分辨率,默认 1080
  // mv 排行
  static String URL_TOP_MV = 'top/mv'; // top/mv?limit=10&offset=1
  // 歌手榜 分类  可获取排行榜中的歌手榜 前100
  // type : 地区
  //     1: 华语
  //     2: 欧美
  //     3: 韩国
  //     4: 日本
  static String URL_TOPLIST_ARTIST = 'toplist/artist'; // toplist/artist?type=1
  // 歌手分类列表
  /*
    type 取值
      -1:全部
      1:男歌手
      2:女歌手
      3:乐队

    area 取值
     -1:全部
      7华语
      96欧美
      8:日本
      16韩国
      0:其他
   */
  static String URL_ARTIST_LIST = 'artist/list'; // artist/list?type=-1&area=96&limit=20&offset=1
  // 歌单
  static String URL_TOP_PLAYLIST = 'top/playlist'; //  top/playlist?limit=10&cat=华语
  // 热门歌单分类
  static String URL_PLAYLIST_HOT = 'playlist/hot'; //  playlist/hot
  // 歌单分类
  static String URL_PLAYLIST_CATLIST = 'playlist/catlist'; //  playlist/catlist
  // 精品歌单标签列表 
  static String URL_PLAYLIST_HIGHQUALITY = 'playlist/highquality/tags'; //  playlist/highquality/tags
  // 搜索
  static const URL_SEARCH = 'search'; // keywords=
}