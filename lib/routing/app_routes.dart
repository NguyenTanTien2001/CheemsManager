abstract class AppRoutes {
  // WELCOME
  static const WELCOME = '/welcome';

  // SPLASH
  static const SPLASH = '/splash';

  // AUTH
  static const AUTH = '/auth';
  static const PATH_SIGN_IN = '/sign_in';
  static const SIGN_IN = AUTH + PATH_SIGN_IN;
  static const PATH_SIGN_UP = '/sign_up';
  static const SIGN_UP = AUTH + PATH_SIGN_UP;
  static const PATH_FORGOT_PASSWORD = '/forgot_password';
  static const FORGOT_PASSWORD = AUTH + PATH_FORGOT_PASSWORD;
  static const PATH_RESET_PASSWORD = '/reset_password';
  static const RESET_PASSWORD = AUTH + PATH_RESET_PASSWORD;
  static const PATH_SUCCESSFUL = '/successful';
  static const SUCCESSFUL = AUTH + PATH_SUCCESSFUL;

  // HOME
  static const HOME = '/home';
  static const PATH_MY_TASK = '/my_task';
  static const MY_TASK = HOME + PATH_MY_TASK;
  static const PATH_MENU = '/menu';
  static const MENU = HOME + PATH_MENU;
  static const PATH_QUICK = '/quick';
  static const QUICK = HOME + PATH_QUICK;
  static const PATH_PROFILE = '/profile';
  static const PROFILE = HOME + PATH_PROFILE;
  static const PATH_NEW_TASK = '/new_task';
  static const NEW_TASK = HOME + PATH_NEW_TASK;
  static const PATH_NEW_NOTE = '/add_note';
  static const NEW_NOTE = HOME + PATH_NEW_NOTE;
  static const PATH_NEW_CHECK_LIST = '/add_check_list';
  static const NEW_CHECK_LIST = HOME + PATH_NEW_CHECK_LIST;

  static const DETAIL_TASK = '/detail_task';

  static const LIST_USER_FORM = '/list_user_form';

  //detail_task
  static const EDIT_TASK = '/edit_task';
}
