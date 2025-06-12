import '../localization/models/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String appName = 'Tribe365';

  static const String appVersion = '1.0';

  static const String baseUrl = 'https://upgrade-console.tribe365.co/api/'; //development url
  // static const String baseUrl = 'https://console.tribe365.co/api/'; //production url

  static const String webSite = "https://www.tribe365.co";
  static const String tribe365 = "tribe365.co";

  static const String userRole = '3'; //userRole 3 means user


  // sharePreference
  static const String userLoginData = 'user_login_data';
  static const String userLoginToken = 'user_login_token';
  static const String userLoginStatus = 'user_login_status';
  static const String userLoginType = 'user_login_type';

  static const String user = 'user';
  static const String langKey = 'lang';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.en, languageName: 'English', countryCode: 'US', languageCode: 'en'),
  ];

  //API endpoints
  static const String loginUri = 'userLogin';
  static const String logoutUri = 'userLogout';
  static const String userSetPasswordUri = 'userSetPassword';
  static const String forgotPasswordUri = 'forgotPassword';
  static const String changePasswordUri = 'updatePasswordWithCurrentPassword';
  static const String userProfileUri = 'userProfile';
  static const String updateUserProfileUri = 'updateUserProfile';
  static const String getHomePageDetailsUri = 'getHomePageDetails';
  static const String getHPTMPrinciplesListUri = 'getPrinciplesList';
  static const String getLearningCheckListUri = 'getLearningCheckList';
  static const String changeReadStatusOfUserChecklistUri = 'changeReadStatusOfUserChecklist';


  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}
