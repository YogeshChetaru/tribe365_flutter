

import '../localization/models/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String appName = 'Tribe365';


  static const String appVersion = '1.0';

  static const String baseUrl = '';


  // sharePreference
  static const String userLoginToken = 'user_login_token';

  static const String user = 'user';
  static const String langKey = 'lang';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';



  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.en,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
      ];
}
