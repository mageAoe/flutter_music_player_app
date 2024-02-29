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
}