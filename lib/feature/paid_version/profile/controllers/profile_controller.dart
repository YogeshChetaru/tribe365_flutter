import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../home/domain/models/view_department_user_list_response.dart';
import '../domain/models/cotquestiondata.dart';
import '../domain/models/get_motivation_list_response.dart';
import '../domain/models/get_question_list_response.dart';
import '../domain/models/get_update_question_list_response.dart';
import '../domain/models/view_action_list_response.dart';
import '../domain/models/view_action_tier_list_response.dart';
import '../domain/models/view_cot_functional_lens_response.dart';
import '../domain/models/view_cot_individual_summary_response.dart';
import '../domain/models/view_cot_mapper_summary_response.dart';
import '../domain/models/view_personality_completed_answers_response.dart';
import '../domain/models/view_personality_type_question_list_response.dart';
import '../domain/models/view_personality_type_report_response.dart';
import '../domain/models/view_sot_motivation_completed_answer_list_response.dart';
import '../domain/models/view_sot_motivation_user_list_response.dart';
import '../domain/models/view_theme_list_response.dart' hide ModelTheme;
import '../domain/models/view_user_by_type_list_response.dart';
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
  CotQuestionData? _CotQuestiondata;

  CotQuestionData? get CotQuestiondata => _CotQuestiondata;
  final rolePairs = [
    ["shaper", "coordinator"],
    ["implementer", "completerFinisher"],
    ["monitorEvaluator", "teamworker"],
    ["plant", "resourceInvestigator"],
  ];

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
  List<String> tierList = ["All Tier", "Primary", "Secondary", "Tertiary", "Office", "Department", "Individual"];

  final List<Map<String, String>> statements = [
    {'label': 'A', 'text': 'identifying improved ways of doing things'},
    {'label': 'B', 'text': 'making sure everyone in the team is happy'},
    {'label': 'C', 'text': 'being the best at what I do'},
    {'label': 'D', 'text': 'assessing what is required against what we have and finding the best way forward'},
    {'label': 'E', 'text': 'completing the activity'},
  ];
  final List<Map<String, String>> statementsUpdate = [
    {'label': 'A', 'text': 'identifying improved ways of doing things'},
    {'label': 'B', 'text': 'making sure everyone in the team is happy'},
    {'label': 'C', 'text': 'being the best at what I do'},
    {'label': 'D', 'text': 'assessing what is required against what we have and finding the best way forward'},
    {'label': 'E', 'text': 'completing the activity'},
  ];

  Map<int, int> counters = {};
  Map<int, int> countersUpdate = {};

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
  final List<double> diagnosticsScores = [50.0, 61.7, 56.94, 63.89, 64.58, 75.0];

  final List<String> diagnosticsLabels = ['Personal Development', 'Teamwork', 'Leadership/Management', 'Communication', 'Stress', 'Performance'];
  final List<double> tribeMeterScores = [11.9, 16.67, 22.22, 44.44, 0.0];

  final List<String> tribeMeterLabels = ['Structure', 'Belief', 'Balance', 'Honesty', 'Inclusiveness'];
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



  void addActionStatus(String s) {
    actionStatus = s;
    notifyListeners();
  }

  void updateTierSelectedValue(String? newValue) {
    tierSelectedValue = newValue!;
    if (newValue == "All Tier") {
      filteredActions = List.from(viewActionList!);
    } else {
      filteredActions = viewActionList!
          .where((item) => item.tier?.toLowerCase() == newValue.toLowerCase())
          .toList();
    }

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

  void initCountersUpdate() {
    for (int i = 0; i < statementsUpdate.length; i++) {
      countersUpdate[i] = 0;
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
  List<GetUpdateQuestionListData> _questionsUpdate = [];

  List<GetQuestionListData> get questions => _questions;

  List<GetUpdateQuestionListData> get questionsUpdate => _questionsUpdate;

  final List<Option> _currentOptions = [];
  final List<Options> _currentOptionsUpdate = [];

  List<Option> get currentOptions => _currentOptions;

  List<Options> get currentOptionsUpdate => _currentOptionsUpdate;

  int _currentIndex = 0;
  int _currentIndexUpdate = 0;

  int get currentIndex => _currentIndex;

  int get currentIndexUpdate => _currentIndexUpdate;

  void loadQuestion(int index) {
    _currentIndex = index;
    _currentOptions.clear();

    final question = _questions[index];
    for (int i = 0; i < (question.option?.length ?? 0); i++) {
      final opt = question.option![i];
      String label = String.fromCharCode(65 + i);

      opt.label = label;
      _currentOptions.add(opt);
    }

    notifyListeners();
  }

  void loadQuestionUpdate(int index) {
    _currentIndexUpdate = index;
    _currentOptionsUpdate.clear();

    final question = _questionsUpdate[index];
    for (int i = 0; i < (question.options?.length ?? 0); i++) {
      final opt = question.options![i];
      final label = String.fromCharCode(65 + i); // A, B, C, ...
      opt.alphabate = label;
      _currentOptionsUpdate.add(opt);
    }

    notifyListeners();
  }

  void updateAnswer(int optionIndex, String value) {
    _currentOptions[optionIndex].answer = value;
    notifyListeners();
  }

  void updateAnswerUpdate(int optionIndex, String value) {
    _currentOptionsUpdate[optionIndex].answer = value;
    _currentOptionsUpdate[optionIndex].flag = true;

    _questionsUpdate[_currentIndexUpdate].options![optionIndex].answer = value;
    _questionsUpdate[_currentIndexUpdate].options![optionIndex].flag = true;

    notifyListeners();
  }

  bool get isLastQuestion => _currentIndex == _questions.length - 1;

  bool get isLastQuestionUpdate => _currentIndexUpdate == _questionsUpdate.length - 1;

  void nextQuestion() {
    if (!isLastQuestion) {
      loadQuestion(_currentIndex + 1);
    }
  }

  void nextQuestionUpdate() {
    if (!isLastQuestionUpdate) {
      loadQuestionUpdate(_currentIndexUpdate + 1);
    }
  }

  int get currentTotal {
    if (questions.isEmpty) return 0;
    return questions[currentIndex].option!.fold(
          0,
          (prev, opt) => prev + (int.tryParse(opt.answer!) ?? 0),
        );
  }

  int get currentTotalUpdate {
    return _currentOptionsUpdate.fold(
      0,
      (prev, opt) => prev + (int.tryParse(opt.answer ?? '0') ?? 0),
    );
  }

  void incrementOption(int index) {
    final option = _currentOptions[index];
    int currentAnswer = int.tryParse(option.answer!) ?? 0;

    if (currentTotal < 10 && currentAnswer < 10) {
      currentAnswer++;
      option.answer = currentAnswer.toString();
      option.flag = true;
      _questions[_currentIndex].option![index].answer = option.answer;
      _questions[_currentIndex].option![index].flag = true;

      notifyListeners();
    }
  }

  void incrementOptionUpdate(int index) {
    final option = _currentOptionsUpdate[index];
    int currentAnswer = int.tryParse(option.answer ?? '0') ?? 0;

    if (currentTotalUpdate < 10 && currentAnswer < 10) {
      currentAnswer++;
      option.answer = currentAnswer.toString();
      option.flag = true;

      _questionsUpdate[_currentIndexUpdate].options![index].answer = option.answer;
      _questionsUpdate[_currentIndexUpdate].options![index].flag = true;

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

      _questions[_currentIndex].option![index].answer = option.answer;
      _questions[_currentIndex].option![index].flag = true;

      notifyListeners();
    }
  }

  void decrementOptionUpdate(int index) {
    final option = _currentOptionsUpdate[index];
    int currentAnswer = int.tryParse(option.answer ?? '0') ?? 0;

    if (currentAnswer > 0) {
      currentAnswer--;
      option.answer = currentAnswer.toString();
      option.flag = true;

      _questionsUpdate[_currentIndexUpdate].options![index].answer = option.answer;
      _questionsUpdate[_currentIndexUpdate].options![index].flag = true;

      notifyListeners();
    }
  }

  void totalCount() {
    try {
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

  void totalCountUpdate() {
    int sum = 0;
    for (final opt in _currentOptionsUpdate) {
      sum += int.tryParse(opt.answer ?? '0') ?? 0;
    }
    debugPrint('Current total points: $sum');
    notifyListeners();
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
        showCustomSnackBar(getTranslated('please_revise_your_scores_total_scores_should_be_10', context), context, isError: true);
      }
    }
  }

  void validateAnswersUpdate(BuildContext context) {
    List<String> listAns = [];
    int stTotalAns = 0;

    for (final opt in _currentOptionsUpdate) {
      if ((opt.answer ?? '').isEmpty) {
        opt.answer = '0';
      }
      listAns.add(opt.answer ?? '0');
    }

    if (listAns.length == _currentOptionsUpdate.length) {
      for (final ans in listAns) {
        stTotalAns += int.tryParse(ans) ?? 0;
      }

      if (stTotalAns == 10) {
        nextQuestionUpdate();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please revise your scores. Total must be 10.')),
        );
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
        sendTeamRoleData();
      } else {
        showCustomSnackBar(
          getTranslated("please_revise_your_score", context),
          context,
          isError: true,
        );
      }
    }
  }

  void validateAndSubmitQuestionUpdate(int index, BuildContext context) {
    int totalPoints = 0;
    final questionOptions = questionsUpdate[index].options ?? [];

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
        sendTeamRoleDataUpdate();
      } else {
        showCustomSnackBar(
          getTranslated("please_revise_your_score", context),
          context,
          isError: true,
        );
      }
    }
  }

  String get submissionJson {
    final List<Map<String, dynamic>> list = viewMotivationQuestions.map((e) => e.toJson()).toList();
    return jsonEncode({'answer': list});
  }

  Future<void> saveUserMotivationData(List<SOTMotivationQuestion> questions) async {
    final jsonList = questions.map((q) => q.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    profileServiceInterface!.saveUserMotivationData(jsonString);
  }

  String getUserMotivationData() {
    return profileServiceInterface!.getUserMotivationData();
  }

  List<SOTMotivationQuestion> viewMotivationQuestions = [];
  List<ViewSotMotivationCompletedAnswerListData> viewMotivationQuestionsCompletedList = [];
  List<ViewSotMotivationCompletedAnswerListData> viewMotivationQuestionsCopyList = [];
  int resultCount = 0;

  void validateAndSubmit(BuildContext context) {
    int count = 0;

    for (int i = 0; i < viewMotivationQuestions.length; i++) {
      final question = viewMotivationQuestions[i];

      for (int j = 0; j < (question.option?.length ?? 0); j++) {
        final rating = question.option?[j].rating ?? "";

        if (rating.isEmpty) {
          showCustomSnackBar("${getTranslated("please_provide_score_for_question", context)} : ${i + 1}", context, isError: true);
          return;
        } else {
          count++;
        }
      }
    }

    if (count == resultCount) {
      sendMotivationData();
    }
  }

  void validateAndSubmitUpdate(BuildContext context) {
    for (int i = 0; i < viewMotivationQuestionsCompletedList.length; i++) {
      final question = viewMotivationQuestionsCompletedList[i];

      if ((question.option?[0].rating ?? "").isEmpty) {
        viewMotivationQuestionsCopyList[i].option?[0].rating = (question.option?[0].points ?? 0).toString();
      } else {
        viewMotivationQuestionsCopyList[i].option?[0].rating = question.option?[0].rating;
      }

      if ((question.option?[1].rating ?? "").isEmpty) {
        viewMotivationQuestionsCopyList[i].option?[1].rating = (question.option?[1].points ?? 0).toString();
      } else {
        viewMotivationQuestionsCopyList[i].option?[1].rating = question.option?[1].rating;
      }
    }

    int count = 0;
    for (int i = 0; i < viewMotivationQuestionsCompletedList.length; i++) {
      final question = viewMotivationQuestionsCompletedList[i];

      for (int j = 0; j < (question.option?.length ?? 0); j++) {
        final rating = question.option?[j].rating ?? "";

        if (rating.isEmpty) {
          showCustomSnackBar(
            "${getTranslated("please_provide_score_for_question", context)} : ${i + 1}",
            context,
            isError: true,
          );
          return;
        } else {
          count++;
        }
      }
    }
    if (count > 0) {
      sendMotivationDataUpdate(viewMotivationQuestionsCopyList);
    }
  }

  void updateOptionRating(
    int? questionId,
    int optionIndexClicked,
    String selectedRating,
  ) {
    final question = viewMotivationQuestions.firstWhere(
      (q) => q.questionId == questionId,
      orElse: () => SOTMotivationQuestion(),
    );

    if (question.questionId != null) {
      // Always expect 2 options
      final options = question.option ?? [];

      if (options.length >= 2) {
        // Determine which is the "other" option
        final otherIndex = optionIndexClicked == 0 ? 1 : 0;

        // Compute the paired rating
        final pairedRating = (5 - int.parse(selectedRating)).toString();

        // Update the clicked option
        options[optionIndexClicked].rating = selectedRating;

        // Update the paired option
        options[otherIndex].rating = pairedRating;

        // Mark the question as flagged
        question.flag = true;

        notifyListeners();
      }
    }
  }

  void updateOptionRatingUpdate(
    int? questionId,
    int optionIndexClicked,
    String selectedRating,
  ) {
    final question = viewMotivationQuestionsCompletedList.firstWhere(
      (q) => q.questionId == questionId,
      orElse: () => ViewSotMotivationCompletedAnswerListData(),
    );

    if (question.questionId != null) {
      final options = question.option ?? [];

      if (options.length >= 2) {
        final otherIndex = optionIndexClicked == 0 ? 1 : 0;
        final clickedRating = int.tryParse(selectedRating) ?? 0;
        final pairedRating = 5 - clickedRating;
        options[optionIndexClicked].points = clickedRating;
        options[otherIndex].points = pairedRating;

        question.flag = true;

        notifyListeners();
      }
    }
  }

  void updateRatings(int index, String ratingOpt1, String ratingOpt2) {
    viewMotivationQuestions[index].option?[0].rating = ratingOpt1;
    viewMotivationQuestions[index].option?[1].rating = ratingOpt2;

    viewMotivationQuestions[index].flag = true;

    notifyListeners();
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

  Future<void> updateUserInfo(String departmentId, String personalData, String officeId, String imgBase64, String contact, String email,
      String lastName, String fName) async {
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
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewQuestionsList() async {
    _isLoading = true;
    ApiResponse apiResponse = await profileServiceInterface!.viewQuestionsList();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      GetQuestionListResponse response = GetQuestionListResponse.fromJson(map);

      String userTeamRoleData = getUserTeamRoleData();
      List<GetQuestionListData> savedQuestions = [];

      if (userTeamRoleData.isNotEmpty) {
        try {
          List<dynamic> jsonList = jsonDecode(userTeamRoleData);
          savedQuestions = jsonList.map((item) => GetQuestionListData.fromJson(item)).toList();
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

        if (savedQuestion.questionId != null && savedQuestion.option != null && apiQuestion.option != null) {
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

  Future<void> viewQuestionsListUpdate() async {
    _isLoading = true;
    ApiResponse apiResponse = await profileServiceInterface!.viewCompletedQuestionsList();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      GetUpdateQuestionListResponse response = GetUpdateQuestionListResponse.fromJson(map);

      _questionsUpdate = response.data ?? [];
      if (_questionsUpdate.isNotEmpty) {
        loadQuestionUpdate(0);
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
        "orgId": userProfileData!.orgId,
        "answer": answerArray,
      };

      ApiResponse apiResponse = await profileServiceInterface!.sendTeamRoleData(request);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
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
    ApiResponse apiResponse = await profileServiceInterface!.getCOTMapperSummary();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewCotMapperSummaryResponse response = ViewCotMapperSummaryResponse.fromJson(map);
      cotMapperSummaryDataList = response.data;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
  }

  Future<void> viewCOTindividualSummary() async {
    _isLoading = true;
    ApiResponse apiResponse = await profileServiceInterface!.viewCOTindividualSummary();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewCotIndividualSummaryResponse response = ViewCotIndividualSummaryResponse.fromJson(map);
      cotIndividualSummaryData = response.data;

      _CotQuestiondata = CotQuestionData.fromJson(map["data"]);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
  }

  Future<void> sendTeamRoleDataUpdate() async {
    try {
      final List<Map<String, dynamic>> answerList = [];

      for (final question in _questionsUpdate) {
        final Map<String, dynamic> questionMap = {
          "questionId": question.questionId?.toString() ?? "",
          "option": [],
        };

        for (final option in question.options ?? []) {
          questionMap["option"].add({
            "answerId": option.answerId?.toString() ?? "",
            "point": option.answer ?? "0",
          });
        }

        answerList.add(questionMap);
      }

      /// Wrap in the outer object
      final Map<String, dynamic> body = {
        "answer": answerList,
      };

      debugPrint("Submitting Answers JSON: ${jsonEncode(body)}");

      /// Send POST
      ApiResponse apiResponse = await profileServiceInterface!.sendTeamRoleDataUpdate(body);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final responseData = apiResponse.response!.data;

        final String msg = responseData["message"] ?? "Submitted successfully";
        showCustomSnackBar(msg, Get.context!, isError: false);

        Navigator.of(Get.context!).pop();
      } else {
        showCustomSnackBar("Submission failed", Get.context!, isError: true);
      }
    } catch (e) {
      debugPrint("Submit error: $e");
      showCustomSnackBar("An error occurred submitting answers", Get.context!, isError: true);
    }
  }

  Future<void> viewMotivationList(
    String savedJsonList,
    BuildContext context,
  ) async {
    _isLoading = true;

    ApiResponse apiResponse = await profileServiceInterface!.viewMotivationList();

    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final Map<String, dynamic> map = apiResponse.response!.data as Map<String, dynamic>;

      // Convert the API response to your model
      final response = SOTMotivationQuestionListResponse.fromJson(map);

      viewMotivationQuestions = response.data ?? [];

      // Merge saved answers (if any)
      if (savedJsonList.isNotEmpty && savedJsonList != "[]") {
        debugPrint("Saved JSON: $savedJsonList");
        final List<dynamic> savedArray = jsonDecode(savedJsonList);

        for (var savedItem in savedArray) {
          final savedQuestionId = savedItem["questionId"]?.toString();
          final List<dynamic> savedOptions = savedItem["option"] ?? [];

          // Find the matching question in the fresh API data
          final matchingQuestion = viewMotivationQuestions.firstWhere(
            (q) => q.questionId?.toString() == savedQuestionId,
            orElse: () => SOTMotivationQuestion(),
          );

          if (matchingQuestion.questionId != null) {
            // ✅ Reset ALL ratings to "0"
            if (matchingQuestion.option != null) {
              for (var opt in matchingQuestion.option!) {
                opt.rating = "";
              }
            }

            // Now apply saved ratings
            for (var savedOpt in savedOptions) {
              final savedOptionId = savedOpt["OptionId"]?.toString();
              final savedRating = savedOpt["rating"]?.toString() ?? "";

              final matchingOption = matchingQuestion.option?.firstWhere(
                (o) => o.optionId?.toString() == savedOptionId,
                orElse: () => SOTMotivationOption(),
              );

              if (matchingOption != null && matchingOption.optionId != null) {
                matchingOption.rating = savedRating;
              }
            }
          }
        }
      }
      resultCount = viewMotivationQuestions.length * 2;
    } else {
      showCustomSnackBar(
        "Failed to load questions",
        Get.context!,
        isError: true,
      );
    }

    notifyListeners();
  }

  Future<void> sendMotivationData() async {
    _isLoadingBtn = true;
    notifyListeners();

    try {
      final List<Map<String, dynamic>> answerList = viewMotivationQuestions.map((question) {
        return {
          "questionId": question.questionId,
          "option": question.option?.map((opt) {
                return {"optionId": opt.optionId, "rating": opt.rating ?? "0"};
              }).toList() ??
              [],
        };
      }).toList();

      final Map<String, dynamic> request = {
        "answer": answerList,
      };
      debugPrint("Sending answer JSON: $request");

      ApiResponse apiResponse = await profileServiceInterface!.sendMotivationData(request);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        Map<String, dynamic> map = apiResponse.response!.data;

        String msg = map['message'] ?? "Submission successful";
        showCustomSnackBar(msg, Get.context!, isError: false);

        profileServiceInterface!.clearSavedUserMotivationData();
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

  Map<String, dynamic> buildAnswerPayload(List<ViewSotMotivationCompletedAnswerListData> questionsCopyList) {
    List<Map<String, dynamic>> answerList = [];

    for (var question in questionsCopyList) {
      List<Map<String, dynamic>> options = [];

      for (var option in question.option ?? []) {
        options.add({
          "answerId": option.answerId,
          "rating": option.rating,
        });
      }

      answerList.add({
        "questionId": question.questionId,
        "option": options,
      });
    }

    return {
      "answer": answerList,
    };
  }

  Future<void> sendMotivationDataUpdate(List<ViewSotMotivationCompletedAnswerListData> listData) async {
    _isLoadingBtn = true;
    notifyListeners();
    try {
      final payload = buildAnswerPayload(viewMotivationQuestionsCopyList);

      ApiResponse apiResponse = await profileServiceInterface!.sendMotivationDataUpdate(payload);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        Map<String, dynamic> map = apiResponse.response!.data;
        String msg = map['message'] ?? "Submission successful";
        showCustomSnackBar(msg, Get.context!, isError: false);
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

  //--------------------------------------
  List<ViewSotMotivationUserListData>? sotMotivationUserList;

  Future<void> viewSOTmotivationUserList() async {
    _isLoading = true;
    Map<String, dynamic> request = {"orgId": userProfileData!.orgId.toString(), "userId": userProfileData!.id.toString()};

    ApiResponse apiResponse = await profileServiceInterface!.viewSOTmotivationUserList(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewSotMotivationUserListResponse response = ViewSotMotivationUserListResponse.fromJson(map);
      sotMotivationUserList = response.data;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewMotivationCompletedAnswerList(
    BuildContext context,
  ) async {
    _isLoading = true;

    ApiResponse apiResponse = await profileServiceInterface!.viewMotivationCompletedAnswerList();

    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final Map<String, dynamic> map = apiResponse.response!.data as Map<String, dynamic>;

      final response = ViewSotMotivationCompletedAnswerListResponse.fromJson(map);

      viewMotivationQuestionsCompletedList = response.data ?? [];
      viewMotivationQuestionsCopyList = response.data ?? [];
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  //--------------------------------------

  void validateAndSubmitPersonalityType(BuildContext context) {
    final questions = personalityQuestionList;

    int count = 0;

    for (var q in questions!) {
      if (q.answer.isEmpty) {
        showCustomSnackBar("${getTranslated("please_agree_with_a_statement_for_question", context)} ${q.questionId}", context, isError: true);
        return;
      } else {
        count++;
      }
    }

    if (count == questions.length) {
      sendPersonalityTypeData();
    }
  }

  Future<void> saveUserPersonalityTypeData() async {
    final jsonList = personalityQuestionList!.map((q) => q.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    profileServiceInterface!.saveUserPersonalityTypeData(jsonString);
  }

  int getAnsweredCount() {
    return personalityQuestionList!.where((q) => q.flag).length;
  }

  String getUserPersonalityTypeData() {
    return profileServiceInterface!.getUserPersonalityTypeData();
  }

  void setPersonalityTypeQuestionListAnswer(int index, String answer) {
    if (index < 0 || index >= personalityQuestionList!.length) return;
    personalityQuestionList![index].answer = answer;
    personalityQuestionList![index].flag = true;
    notifyListeners();
  }

  List<ViewPersonalityTypeQuestionListData> getAnsweredQuestions() {
    return personalityQuestionList!.where((q) => q.answer.isNotEmpty).toList();
  }

  List<ViewPersonalityTypeQuestionListData>? personalityQuestionList;

  Future<void> viewPersonalityTypeQuestionList(
    String? savedJsonList,
  ) async
  {
    _isLoading = true;

    ApiResponse apiResponse = await profileServiceInterface!.viewPersonalityTypeQuestionList();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewPersonalityTypeQuestionListResponse response = ViewPersonalityTypeQuestionListResponse.fromJson(map);
      personalityQuestionList = response.data;
      if (savedJsonList != null && savedJsonList.trim() != "[]" && savedJsonList != "") {
        final List<dynamic> savedArray = json.decode(savedJsonList);

        for (int i = 0; i < savedArray.length; i++) {
          final savedAnswer = savedArray[i]["answer"] ?? "";
          if (i < personalityQuestionList!.length) {
            personalityQuestionList![i].answer = savedAnswer;
          }
        }
      }
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> sendPersonalityTypeData() async {
    _isLoadingBtn = true;
    notifyListeners();

    try {
      final List<Map<String, dynamic>> answerList = [];

      for (var q in personalityQuestionList!) {
        answerList.add({
          "questionId": q.questionId.toString(),
          "optionId": q.answer.toString(),
        });
      }

      final Map<String, dynamic> payload = {
        "answer": answerList,
      };

      ApiResponse apiResponse = await profileServiceInterface!.sendPersonalityTypeData(payload);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        Map<String, dynamic> map = apiResponse.response!.data;

        String msg = map['message'] ?? "Submission successful";
        showCustomSnackBar(msg, Get.context!, isError: false);

        profileServiceInterface!.clearSavedPersonalityTypeData();
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

  //-------------------------------

  ViewCotFunctionalLensData? modelFutureLensDetails;

  bool get hasData => modelFutureLensDetails != null && (modelFutureLensDetails!.funcLensKeyDetail?.isNotEmpty ?? false);
  bool userNameStatus = false;
  List<FuncLensKeyDetail>? funcLensKeyDetails;
  List<ViewPersonalityTypeReportData>? viewPersonalityTypeReportList;
  List<ViewPersonalityCompletedAnswersData>? viewPersonalityCompletedAnswersList;

  void setPersonalityCompletedQuestionListAnswer(int questionIndex, int selectedOptionIndex) {
    if (questionIndex < 0 || questionIndex >= viewPersonalityCompletedAnswersList!.length) return;

    var question = viewPersonalityCompletedAnswersList![questionIndex];

    // Update option selection
    for (int i = 0; i < question.options!.length; i++) {
      question.options![i].isChecked = i == selectedOptionIndex;
    }

    // Set selected answer as string ("1" for first option, "2" for second, etc.)
    question.answer = (selectedOptionIndex + 1).toString();
    question.flag = true;

    notifyListeners();
  }

  Future<void> viewCOTFunctionalLensDetail() async {
    _isLoading = true;
    Map<String, dynamic> request = {"orgId": userProfileData!.orgId.toString(), "userId": userProfileData!.id.toString()};
    ApiResponse apiResponse = await profileServiceInterface!.viewCOTFunctionalLensDetail(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewCotFunctionalLensResponse response = ViewCotFunctionalLensResponse.fromJson(map);
      modelFutureLensDetails = response.data;
      funcLensKeyDetails = modelFutureLensDetails!.funcLensKeyDetail!;

      if (modelFutureLensDetails!.funcLensKeyDetail!.isEmpty) {
        userNameStatus = true;
      } else {
        userNameStatus = false;
      }
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewPersonalityTypeReport() async {
    _isLoading = true;
    Map<String, dynamic> request = {"userId": userProfileData!.id.toString()};
    ApiResponse apiResponse = await profileServiceInterface!.viewPersonalityTypeReport(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewPersonalityTypeReportResponse response = ViewPersonalityTypeReportResponse.fromJson(map);
      viewPersonalityTypeReportList = response.data;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewPersonalityCompletedQuestionList() async {
    _isLoading = true;
    ApiResponse apiResponse = await profileServiceInterface!.viewPersonalityTypeCompletedQuestionList();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewPersonalityCompletedAnswersResponse response = ViewPersonalityCompletedAnswersResponse.fromJson(map);
      viewPersonalityCompletedAnswersList = response.data;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> sendPersonalityCompletedData() async {
    _isLoadingBtn = true;
    notifyListeners();

    try {
      List<Map<String, dynamic>> answerList = [];
      for (var item in viewPersonalityCompletedAnswersList!) {
        String? optionId;

        if (item.answer.trim().isNotEmpty) {
          optionId = item.answer;
        } else {
          final selectedOption = item.options?.firstWhere(
            (opt) => opt.isChecked == true,
            orElse: () => ViewPersonalityCompletedAnswersOptions(),
          );
          optionId = selectedOption?.optionId?.toString();
        }

        answerList.add({
          "answerId": item.answerId?.toString() ?? "",
          "optionId": optionId ?? "",
        });
      }

      Map<String, dynamic> finalObject = {
        "answer": answerList,
      };

      ApiResponse apiResponse = await profileServiceInterface!.sendPersonalityCompletedData(finalObject);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        Map<String, dynamic> map = apiResponse.response!.data;
        String msg = map['message'] ?? "Submission successful";
        showCustomSnackBar(msg, Get.context!, isError: false);
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

  //------------Action---------------
  List<ViewActionListData>? viewActionList;
  List<ViewActionListData>? filteredActions;
  List<ViewActionTierListData>? viewActionTierList;
  List<ViewActionTierListData>? filteredActionTierList;
  ViewActionTierListData? selectedActionTierListData;
  ViewUserByTypeListData? selectedUserListData;
  ModelTheme? selectedThemeData;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  bool showDepartment = false;
  String departmentLabel = "";
  String departmentId = "";
  String officeId = "";
  List<ViewDepartmentDepartment>? departmentsList;
  List<ViewUserByTypeListData>? userList;
  List<ViewUserByTypeListData>? filteredUserList;
  List<ModelTheme>? themeList;
  List<ModelTheme>? filteredThemeList;
String selectedStartData = "";
String selectedDueData = "";
  intiData(bool isNotify) {
    searchController = TextEditingController();
    searchFocus = FocusNode();
    if (isNotify) {
      notifyListeners();
    }
  }

  void filterActionTier() {
    final query = searchController.text.toLowerCase();
    filteredActionTierList = viewActionTierList!.where((user) => user.name!.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  void filterUser() {
    final query = searchController.text.toLowerCase();
    filteredUserList = userList!.where((user) => user.name!.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  void filterTheme() {
    final query = searchController.text.toLowerCase();
    filteredThemeList = themeList!.where((user) => user.title!.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  void updateFilteredActionTierList(ViewActionTierListData data) {
    selectedActionTierListData = data;
    if (selectedActionTierListData!.name!.contains("DEPARTMENT")) {
      showDepartment = true;
      departmentLabel = "RESPONSIBLE DEPARTMENT";
      if (departmentsList!.isEmpty) {
        viewDepartmentUserListApi(userProfileData!.orgId!.toString());
      }
    } else if (selectedActionTierListData!.name!.toUpperCase() == "OFFICE") {
      showDepartment = true;
      departmentLabel = "RESPONSIBLE OFFICE";
    } else {
      showDepartment = false;
      departmentLabel = "";
      viewUserByTypeListApi(selectedActionTierListData!.name!);
    }
    notifyListeners();
  }

  void updateFilteredUserList(ViewUserByTypeListData data) {
    selectedUserListData = data;
    notifyListeners();
  }

  void updateFilteredThemeList(ModelTheme data) {
    selectedThemeData = data;
    notifyListeners();
  }

  Future<void> getDate(BuildContext context,String type) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // disables past dates
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorResources.mainColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorResources.mainColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formattedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      if(type=="dueData"){
        selectedDueData = formattedDate;
      }
      else{
        selectedStartData = formattedDate;
      }
    }
    notifyListeners();
  }


  Future<void> viewActionListAPI() async {
    _isLoading = true;
    Map<String, dynamic> request = {"orgId": userProfileData!.orgId.toString()};
    ApiResponse apiResponse = await profileServiceInterface!.viewActionList(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewActionListResponse response = ViewActionListResponse.fromJson(map);
      viewActionList = response.data;
      filteredActions = response.data;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> updateActionItemStatus(String actionId,String orgStatus) async {
    _isLoadingBtn = true;
    Map<String, dynamic> request = {
      "actionId": actionId,
      "orgStatus":orgStatus
    };
    ApiResponse apiResponse = await profileServiceInterface!.updateActionItemStatus(request);
    _isLoadingBtn = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);

      int index = filteredActions!.indexWhere((element) => element.id == actionId);
      if (index != -1) {
        filteredActions![index].orgStatus = orgStatus;
      }

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> deleteActionItemStatus(String actionId) async {
    _isLoadingBtn = true;
    Map<String, dynamic> request = {
      "actionId": actionId,
    };
    ApiResponse apiResponse = await profileServiceInterface!.deleteActionItemStatus(request);
    _isLoadingBtn = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);

      int index = filteredActions!.indexWhere((element) => element.id == actionId);
      filteredActions!.removeAt(index);

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewActionTierListApi() async {
    ApiResponse apiResponse = await profileServiceInterface!.viewActionTierList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewActionTierListResponse response = ViewActionTierListResponse.fromJson(map);
      viewActionTierList = response.data;
      filteredActionTierList = viewActionTierList;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewDepartmentUserListApi(String orgId) async {
    Map<String, dynamic> request = {
      "orgId": orgId,
    };
    ApiResponse apiResponse = await profileServiceInterface!.viewDepartmentUserList(request);
    
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewDepartmentUserListResponse response = ViewDepartmentUserListResponse.fromJson(map);
      departmentsList = response.data!.departments;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewUserByTypeListApi(String name) async {
// Determine type1 and typeid
    String type1 = "";
    String typeid = "";

    final lowerType = name.toLowerCase();

    if (["primary", "tertiary", "secondary", "individual"].contains(lowerType)) {
      type1 = "organisation";
      typeid = userProfileData!.orgId!.toString();
    } else if (lowerType == "office") {
      type1 = "office";
      typeid = officeId;
    } else {
      type1 = "department";
      typeid = departmentId;
    }

    final Map<String, dynamic> request = {
      "type": type1,
      "typeId": typeid,
    };

    ApiResponse apiResponse = await profileServiceInterface!.viewUserByTypeList(request);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewUserByTypeListResponse response = ViewUserByTypeListResponse.fromJson(map);
      userList = response.data!;
      filteredUserList = userList;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewThemeList(String orgId) async {
    Map<String, dynamic> request = {
      "orgId": orgId,
    };
    ApiResponse apiResponse = await profileServiceInterface!.viewThemeList(request);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewThemeListResponse response = ViewThemeListResponse.fromJson(map);
      themeList = response.data!.themeList;
      filteredThemeList = response.data!.themeList;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> addActionData() async {
    Map<String, dynamic> request = {};
    ApiResponse apiResponse = await profileServiceInterface!.addActionData(request);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}
