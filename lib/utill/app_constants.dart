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
  static const String userTeamRoleData = 'User_team_role_data';
  static const String userMotivationData = 'User_motivation_data';

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
  static const String getDepartmentListUri = 'getDepartmentList';
  static const String getFreeVersionHomeDetailsUri = 'getFreeVersionHomeDetails';
  static const String getAllOfficeDepartmentsUri = 'getAllOfficenDepartments';
  static const String userApplyLeaveUri = 'userApplyLeave';
  static const String userChangeLeaveStatusUri = 'userChangeLeaveStatus';
  static const String addHappyIndexUri = 'addHappyIndex';
  static const String updatePushNotificationStatusUri = 'updatePushNotificationStatus';
  static const String postFeedbackUri = 'postFeedback';
  static const String getFeedbackDetailUri = 'getFeedbackDetail';
  static const String postHPTMReflectionUri = 'postHPTMReflection';
  static const String getHptmReflectionDetailUri = 'getHptmReflectionDetail';
  static const String getChatMessagesUri = 'getChatMessages';
  static const String iotSendMsgUri = 'iotSendMsg';
  static const String viewKnowOrganisationDetailsUri = 'getKnowOrganisationDetails';
  static const String getUserByTypeUri = 'getUserByType';
  static const String getKudosAwardUri = 'getKudosAward';
  static const String getKnowMemberDetailsUri = 'getKnowMemberDetails';
  static const String getBubbleUnReadNotificationsUri = 'getBubbleUnReadNotifications';
  static const String getBubbleRatingUnReadNotificationListUri = 'getBubbleRatingUnReadNotificationList';
  static const String getBubbleRatingNotificationListUri = 'getBubbleRatingNotificationList';
  static const String readAllNotificationUri = 'readAllNotification';
  static const String changeNotificationStatusUri = 'changeNotificationStatus';
  static const String getCurrentVersionOfAppUri = 'getCurrentVersionOfApp';
  static const String dotDetailUriUri = 'dotDetail';
  static const String getDepartmentUserListUri = 'getDepartmentUserList';
  static const String getCOTQuestionsUri = 'getCOTQuestions';
  static const String addCOTAnswerUri = 'addCOTAnswer';
  static const String getCOTMapperSummaryUri = 'getCOTMapperSummary';
  static const String getCOTindividualSummaryUri = 'getCOTindividualSummary';
  static const String getCOTteamRoleCompletedAnswersUri = 'getCOTteamRoleCompletedAnswers';
  static const String updateCOTTeamRoleMapAnswersUri = 'updateCOTteamRoleMapAnswers';
  static const String getSOTmotivationQuestionsUri = 'getSOTmotivationQuestions';
  static const String addSOTmotivationAnswerUri = 'addSOTmotivationAnswer';
  static const String getSOTmotivationUserListUri = 'getSOTmotivationUserList';
  static const String getSOTmotivationCompletedAnswerUri = 'getSOTmotivationCompletedAnswer';



  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}
