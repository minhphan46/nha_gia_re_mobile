abstract class AppRoutes {
  // splashScreen
  static const splashScreen = '/splashScreen';

  // login
  static const login = '/login';
  static const register = '/login/register';
  static const updateInfo = '/login/register/updateInfo';
  static const fogot = '/login/forgot';
  static const resetPassword = '/login/forgot/resetPassword';

  // bottom bar
  static const bottomBar = '/bottomBar';

  // home
  static const home = '/home';

  // post detail
  static const postDetail = '/post_detail/:id';
  static String getPostRoute(String id) {
    return '/post_detail/$id';
  }

  // search
  static const search = '/search';

  // setting
  static const setting = '/setting';

  // account
  static const account = '/account';

  // create post
  static const createPost = '/createPost';

  // notifications
  static const notifications = '/notifications';

  // post management
  static const postManagement = '/postManagement';
}
