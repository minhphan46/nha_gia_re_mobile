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
  static const resultArg = '/search/result_arg';

  // setting
  static const setting = '/setting';

  // account
  static const account = '/account';
  static const purchase = '/account/purchase';
  static const purchaseChoosePlan = '/account/purchase/choose_plan';
  static const updateInfoAccount = '/account/updateInfo';

  // create post
  static const createPost = '/createPost';
  static const address = '/createPost/address';

  // notifications
  static const notifications = '/notifications';

  // post management
  static const postManagement = '/postManagement';

  // user profile
  static const userProfile = '/userProfile/:id';
  static String getUserProfileRoute(String id) {
    return '/userProfile/$id';
  }

  // chat
  static const chat = '/chat';
  static const chatDetail = '/chat/:id';
  static String getChatDetailRoute(String id) {
    return '/chat/$id';
  }

  // verify
  static const verificationPortrait = '/verification/portrait';
  static const verificationInfo = '/verification/info';
  static const verificationCard = '/verification/card';
  static const verificationWaiting = '/verification/waiting';
  static const verificationReject = '/verification/reject';
}
