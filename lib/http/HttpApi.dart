
class HttpApi {
  // default options
  static String baseUrl = "https://www.wanandroid.com";

  //  首页文章列表
  //  参数：页码，拼接在连接中，从0开始。
  static String articleList = "/article/list/";
  static String articleTopList = "/article/top/json";

  //  首页banner
  static String banner = "/banner/json";

  //  登录
  static String login = "/user/login";

  //参数 username，password

  //  注册
  //参数 username，password，repassword
  static String register = "/user/register";

  //积分
  static String coin = "/lg/coin/userinfo/json";

  //积分
  static String logout = "/user/logout/json";

  //项目分类
  static String project_tree = "/project/tree/json";

  //项目
  static String project_list = "/project/list/page/json?cid=sid";

  //取获公众号列表
  static String wxarticle_chapters = "/wxarticle/chapters/json";


  //查看某个公众号历史数据
  static String wxarticle_list = "/wxarticle/list/id/page/json";

//  获取个人积分获取列表
  static String coin_list = "/lg/coin/list/page/json";

}
