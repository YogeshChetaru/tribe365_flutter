import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../domain/models/get_question_list_response.dart';
import '../domain/models/view_cot_individual_summary_response.dart';
import '../domain/models/view_cot_mapper_summary_response.dart';
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

  bool _isLoadingBtn = false;
  bool get isLoadingBtn => _isLoadingBtn;

  List<ViewCotMapperSummaryData>? cotMapperSummaryDataList;
  ViewCotIndividualSummaryData? cotIndividualSummaryData;

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

  void setUserDataController(bool notify) {
    fNameController.text = userProfileData!.name!;
    lNameController.text = userProfileData!.lastName!;
    officeNameController.text = userProfileData!.officeName!;
    deptNameController.text = userProfileData!.departmentName!;
    contactController.text = userProfileData!.userContact ?? "";

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

  final List<Map<String, String>> statements = [
    {'label': 'A', 'text': 'identifying improved ways of doing things'},
    {'label': 'B', 'text': 'making sure everyone in the team is happy'},
    {'label': 'C', 'text': 'being the best at what I do'},
    {
      'label': 'D',
      'text':
          'assessing what is required against what we have and finding the best way forward'
    },
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

  Map<int, Map<int, int>> selectedScores =
      {}; // {questionIndex: {optionIndex: selectedScore}}

  final List<double> cultureData = [
    671,
    368,
    15,
    -271,
    -554,
    -940,
    -510,
    75,
    -62,
    525,
    -1808,
    -1390
  ];
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

  final List<double> engagementData = [
    79,
    -768,
    -1726,
    -2533,
    -3326,
    -4401,
    -2603,
    -1633,
    -1992,
    -3387,
    -6145
  ];
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
  List<String> labels = [
    'Int',
    'Ext',
    'Innov',
    'Lgc',
    'Ppl',
    'Tsk',
    'Stru',
    'Flxbl'
  ];

  final List<Map<String, String>> cultureItems = [
    {'label': 'PERSON', 'value': '0'},
    {'label': 'POWER', 'value': '0'},
    {'label': 'ROLE', 'value': '0'},
    {'label': 'COLLABORATIVE', 'value': '0'},
  ];

  final List<double> motivationScores = [
    28.0,
    28.0,
    18.0,
    20.0,
    17.5,
    21.0,
    27.5,
    18.5,
    25.0,
    21.5
  ];

  final List<String> motivationLabels = [
    'Financial Security',
    'Stress Free',
    'Risk Free',
    'Job Structure',
    'Teamwork',
    'Relationships',
    'Appreciation',
    'Leadership',
    'Freedom',
    'Freedom'
  ];
  final List<double> diagnosticsScores = [
    50.0,
    61.7,
    56.94,
    63.89,
    64.58,
    75.0
  ];

  final List<String> diagnosticsLabels = [
    'Personal Development',
    'Teamwork',
    'Leadership/Management',
    'Communication',
    'Stress',
    'Performance'
  ];
  final List<double> tribeMeterScores = [11.9, 16.67, 22.22, 44.44, 0.0];

  final List<String> tribeMeterLabels = [
    'Structure',
    'Belief',
    'Balance',
    'Honesty',
    'Inclusiveness'
  ];
  List<String> months = [
    "Jul 2024",
    "Aug 2024",
    "Sep 2024",
    "Oct 2024",
    "Nov 2024",
    "Dec 2024",
    "Jan 2025",
    "Feb 2025",
    "Mar 2025",
    "Apr 2025",
    "May 2025",
    "Jun 2025"
  ];

  List<double> sentimentValues = [
    16.3,
    14.8,
    3.3,
    3.6,
    0.0,
    10.9,
    33.3,
    20.6,
    16.7,
    21.2,
    25.0
  ];

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

  List<GetQuestionListData> _questions = [];

  List<GetQuestionListData> get questions => _questions;

  final List<Option> _currentOptions = [];

  List<Option> get currentOptions => _currentOptions;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void loadQuestion(int index) {
    _currentIndex = index;
    _currentOptions.clear();

    final question = _questions[index];
    for (int i = 0; i < (question.option?.length ?? 0); i++) {
      final opt = question.option![i];
      String label = String.fromCharCode(65 + i);

      opt.label = label; // assign label directly
      _currentOptions.add(opt); // ✅ add by reference, not copy
    }

    notifyListeners();
  }

  void updateAnswer(int optionIndex, String value) {
    _currentOptions[optionIndex].answer = value;
    notifyListeners();
  }

  bool get isLastQuestion => _currentIndex == _questions.length - 1;

  void nextQuestion() {
    if (!isLastQuestion) {
      loadQuestion(_currentIndex + 1);
    }
  }

  int get currentTotal {
    if (questions.isEmpty) return 0;
    return questions[currentIndex].option!.fold(
          0,
          (prev, opt) => prev + (int.tryParse(opt.answer!) ?? 0),
        );
  }

  void incrementOption(int index) {
    final option = _currentOptions[index];
    int currentAnswer = int.tryParse(option.answer!) ?? 0;

    if (currentTotal < 10 && currentAnswer < 10) {
      currentAnswer++;
      option.answer = currentAnswer.toString();
      option.flag = true;

      // Sync back to main question list
      _questions[_currentIndex].option![index].answer = option.answer;
      _questions[_currentIndex].option![index].flag = true;

      notifyListeners();
    }
  }

  void decrementOption(int index) {
    final option = _currentOptions[index];
    int currentAnswer = int.tryParse(option.answer!) ?? 0;

    if (currentAnswer > 0) {
      currentAnswer--;
      option.answer = currentAnswer.toString();
      option.flag = true;

      // Sync back to main question list
      _questions[_currentIndex].option![index].answer = option.answer;
      _questions[_currentIndex].option![index].flag = true;

      notifyListeners();
    }
  }

  void totalCount() {
    int sum = 0;
    try {
      for (int i = 0; i < _currentOptions.length; i++) {
        int getAns = int.tryParse(_currentOptions[i].answer ?? '0') ?? 0;
        sum += getAns;
      }

      for (int i = 0; i < questions.length; i++) {
        for (int j = 0; j < _currentOptions.length; j++) {
          if (_currentOptions[j].flag == true) {
            _currentOptions[i].flag = true;
          }
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('TotalCount CotQuest Error: $e');
    }
  }

  void validateAnswers(BuildContext context) {
    List<String> listAns = [];
    int stTotalAns = 0;

    List<Option> currentOptions = questions[currentIndex].option ?? [];

    for (int i = 0; i < currentOptions.length; i++) {
      if ((currentOptions[i].answer ?? '').isEmpty) {
        currentOptions[i].answer = '0';
      }

      listAns.add(currentOptions[i].answer ?? '0');
    }

    if (listAns.length == currentOptions.length) {
      for (String ans in listAns) {
        stTotalAns += int.tryParse(ans) ?? 0;
      }

      if (stTotalAns == 10) {
        nextQuestion();
      } else {
        showCustomSnackBar(
            getTranslated(
                'please_revise_your_scores_total_scores_should_be_10', context),
            context,
            isError: true);
      }
    }
  }

  void saveUserTeamRoleData(String userData, BuildContext context) {
    profileServiceInterface!.saveUserTeamRoleData(userData);
    Navigator.pop(context);
  }

  String getUserTeamRoleData() {
    return profileServiceInterface!.getUserTeamRoleData();
  }

  void validateAndSubmitQuestion(int index, BuildContext context) {
    int totalPoints = 0;
    final questionOptions = questions[index].option ?? [];

    List<String> listAns = [];

    for (var option in questionOptions) {
      if ((option.answer ?? '').isEmpty) {
        option.answer = "0"; // default to zero
      }
      listAns.add(option.answer!);
    }

    if (listAns.length == questionOptions.length) {
      for (var ans in listAns) {
        totalPoints += int.tryParse(ans) ?? 0;
      }

      if (totalPoints == 10) {
        sendTeamRoleData(); // ✅ submit
      } else {
        showCustomSnackBar(
          getTranslated("please_revise_your_score", context),
          context,
          isError: true,
        );
      }
    }
  }


  //API calling
  Future<void> viewUserProfile() async {
    ApiResponse apiResponse =
        await profileServiceInterface!.viewUserProfileData();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewUserProfileResponse userResponse =
          ViewUserProfileResponse.fromJson(map);
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
      String fName) async
  {
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

    ApiResponse apiResponse =
        await profileServiceInterface!.updateProfile(request);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      viewUserProfile();
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewQuestionsList() async {
    _isLoading = true;
    ApiResponse apiResponse =
        await profileServiceInterface!.viewQuestionsList();
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      GetQuestionListResponse response = GetQuestionListResponse.fromJson(map);

      String userTeamRoleData = getUserTeamRoleData();
      List<GetQuestionListData> savedQuestions = [];

      if (userTeamRoleData.isNotEmpty) {
        try {
          List<dynamic> jsonList = jsonDecode(userTeamRoleData);
          savedQuestions = jsonList
              .map((item) => GetQuestionListData.fromJson(item))
              .toList();
        } catch (e) {
          debugPrint("Error decoding saved data: $e");
        }
      }

      _questions = response.data ?? [];
// Merge saved answers with fresh API data
      for (final apiQuestion in _questions) {
        final savedQuestion = savedQuestions.firstWhere(
          (q) => q.questionId == apiQuestion.questionId,
          orElse: () => GetQuestionListData(),
        );

        if (savedQuestion.questionId != null &&
            savedQuestion.option != null &&
            apiQuestion.option != null) {
          for (final apiOption in apiQuestion.option!) {
            final savedOption = savedQuestion.option!.firstWhere(
              (opt) => opt.optionId == apiOption.optionId,
              orElse: () => Option(),
            );
            if (savedOption.optionId != null) {
              apiOption.answer = savedOption.answer ?? "0";
              apiOption.flag = savedOption.flag;
            }
          }
        }
      }

      if (_questions.isNotEmpty) {
        loadQuestion(0);
      }
    }

    notifyListeners();
  }


  Future<void> sendTeamRoleData() async {
    _isLoadingBtn = true;
    notifyListeners();

    try {

      List<Map<String, dynamic>> answerArray = [];

      for (var question in questions) {
        List<Map<String, dynamic>> optionArray = [];

        for (var opt in question.option ?? []) {
          optionArray.add({
            "optionId": opt.optionId,
            "point": opt.answer ?? "0",
            "roleMapId": opt.roleMapId,
          });
        }

        answerArray.add({
          "questionId": question.questionId,
          "option": optionArray,
        });
      }

      Map<String, dynamic> request = {
        "userId": userProfileData!.id!,
        "orgId":userProfileData!.orgId,
        "answer": answerArray,
      };

      ApiResponse apiResponse =
      await profileServiceInterface!.sendTeamRoleData(request);

      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        Map<String, dynamic> map = apiResponse.response!.data;

        String msg = map['message'] ?? "Submission successful";
        showCustomSnackBar(msg, Get.context!);

        profileServiceInterface!.clearSavedUserTeamRoleData();
        Navigator.of(Get.context!).pop(true);
      } else {
        showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
        ApiChecker.checkApi(apiResponse);
      }
    } catch (e) {
      showCustomSnackBar("Error: $e", Get.context!, isError: true);
    }

    _isLoadingBtn = false;
    notifyListeners();
  }

  Future<void> viewCOTMapperSummary() async {
    _isLoading = true;
    ApiResponse apiResponse =
    await profileServiceInterface!.getCOTMapperSummary();
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewCotMapperSummaryResponse response = ViewCotMapperSummaryResponse.fromJson(map);
      cotMapperSummaryDataList = response.data;
    }
    else{
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
  }

  Future<void> viewCOTindividualSummary() async {
    _isLoading = true;
    ApiResponse apiResponse =
    await profileServiceInterface!.viewCOTindividualSummary();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewCotIndividualSummaryResponse response = ViewCotIndividualSummaryResponse.fromJson(map);
      cotIndividualSummaryData = response.data;
    }
    else{
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
  }

}
