import 'package:flutter/material.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../main.dart';
import '../domain/models/viewuserprofileresponse.dart';
import '../domain/services/profile_service_interface.dart';

class ProfileController extends ChangeNotifier {
  final ProfileServiceInterface? profileServiceInterface;

  ProfileController({required this.profileServiceInterface});

  ViewUserProfileData? userProfileData;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController officeNameController = TextEditingController();
  TextEditingController deptNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode officeNameFocus = FocusNode();
  FocusNode deptNameFocus = FocusNode();
  FocusNode contactFocus = FocusNode();
  bool userDataPrivateStatus = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void controllerInit(bool notify) {
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    officeNameController = TextEditingController();
    deptNameController = TextEditingController();
    contactController = TextEditingController();
    fNameFocus = FocusNode();
    lNameFocus = FocusNode();
    officeNameFocus = FocusNode();
    deptNameFocus = FocusNode();
    contactFocus = FocusNode();
    if (notify) {
      notifyListeners();
    }
  }

  void setUserDataController(bool notify){
    fNameController.text = userProfileData!.name!;
    lNameController.text = userProfileData!.lastName!;
    officeNameController.text = userProfileData!.officeName!;
    deptNameController.text = userProfileData!.departmentName!;
    contactController.text = userProfileData!.userContact?? "";

    if (userProfileData!.personaliseData == 1) {
      userDataPrivateStatus = true;
    } else {
      userDataPrivateStatus = false;
    }
    if (notify) {
      notifyListeners();
    }
  }

  void disposeControllers() {
    fNameController.dispose();
    lNameController.dispose();
    officeNameController.dispose();
    deptNameController.dispose();
    contactController.dispose();
    fNameFocus.dispose();
    lNameFocus.dispose();
    officeNameFocus.dispose();
    deptNameFocus.dispose();
    contactFocus.dispose();
  }

  String actionStatus = "";
  String tierSelectedValue = 'All Tier';

  List<String> tierList = ['All Tier', 'Primary', 'Secondary', 'Tertiary'];

  final List<String> questions = [
    'I love working on my own in peace and quiet',
    'I assess my ideas/opinions before voicing them',
    'I catch every detail of what is discussed with me',
    'I notice the small details around me',
    'I love working on my own in peace and quiet',
    'I assess my ideas/opinions before voicing them',
    'I catch every detail of what is discussed with me',
    'I notice the small details around me',
  ];

  final List<String> options = [
    'DISAGREE',
    'MOSTLY DISAGREE',
    'NEUTRAL',
    'MOSTLY AGREE',
    'AGREE',
  ];

  final List<Map<String, String>> statements = [
    {'label': 'A', 'text': 'identifying improved ways of doing things'},
    {'label': 'B', 'text': 'making sure everyone in the team is happy'},
    {'label': 'C', 'text': 'being the best at what I do'},
    {'label': 'D', 'text': 'assessing what is required against what we have and finding the best way forward'},
    {'label': 'E', 'text': 'completing the activity'},
  ];

  Map<int, int> counters = {};

  Map<int, String> selectedAnswers = {};

  final List<Map<String, dynamic>> motivationQuestions = [
    {
      'question': 'I enjoy work more when:',
      'options': [
        'I work as part of a team',
        'I am not under pressure',
      ]
    },
    {
      'question': 'My biggest fears in relation to work are:',
      'options': [
        'My role being threatened in relation to my performance',
        'Having conflict within my team',
      ]
    },
    {
      'question': 'I believe I work better when:',
      'options': [
        'I am given control to do my own work and manage myself',
        'I know that my results will be given the credit they deserve',
      ]
    },
  ];

  Map<int, Map<int, int>> selectedScores = {}; // {questionIndex: {optionIndex: selectedScore}}

  final List<double> cultureData = [671, 368, 15, -271, -554, -940, -510, 75, -62, 525, -1808, -1390];
  final List<String> cultureLabels = [
    'Jul24',
    'Sep24',
    'Nov24',
    'Jan25',
    'Mar25',
    'May25',
    'Jul24',
    'Sep24',
    'Nov24',
    'Jan25',
    'Mar25',
    'May25',
  ];

  final List<double> engagementData = [79, -768, -1726, -2533, -3326, -4401, -2603, -1633, -1992, -3387, -6145];
  final List<String> engagementLabels = [
    'Jul24',
    'Sep24',
    'Nov24',
    'Jan25',
    'Mar25',
    'May25',
    'Jul24',
    'Sep24',
    'Nov24',
    'Jan25',
    'Mar25',
  ];
  List<double> percentages = [69.3, 73.3, 67.8, 78.9, 62.7, 76.0, 78.7, 80.0];
  List<String> labels = ['Int', 'Ext', 'Innov', 'Lgc', 'Ppl', 'Tsk', 'Stru', 'Flxbl'];

  final List<Map<String, String>> cultureItems = [
    {'label': 'PERSON', 'value': '0'},
    {'label': 'POWER', 'value': '0'},
    {'label': 'ROLE', 'value': '0'},
    {'label': 'COLLABORATIVE', 'value': '0'},
  ];

  final List<double> motivationScores = [28.0, 28.0, 18.0, 20.0, 17.5, 21.0, 27.5, 18.5, 25.0, 21.5];

  final List<String> motivationLabels = ['Financial Security', 'Stress Free', 'Risk Free', 'Job Structure', 'Teamwork', 'Relationships', 'Appreciation', 'Leadership', 'Freedom', 'Freedom'];
  final List<double> diagnosticsScores = [50.0, 61.7, 56.94, 63.89, 64.58, 75.0];

  final List<String> diagnosticsLabels = ['Personal Development', 'Teamwork', 'Leadership/Management', 'Communication', 'Stress', 'Performance'];
  final List<double> tribeMeterScores = [11.9, 16.67, 22.22, 44.44, 0.0];

  final List<String> tribeMeterLabels = ['Structure', 'Belief', 'Balance', 'Honesty', 'Inclusiveness'];
  List<String> months = ["Jul 2024", "Aug 2024", "Sep 2024", "Oct 2024", "Nov 2024", "Dec 2024", "Jan 2025", "Feb 2025", "Mar 2025", "Apr 2025", "May 2025", "Jun 2025"];

  List<double> sentimentValues = [16.3, 14.8, 3.3, 3.6, 0.0, 10.9, 33.3, 20.6, 16.7, 21.2, 25.0];

  bool isPushNotification = false;

  void updateIsPushNotification(bool value) {
    isPushNotification = value;
    notifyListeners();
  }

  void updateUserDataPrivateStatus(bool value) {
    userDataPrivateStatus = value;
    notifyListeners();
  }

  void updateActionStatus(String s) {
    actionStatus = s;
    notifyListeners();
  }

  void updateTierSelectedValue(String? newValue) {
    tierSelectedValue = newValue!;
    notifyListeners();
  }

  void updateSelectedAnswers(String option, int index) {
    selectedAnswers[index] = option;
    notifyListeners();
  }

  int get totalPoints {
    return counters.values.fold(0, (sum, value) => sum + value);
  }

  void initCounters() {
    for (int i = 0; i < statements.length; i++) {
      counters[i] = 0;
    }
  }

  void initMotivationQuestions() {
    for (int q = 0; q < motivationQuestions.length; q++) {
      selectedScores[q] = {};
      for (int o = 0; o < motivationQuestions[q]['options'].length; o++) {
        selectedScores[q]![o] = -1; // -1 means no selection yet
      }
    }
  }

  void updateCountersSubtraction(int index) {
    counters[index] = counters[index]! - 1;
    notifyListeners();
  }

  void updateCountersAddition(int index) {
    counters[index] = counters[index]! + 1;
    notifyListeners();
  }

  void updateSelectedScores(int questionIndex, int optionIndex, int score) {
    selectedScores[questionIndex]![optionIndex] = score;
    notifyListeners();
  }

  String getUserToken() {
    return profileServiceInterface!.getUserToken();
  }


  //API calling
  Future<void> viewUserProfile() async {
    ApiResponse apiResponse = await profileServiceInterface!.viewUserProfileData();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewUserProfileResponse userResponse = ViewUserProfileResponse.fromJson(map);
      userProfileData = userResponse.data;
    }
    notifyListeners();
  }

  Future<void> updateUserInfo(
      String departmentId,
      String personalData,
      String officeId,
      String imgBase64,
      String contact,
      String email,
      String lastName,
      String fName
      ) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> request = {
      "name": fName,
      "lastName": lastName,
      "email": email,
      "contact": contact,
      "profileImage": imgBase64,
      "officeId": officeId,
      "personaliseData": personalData,
      "departmentId": departmentId,
    };

    ApiResponse apiResponse = await profileServiceInterface!.updateProfile(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      viewUserProfile();
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!,isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

}
