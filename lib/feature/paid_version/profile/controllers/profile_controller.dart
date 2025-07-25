import 'dart:convert';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/feature/paid_version/profile/domain/models/view_comment_list_response.dart';
import 'package:tribe365_new/feature/paid_version/profile/domain/models/view_team_role_data.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/notification_utils.dart';
import '../../../free_version/free_dashboard/domain/models/get_office_list_response.dart';
import '../../../free_version/free_dashboard/domain/models/view_department_list_response.dart';
import '../../home/domain/models/view_department_user_list_response.dart';
import '../domain/models/cotquestiondata.dart';
import '../domain/models/get_motivation_list_response.dart';
import '../domain/models/get_question_list_response.dart';
import '../domain/models/get_update_question_list_response.dart';
import '../domain/models/view_action_detail_response.dart';
import '../domain/models/view_action_list_response.dart';
import '../domain/models/view_action_tier_list_response.dart';
import '../domain/models/view_cot_functional_lens_response.dart';
import '../domain/models/view_cot_individual_summary_response.dart';
import '../domain/models/view_cot_mapper_summary_response.dart';
import '../domain/models/view_diagnostic_completed_question_list_response.dart';
import '../domain/models/view_diagnostic_question_list_response.dart';
import '../domain/models/view_personality_completed_answers_response.dart';
import '../domain/models/view_personality_type_question_list_response.dart';
import '../domain/models/view_personality_type_report_response.dart';
import '../domain/models/view_sot_motivation_completed_answer_list_response.dart';
import '../domain/models/view_sot_motivation_user_list_response.dart';
import '../domain/models/view_sot_question_answers_list_response.dart';
import '../domain/models/view_sot_question_list_response.dart';
import '../domain/models/view_studies_list_response.dart';
import '../domain/models/view_support_history_list_response.dart';
import '../domain/models/view_theme_list_response.dart';
import '../domain/models/view_tribe_meter_completed_list_response.dart';
import '../domain/models/view_tribeo_meter_question_list_response.dart';
import '../domain/models/view_user_by_type_list_response.dart';
import '../domain/models/view_user_chat_messages_response.dart' hide SupportMessage;
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
  bool _isLoadingData = false;

  bool get isLoadingData => _isLoadingData;

  CotQuestionData? cotQuestionData;

  CotQuestionData? get getCotQuestionData => cotQuestionData;
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

  Map<int, int> counters = {};
  Map<int, int> countersUpdate = {};

  Map<int, String> selectedAnswers = {};


  Map<int, Map<int, int>> selectedScores = {};


  bool isPushNotification = false;

  Future<void> updateIsPushNotification(bool value, bool isNotify) async {
    HomeController homeController = Provider.of(Get.context!, listen: false);
    isPushNotification = value;
    bool deviceStatus = false;
    try {
      deviceStatus = await NotificationUtils.areNotificationsEnabled();
    } catch (e) {
      deviceStatus = false;
    }
    if (value) {
      homeController.savePushNotificationStatus(true);
      updatePushNotificationStatus(true, deviceStatus);
    } else {
      homeController.savePushNotificationStatus(false);
      updatePushNotificationStatus(false, deviceStatus);
    }
    if (isNotify) {
      notifyListeners();
    }
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
      filteredActions = viewActionList!.where((item) => item.tier?.toLowerCase() == newValue.toLowerCase()).toList();
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

      cotQuestionData = CotQuestionData.fromJson(map["data"]);
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
  ) async {
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

  void setAdapter(ViewCotFunctionalLensData? data) {}

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
      setAdapter(modelFutureLensDetails);
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

  Future<void> getDate(BuildContext context, String type) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      // disables past dates
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
      if (type == "dueData") {
        selectedDueData = formattedDate;
      } else {
        selectedStartData = formattedDate;
      }
    }
    notifyListeners();
  }

  void updateSelectedData(String type, String date) {
    if (type == "dueData") {
      selectedDueData = date;
    } else {
      selectedStartData = date;
    }
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

  Future<void> updateActionItemStatus(String actionId, String orgStatus) async {
    _isLoadingBtn = true;
    Map<String, dynamic> request = {"actionId": actionId, "orgStatus": orgStatus};
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

  Future<void> addActionData(ViewActionTierListData tier, ViewUserByTypeListData responsiblePerson, List<String> risks, String sDate, String dDate,
      String aStatus, String desc) async {
    _isLoading = true;
    notifyListeners();
    String orgId = userProfileData!.orgId.toString();
    if (tier.name!.toLowerCase() == "primary" ||
        tier.name!.toLowerCase() == "secondary" ||
        tier.name!.toLowerCase() == "tertiary" ||
        tier.name!.toLowerCase() == "individual") {
      officeId = "";
      departmentId = "";
    }
    Map<String, dynamic> mainObject = {
      "userId": userProfileData!.id,
      "startedDate": sDate,
      "dueDate": dDate,
      "tierId": tier.id,
      "departmentId": departmentId,
      "officeId": officeId,
      "IndividualUserId": "",
      "orgStatus": aStatus,
      "orgId": orgId,
      "description": desc,
      "responsibleUserId": responsiblePerson.id,
      "themeId": risks,
    };

    ApiResponse apiResponse = await profileServiceInterface!.addActionData(mainObject);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      selectedDueData = "";
      selectedStartData = "";
      actionStatus = "";
      selectedActionTierListData = null;
      selectedUserListData = null;
      Navigator.of(Get.context!).pop(true);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> updateActionData(String actionId, ViewActionTierListData tier, ViewUserByTypeListData responsiblePerson, List<String> risks,
      String sDate, String dDate, String aStatus, String desc) async {
    _isLoading = true;
    notifyListeners();
    String orgId = userProfileData!.orgId.toString();
    if (tier.name!.toLowerCase() == "primary" ||
        tier.name!.toLowerCase() == "secondary" ||
        tier.name!.toLowerCase() == "tertiary" ||
        tier.name!.toLowerCase() == "individual") {
      officeId = "";
      departmentId = "";
    }
    Map<String, dynamic> mainObject = {
      "userId": userProfileData!.id,
      "actionId": actionId,
      "startedDate": sDate,
      "dueDate": dDate,
      "tierId": tier.id,
      "departmentId": departmentId,
      "officeId": officeId,
      "IndividualUserId": "",
      "orgStatus": aStatus,
      "orgId": orgId,
      "description": desc,
      "responsibleUserId": responsiblePerson.id,
      "themeId": risks,
    };

    ApiResponse apiResponse = await profileServiceInterface!.updateActionData(mainObject);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      selectedDueData = "";
      selectedStartData = "";
      actionStatus = "";
      selectedActionTierListData = null;
      selectedUserListData = null;
      Navigator.of(Get.context!).pop(true);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  //-------------------comments--------------

  List<ViewCommentListData>? viewActionCommentList;
  TextEditingController commentController = TextEditingController();

  Future<void> viewActionComments(String actionId) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> mainObject = {
      "actionId": actionId,
    };

    ApiResponse apiResponse = await profileServiceInterface!.viewCommentList(mainObject);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewCommentListResponse response = ViewCommentListResponse.fromJson(map);
      viewActionCommentList = response.data;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> addActionComments(String actionId, String comment) async {
    _isLoadingBtn = true;
    notifyListeners();

    Map<String, dynamic> mainObject = {"actionId": actionId, "comment": comment};

    ApiResponse apiResponse = await profileServiceInterface!.addCommentList(mainObject);
    _isLoadingBtn = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      final newComment = ViewCommentListData.fromJson(map['data']);
      viewActionCommentList!.insert(0, newComment);
      commentController.clear();
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  //-----------------------------------
  Offices? officeSelectedValue;
  List<ViewDepartmentListData>? departmentList;
  List<Offices>? officesList;
  ViewDepartmentListData? departmentSelectedValue;
  String orgId = "";
  String userId = "";
  List<CultureIndex>? cultureIndexList;
  List<CultureIndex>? engagementIndexList;

  List<double> get sortedUniqueScores {
    final uniqueScores = cultureIndexList!.map((e) => e.data!).toSet().toList()..sort();
    return uniqueScores;
  }

  List<double> get sortedUniqueScoresEngagement {
    final uniqueScores = engagementIndexList!.map((e) => e.data!).toSet().toList()..sort();
    return uniqueScores;
  }

  Map<int, String> get cultureIndexLabels {
    return {
      for (int i = 0; i < cultureIndexList!.length; i++) i: cultureIndexList![i].monthName!,
    };
  }

  Map<int, String> get engagementIndexLabels {
    return {
      for (int i = 0; i < engagementIndexList!.length; i++) i: engagementIndexList![i].monthName!,
    };
  }

  List<FlSpot> get cultureIndexSpots {
    return cultureIndexList!
        .asMap()
        .entries
        .map((e) => FlSpot(
              e.key.toDouble(),
              double.tryParse(e.value.data.toString()) ?? 0,
            ))
        .toList();
  }

  double get engagementIndexMinY {
    final ys = engagementIndexSpots.map((e) => e.y);
    final min = ys.isEmpty ? 0 : ys.reduce((a, b) => a < b ? a : b);
    return min - 10; // add some padding
  }

  double get engagementIndexMaxY {
    final ys = engagementIndexSpots.map((e) => e.y);
    final max = ys.isEmpty ? 0 : ys.reduce((a, b) => a > b ? a : b);
    return max + 10; // add some padding
  }

  List<FlSpot> get engagementIndexSpots {
    return engagementIndexList!
        .asMap()
        .entries
        .map((e) => FlSpot(
              e.key.toDouble(),
              double.tryParse(e.value.data.toString()) ?? 0,
            ))
        .toList();
  }

  bool isCultureVisible = false;
  bool isEngagementVisible = false;
  bool isValueVisible = false;
  bool isTeamRoleVisible = false;
  bool isPersonalityTypeVisible = false;
  bool isCultureStructureVisible = false;
  bool isMotivationVisible = false;
  bool isDiagnosticsVisible = false;
  bool isTribeMeterVisible = false;
  bool isSentimentIndexVisible = false;
  List<ViewTeamRoleData> _viewTeamRoles = [];

  List<ViewTeamRoleData> get viewTeamRoles => _viewTeamRoles;
  List<GetCOTpersonalityType> _personalityTypes = [];

  List<GetCOTpersonalityType> get personalityTypes => _personalityTypes;

  List<double> get personalityTypesPercentages => _personalityTypes.map((e) => e.percentage!).toList();
  bool isQuestionnaireAnswerFilled = true;
  bool isUserFilledAnswer = false;
  List<Map<String, String>>? cultureStructureItems;
  List<SotSummary> sotSummaries = [];
  List<ModelMotivationGraph>? viewSOTMotivationReportList;
  List<GetDiagnosticReportForGraph>? getDiagnosticReportList;
  bool isDiagnosticAnsDone = false;
  bool isTribeMeterAnsDone = false;
  List<GetCOTpersonalityType>? getTribeMeterReportList;
  List<GetHappyIndexMonthGraphCount>? viewHappyIndexMonthGraphList;

  void updateCultureStatus() {
    if (isCultureVisible == true) {
      isCultureVisible = false;
    } else {
      isCultureVisible = true;
    }
    notifyListeners();
  }

  void updateEngagementStatus() {
    if (isEngagementVisible == true) {
      isEngagementVisible = false;
    } else {
      isEngagementVisible = true;
    }
    notifyListeners();
  }

  void updateValueStatus() {
    if (isValueVisible == true) {
      isValueVisible = false;
    } else {
      isValueVisible = true;
    }
    notifyListeners();
  }

  void updateTeamRoleStatus() {
    if (isTeamRoleVisible == true) {
      isTeamRoleVisible = false;
    } else {
      isTeamRoleVisible = true;
    }
    notifyListeners();
  }

  void updatePersonalityTypeVisibleStatus() {
    if (isPersonalityTypeVisible == true) {
      isPersonalityTypeVisible = false;
    } else {
      isPersonalityTypeVisible = true;
    }
    notifyListeners();
  }

  void updateCultureStructureVisibleStatus() {
    if (isCultureStructureVisible == true) {
      isCultureStructureVisible = false;
    } else {
      isCultureStructureVisible = true;
    }
    notifyListeners();
  }

  void updateMotivationVisibleStatus() {
    if (isMotivationVisible == true) {
      isMotivationVisible = false;
    } else {
      isMotivationVisible = true;
    }
    notifyListeners();
  }

  void updateDiagnosticsVisibleStatus() {
    if (isDiagnosticsVisible == true) {
      isDiagnosticsVisible = false;
    } else {
      isDiagnosticsVisible = true;
    }
    notifyListeners();
  }

  void updateTribeMeterVisibleStatus() {
    if (isTribeMeterVisible == true) {
      isTribeMeterVisible = false;
    } else {
      isTribeMeterVisible = true;
    }
    notifyListeners();
  }

  void updateSentimentIndexVisibleStatus() {
    if (isSentimentIndexVisible == true) {
      isSentimentIndexVisible = false;
    } else {
      isSentimentIndexVisible = true;
    }
    notifyListeners();
  }

  String getTeamRolePercentage(String roleKey) {
    final role = _viewTeamRoles.firstWhere(
      (r) => r.key.toLowerCase().contains(roleKey.toLowerCase()),
      orElse: () => ViewTeamRoleData(key: '', percentage: '0', description: '0.00'),
    );
    return role.description;
  }

  void setTeamRoles(Map<String, dynamic> json) {
    final mapers = json["getCOTteamRoleMapReport"] as Map<String, dynamic>;

    _viewTeamRoles = [
      ViewTeamRoleData(
        key: "Shaper",
        percentage: json["shaper"] ?? "0",
        description: mapers["shaper"] ?? "",
      ),
      ViewTeamRoleData(
        key: "Coordinator",
        percentage: json["coordinator"] ?? "0",
        description: mapers["coordinator"] ?? "",
      ),
      ViewTeamRoleData(
        key: "Completer Finisher",
        percentage: json["completerFinisher"] ?? "0",
        description: mapers["completerFinisher"] ?? "",
      ),
      ViewTeamRoleData(
        key: "Teamworker",
        percentage: json["teamworker"] ?? "0",
        description: mapers["teamworker"] ?? "",
      ),
      ViewTeamRoleData(
        key: "Implementer",
        percentage: json["implementer"] ?? "0",
        description: mapers["implementer"] ?? "",
      ),
      ViewTeamRoleData(
        key: "Monitor Evaluator",
        percentage: json["monitorEvaluator"] ?? "0",
        description: mapers["monitorEvaluator"] ?? "",
      ),
      ViewTeamRoleData(
        key: "Plant",
        percentage: json["plant"] ?? "0",
        description: mapers["plant"] ?? "",
      ),
      ViewTeamRoleData(
        key: "Resource Investigator",
        percentage: json["resourceInvestigator"] ?? "0",
        description: mapers["resourceInvestigator"] ?? "",
      ),
    ];

    notifyListeners();
  }

  void setCultureStructureData(Map<String, dynamic> json) {
    isQuestionnaireAnswerFilled = json['IsQuestionnaireAnswerFilled'] != false;
    isUserFilledAnswer = json['IsUserFilledAnswer'] ?? false;

    final rawItems = (json['sotDetailArray'] as List<dynamic>?) ?? [];
    cultureStructureItems = List.generate(
      4,
      (index) {
        if (index < rawItems.length) {
          final item = rawItems[index];
          return {
            "label": item['title'] ?? "",
            "value": item['SOTCount'] ?? "0",
          };
        }
        return {"label": "", "value": "0"};
      },
    );

    // Clear previous summaries
    sotSummaries = [];

    final rawSummaries = (json['sotSummaryDetailArray'] as List<dynamic>?) ?? [];
    for (var s in rawSummaries) {
      final summariesList = (s['summary'] as List<dynamic>?)?.map((e) => e['summary'].toString()).toList() ?? [];
      sotSummaries.add(
        SotSummary(
          id: s['id'].toString(),
          type: s['type'] ?? "",
          title: s['title'] ?? "",
          imgUrl: s['imgUrl'] ?? "",
          sotCount: s['SOTCount'] ?? "",
          summaries: summariesList,
        ),
      );
    }
    notifyListeners();
  }

  void updateOfficeSelectedValue(Offices? data) {
    officeSelectedValue = data!;

    departmentList = [];
    departmentList!.add(ViewDepartmentListData(id: 0, department: 'All Departments'));

    if (data.officeId == 0) {
      // Load all departments from API
      viewDepartmentList();
    } else {
      // Filter departments linked to selected office
      for (var officeDept in officesList!) {
        if (officeDept.officeId == data.officeId) {
          departmentList!.addAll(officeDept.department!);
        }
      }
    }
    departmentSelectedValue = departmentList!.first;
    viewOrgDashboardReportWithFilter(false);
    notifyListeners();
  }

  void updateOrgID(ViewUserProfileData? data) {
    orgId = data!.orgId.toString();
    userId = data.id.toString();
    notifyListeners();
  }

  void updateDepartmentSelectedValue(ViewDepartmentListData? data) {
    if (departmentSelectedValue?.id != data!.id) {
      departmentSelectedValue = data;
      viewOrgDashboardReportWithFilter(false);
    }
    notifyListeners();
  }

  void updateLoaderStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Future<void> viewDepartmentList() async {
    ApiResponse apiResponse = await profileServiceInterface!.viewDepartmentList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewDepartmentListResponse response = ViewDepartmentListResponse.fromJson(map);

      departmentList = [];
      ViewDepartmentListData data0 = ViewDepartmentListData(id: 0, department: "All Departments");
      departmentList!.add(data0);
      for (var i = 0; i < response.data!.length; i++) {
        departmentList!.add(response.data![i]);
      }
      departmentSelectedValue = departmentList![0];
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewOfficeList() async {
    Map<String, dynamic> requestData = {
      "orgId": orgId,
    };
    ApiResponse apiResponse = await profileServiceInterface!.viewOfficeList(requestData);
    updateLoaderStatus(false);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewOfficeListResponse response = ViewOfficeListResponse.fromJson(map);

      officesList = [];
      Offices data0 = Offices(officeId: 0, department: departmentList, office: "All Offices");
      officesList!.add(data0);
      for (var i = 0; i < response.data!.offices!.length; i++) {
        officesList!.add(response.data!.offices![i]);
      }
      officeSelectedValue = officesList![0];
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewOrgDashboardReportWithFilter(bool isFirstTime) async {
    _isLoadingBtn = true;
    notifyListeners();

    Map<String, dynamic> mainObject = {"orgId": orgId, "officeId": officeSelectedValue!.officeId, "departmentId": departmentSelectedValue!.id};

    ApiResponse apiResponse = await profileServiceInterface!.viewOrgDashboardReportWithFilter(mainObject);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewStudiesListResponse response = ViewStudiesListResponse.fromJson(map);
      ViewStudiesListData? mainData = response.data;
      cultureIndexList = mainData!.cultureIndex;
      engagementIndexList = mainData.engagementIndex;
      _personalityTypes = mainData.getCOTpersonalityType!;
      setTeamRoles(map["data"]);
      setCultureStructureData(map["data"]["getSOTcultureStructureReport"]);
      viewSOTMotivationReportList = mainData.getSOTmotivationReport;
      getDiagnosticReportList = mainData.getDiagnosticReportForGraph;
      isDiagnosticAnsDone = mainData.orgStatus!.isDiagnosticAnsDone!;
      isTribeMeterAnsDone = mainData.orgStatus!.isTribeometerAnsDone!;
      getTribeMeterReportList = mainData.getTribeometerReportForGraph;
      viewHappyIndexMonthGraphList = mainData.getHappyIndexMonthGraphCount;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    _isLoadingBtn = false;
    notifyListeners();
  }

  //--------------------------------------------
  List<ViewSotQuestionListData>? viewSotQuestionList;
  List<ViewSotQuestionAnswersListData>? viewSotQuestionCompletedList;

  void selectOption(int questionIndex, int optionIndex) {
    if (viewSotQuestionList == null || questionIndex < 0 || questionIndex >= viewSotQuestionList!.length) return;

    final options = viewSotQuestionList![questionIndex].option ?? [];
    if (optionIndex < 0 || optionIndex >= options.length) return;

    for (var o in options) {
      o.isChecked = false;
    }
    options[optionIndex].isChecked = true;
    notifyListeners();
  }

  void selectOptionCompleted(int questionIndex, int optionIndex) {
    if (viewSotQuestionCompletedList == null || questionIndex < 0 || questionIndex >= viewSotQuestionCompletedList!.length) {
      return;
    }

    final options = viewSotQuestionCompletedList![questionIndex].option ?? [];
    if (optionIndex < 0 || optionIndex >= options.length) return;

    for (var o in options) {
      o.isChecked = false;
    }
    options[optionIndex].isChecked = true;
    notifyListeners();
  }

  String getSotQuestionListData() {
    return profileServiceInterface!.getSotQuestionListData();
  }

  Future<void> saveSotQuestionListData() async {
    final jsonList = viewSotQuestionList!.map((q) => q.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    profileServiceInterface!.saveSotQuestionListData(jsonString);
  }

  Future<void> validateAndSubmitSotAnswers(BuildContext context) async {
    // Clear old answers
    List<String> liAnswers = [];

    if (viewSotQuestionList == null) {
      showCustomSnackBar("No questions available.", context);
      return;
    }

    for (int i = 0; i < viewSotQuestionList!.length; i++) {
      int count = 0;
      final options = viewSotQuestionList![i].option ?? [];

      for (int j = 0; j < options.length; j++) {
        if (options[j].isChecked) {
          liAnswers.add(options[j].id.toString());
        } else {
          count++;
        }
      }

      if (count >= 4) {
        final qusNo = i + 1;
        showCustomSnackBar(
          "Please agree with a statement for Question $qusNo",
          context,
          isError: true,
        );
        return;
      }
    }

    if (liAnswers.length != viewSotQuestionList!.length) {
      showCustomSnackBar(
        "Please complete all questions before submitting.",
        context,
        isError: true,
      );
      return;
    } else {
      await sendSotQuestionData(liAnswers, context);
    }
  }

  Future<void> viewSotQuestionListAPI({String? savedJsonList}) async {
    _isLoading = true;

    ApiResponse apiResponse = await profileServiceInterface!.viewSotQuestionList();
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final response = ViewSotQuestionListResponse.fromJson(apiResponse.response!.data);
      viewSotQuestionList = response.data ?? [];

      if (savedJsonList != null && savedJsonList.isNotEmpty && savedJsonList != "[]") {
        try {
          List<dynamic> savedJson = jsonDecode(savedJsonList);

          for (int i = 0; i < savedJson.length; i++) {
            if (i >= viewSotQuestionList!.length) continue;

            Map<String, dynamic> savedQuestion = savedJson[i];
            List<dynamic>? savedOptions = savedQuestion['option'];

            if (savedOptions == null || savedOptions.isEmpty) continue;

            // Step 1: Clear all isChecked flags first
            viewSotQuestionList![i].option?.forEach((o) => o.isChecked = false);

            // Step 2: Set only saved checked option(s)
            for (var savedOpt in savedOptions) {
              if (savedOpt['isChecked'] == true) {
                final savedId = savedOpt['id'];
                final savedSection = savedOpt['section'];
                final savedType = savedOpt['type'];

                viewSotQuestionList![i].option?.forEach((opt) {
                  if (opt.id == savedId && opt.section == savedSection && opt.type == savedType) {
                    opt.isChecked = true;
                  }
                });
              }
            }
          }
        } catch (e) {
          debugPrint('Error merging saved answers: $e');
        }
      }
    } else {
      showCustomSnackBar(
        apiResponse.error ?? "Something went wrong",
        Get.context!,
        isError: true,
      );
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
  }

  Future<void> sendSotQuestionData(List<String> liAnswers, BuildContext context) async {
    _isLoadingBtn = true;
    notifyListeners();

    try {
      // Build payload
      final Map<String, dynamic> payload = {
        "answer": liAnswers.map((id) => {"id": id}).toList(),
      };

      ApiResponse apiResponse = await profileServiceInterface!.sendSotQuestionListData(payload);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        String msg = apiResponse.response!.data['message'] ?? "Submission successful";
        showCustomSnackBar(msg, Get.context!, isError: false);

        profileServiceInterface!.clearSotQuestionListData();
        viewSotQuestionList = null;

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

  Future<void> validateAndSubmitSotAnswersCompleted(BuildContext context) async {
    // Clear old answers
    List<String> liAnswers = [];

    if (viewSotQuestionCompletedList == null) {
      showCustomSnackBar("No questions available.", context);
      return;
    }

    for (int i = 0; i < viewSotQuestionCompletedList!.length; i++) {
      int count = 0;
      final options = viewSotQuestionCompletedList![i].option ?? [];

      for (int j = 0; j < options.length; j++) {
        if (options[j].isChecked!) {
          liAnswers.add(options[j].id.toString());
        } else {
          count++;
        }
      }

      if (count >= 4) {
        final qusNo = i + 1;
        showCustomSnackBar(
          "Please agree with a statement for Question $qusNo",
          context,
          isError: true,
        );
        return;
      }
    }

    if (liAnswers.length != viewSotQuestionCompletedList!.length) {
      showCustomSnackBar(
        "Please complete all questions before submitting.",
        context,
        isError: true,
      );
      return;
    } else {
      await sendSotQuestionCompletedData(liAnswers, context);
    }
  }

  Future<void> sendSotQuestionCompletedData(List<String> liAnswers, BuildContext context) async {
    _isLoadingBtn = true;
    notifyListeners();

    try {
      // Build payload
      final Map<String, dynamic> payload = {
        "answer": liAnswers.map((id) => {"id": id}).toList(),
      };

      ApiResponse apiResponse = await profileServiceInterface!.sendSotQuestionListCompletedData(payload);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        String msg = apiResponse.response!.data['message'] ?? "Submission successful";
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

  Future<void> viewCompletedSotQuestionListAPI() async {
    _isLoading = true;

    ApiResponse apiResponse = await profileServiceInterface!.viewSotQuestionCompletedList();
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final response = ViewSotQuestionAnswersListResponse.fromJson(apiResponse.response!.data);
      viewSotQuestionCompletedList = response.data ?? [];
    } else {
      showCustomSnackBar(
        apiResponse.error ?? "Something went wrong",
        Get.context!,
        isError: true,
      );
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  //-------------------------------------------

  List<ViewDiagnosticQuestionListData>? viewDiagnosticQuestionList;
  List<ViewDiagnosticCompletedQuestionListData>? viewDiagnosticCompletedQuestionList;

  String getDiagnosticListData() {
    return profileServiceInterface!.getDiagnosticListData();
  }

  Future<void> saveDiagnosticQuestionListData() async {
    final jsonList = viewDiagnosticQuestionList!.map((q) => q.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    profileServiceInterface!.saveDiagnosticQuestionListData(jsonString);
  }

  void selectDiagnosticOption(int questionIndex, int selectedOptionNumber) {
    viewDiagnosticQuestionList![questionIndex].answer = selectedOptionNumber.toString();
    notifyListeners();
  }

  void selectDiagnosticCompletedOption(int questionIndex, int selectedOptionId) {
    final question = viewDiagnosticCompletedQuestionList![questionIndex];
    for (final option in question.options!) {
      option.isChecked = option.optionId == selectedOptionId;
    }
    notifyListeners();
  }

  void validateAndSubmitAnswersDiagnostic(BuildContext context) {
    final questions = viewDiagnosticQuestionList ?? [];

    int count = 0;
    for (final question in questions) {
      if (question.answer.trim().isEmpty) {
        showCustomSnackBar("${getTranslated("please_agree_with_a_statement_for_question", context)} ${question.questionId}", context);
        return; // Stop execution
      } else {
        count++;
      }
    }

    if (count == questions.length) {
      sendDiagnosticQuestionListData(context);
    }
  }

  void validateAndSubmitAnswersCompletedDiagnostic(BuildContext context) {
    final questions = viewDiagnosticCompletedQuestionList ?? [];

    int count = 0;
    for (final question in questions) {
      if (question.answerId == null || question.answerId == 0) {
        showCustomSnackBar(
          "${getTranslated("please_agree_with_a_statement_for_question", context)} ${question.questionId}",
          context,
        );
        return; // Stop execution if any unanswered
      } else {
        count++;
      }
    }

    if (count == questions.length) {
      sendDiagnosticQuestionCompletedListData(context);
    }
  }

  Map<String, dynamic> buildAnswersJson(List<ViewDiagnosticQuestionListData> questions) {
    final List<Map<String, dynamic>> answerList = [];

    for (final q in questions) {
      answerList.add({
        "questionId": q.questionId?.toString() ?? "",
        "optionId": q.answer,
      });
    }

    return {
      "answer": answerList,
    };
  }

  Map<String, dynamic> buildCompletedDiagnosticAnswerPayload(List<ViewDiagnosticCompletedQuestionListData> diagnostics) {
    final List<Map<String, dynamic>> answerList = [];

    for (final diagnostic in diagnostics) {
      // Find the option marked as selected
      final selectedOption = diagnostic.options?.firstWhere(
        (o) => o.isChecked == true,
        orElse: () => ViewDiagnosticCompletedQuestionListOptions(),
      );

      answerList.add({
        "answerId": diagnostic.answerId?.toString() ?? "",
        "optionId": selectedOption?.optionId?.toString() ?? "",
      });
    }

    return {
      "answer": answerList,
    };
  }

  Future<void> viewDiagnosticQuestionListAPI({String? savedJsonList}) async {
    _isLoading = true;

    ApiResponse apiResponse = await profileServiceInterface!.viewDiagnosticQuestionList();
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final response = ViewDiagnosticQuestionListResponse.fromJson(apiResponse.response!.data);
      viewDiagnosticQuestionList = response.data ?? [];

      if (savedJsonList != null && savedJsonList.isNotEmpty && savedJsonList != "[]") {
        try {
          List<dynamic> savedJson = jsonDecode(savedJsonList);

          for (int i = 0; i < savedJson.length; i++) {
            if (i >= viewDiagnosticQuestionList!.length) continue;

            Map<String, dynamic> savedItem = savedJson[i];
            String savedAnswer = savedItem['answer'] ?? "";

            viewDiagnosticQuestionList![i].answer = savedAnswer;
          }
        } catch (e) {
          debugPrint('Error merging saved answers: $e');
        }
      }
    } else {
      showCustomSnackBar(
        apiResponse.error ?? "Something went wrong",
        Get.context!,
        isError: true,
      );
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
  }

  Future<void> sendDiagnosticQuestionListData(BuildContext context) async {
    _isLoadingBtn = true;
    notifyListeners();

    try {
      final questions = viewDiagnosticQuestionList ?? [];
      final jsonMap = buildAnswersJson(questions);

      ApiResponse apiResponse = await profileServiceInterface!.sendDiagnosticQuestionListData(jsonMap);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        String msg = apiResponse.response!.data['message'] ?? "Submission successful";
        showCustomSnackBar(msg, Get.context!, isError: false);

        profileServiceInterface!.clearDiagnosticQuestionListData();

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

  Future<void> viewDiagnosticCompletedQuestionListAPI() async {
    _isLoading = true;

    ApiResponse apiResponse = await profileServiceInterface!.viewDiagnosticCompletedQuestionList();
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final response = ViewDiagnosticCompletedQuestionListResponse.fromJson(apiResponse.response!.data);
      viewDiagnosticCompletedQuestionList = response.data ?? [];
    } else {
      showCustomSnackBar(
        apiResponse.error ?? "Something went wrong",
        Get.context!,
        isError: true,
      );
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
  }

  Future<void> sendDiagnosticQuestionCompletedListData(BuildContext context) async {
    _isLoadingBtn = true;
    notifyListeners();

    try {
      final questions = viewDiagnosticCompletedQuestionList ?? [];
      final jsonMap = buildCompletedDiagnosticAnswerPayload(questions);
      ApiResponse apiResponse = await profileServiceInterface!.sendDiagnosticCompletedQuestionListData(jsonMap);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        String msg = apiResponse.response!.data['message'] ?? "Submission successful";
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

  //---------------------------------------------------------

  List<ViewTribeMeterQuestionListData>? viewTribeMeterQuestionList;
  List<ViewTribeMeterCompletedListData>? viewTribeMeterQuestionCompleteList;

  String getTribeMeterListData() {
    return profileServiceInterface!.getTribeMeterQuestionListData();
  }

  Future<void> saveTribeMeterQuestionListData() async {
    final jsonList = viewTribeMeterQuestionList!.map((q) => q.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    profileServiceInterface!.saveTribeMeterQuestionListData(jsonString);
  }

  void selectAnswerForQuestion({
    required int questionIndex,
    required int optionIndex,
  }) {
    final question = viewTribeMeterQuestionList![questionIndex];
    for (var opt in question.options!) {
      opt.isSelected = false;
    }
    question.options![optionIndex].isSelected = true;
    question.answer = question.options![optionIndex].optionId.toString();
    notifyListeners();
  }

  void selectAnswerForQuestionComplete({
    required int questionIndex,
    required int optionIndex,
  }) {
    final question = viewTribeMeterQuestionCompleteList![questionIndex];
    for (final opt in question.options!) {
      opt.isChecked = false;
    }
    final selectedOption = question.options![optionIndex];
    selectedOption.isChecked = true;
    question.answerId = selectedOption.optionId;
    notifyListeners();
  }

  void validateAndSubmitAnswersTribeMeter(BuildContext context) {
    final questions = viewTribeMeterQuestionList ?? [];

    for (final question in questions) {
      if (question.answer == null || question.answer!.trim().isEmpty) {
        showCustomSnackBar(
          "${getTranslated("please_agree_with_a_statement_for_question", context)} ${question.questionId}",
          context,
        );
        return; // stop execution
      }
    }
    sendTribeMeterQuestionListData(context);
  }

  void validateAndSubmitAnswersCompleteTribeMeter(BuildContext context) {
    final questions = viewTribeMeterQuestionCompleteList ?? [];

    for (final question in questions) {
      if (question.answerId == null) {
        showCustomSnackBar(
          "${getTranslated("please_agree_with_a_statement_for_question", context)} ${question.questionId}",
          context,
        );
        return; // Stop execution if any unanswered
      }
    }
    sendTribeMeterQuestionCompleteListData(context);
  }

  Map<String, dynamic> createTribeMeterAnswerJson(List<ViewTribeMeterQuestionListData> questions) {
    List<Map<String, dynamic>> answerList = [];

    for (var q in questions) {
      if (q.questionId != null && q.answer != null && q.answer!.isNotEmpty) {
        answerList.add({
          "questionId": q.questionId.toString(),
          "optionId": q.answer.toString(),
        });
      }
    }

    return {
      "answer": answerList,
    };
  }

  Map<String, dynamic> createTribeMeterCompleteAnswerJson(List<ViewTribeMeterCompletedListData> questions) {
    List<Map<String, dynamic>> answerList = [];

    for (var q in questions) {
      int? finalOptionId;

      // If any option is checked, get its optionId (1-4)
      if (q.options != null && q.options!.isNotEmpty) {
        final checkedOption = q.options!.firstWhere(
          (opt) => opt.isChecked == true,
          orElse: () => ViewTribeMeterCompletedListOptions(),
        );

        if (checkedOption.optionId != null) {
          finalOptionId = checkedOption.optionId;
        }
      }

      // Fallback: if no option was checked but answerId exists, try to match it to optionId
      if (finalOptionId == null && q.answerId != null && q.options != null) {
        for (final opt in q.options!) {
          if (opt.answerId == q.answerId) {
            finalOptionId = opt.optionId;
            break;
          }
        }
      }

      if (q.questionId != null && finalOptionId != null) {
        answerList.add({
          "questionId": q.questionId.toString(),
          "optionId": finalOptionId.toString(), // always 1,2,3,4
        });
      }
    }

    return {
      "answer": answerList,
    };
  }

  Future<void> viewTribeMeterQuestionListAPI({String? savedJsonList}) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await profileServiceInterface!.viewTribeMeterQuestionList();
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final response = ViewTribeMeterQuestionListResponse.fromJson(apiResponse.response!.data);
      viewTribeMeterQuestionList = response.data ?? [];

      if (savedJsonList != null && savedJsonList.isNotEmpty && savedJsonList != "[]") {
        try {
          List<dynamic> savedJson = jsonDecode(savedJsonList);

          for (var savedItem in savedJson) {
            final savedQid = savedItem['questionId'];
            final savedAnswer = savedItem['answer'] ?? "";

            ViewTribeMeterQuestionListData? matchedQuestion;
            try {
              matchedQuestion = viewTribeMeterQuestionList!.firstWhere(
                (q) => q.questionId == savedQid,
              );
            } catch (_) {
              matchedQuestion = null;
            }

            if (matchedQuestion != null) {
              matchedQuestion.answer = savedAnswer;

              // ✅ Highlight the previously selected option
              for (var opt in matchedQuestion.options ?? []) {
                opt.isSelected = (opt.optionId.toString() == savedAnswer);
              }
            }
          }
        } catch (e) {
          debugPrint('Error merging saved answers: $e');
        }
      }
    } else {
      showCustomSnackBar(
        apiResponse.error ?? "Something went wrong",
        Get.context!,
        isError: true,
      );
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> sendTribeMeterQuestionListData(BuildContext context) async {
    _isLoadingBtn = true;
    notifyListeners();
    try {
      final jsonBody = createTribeMeterAnswerJson(viewTribeMeterQuestionList ?? []);
      ApiResponse apiResponse = await profileServiceInterface!.sendTribeMeterQuestionListData(jsonBody);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        String msg = apiResponse.response!.data['message'] ?? "Submission successful";
        showCustomSnackBar(msg, Get.context!, isError: false);

        profileServiceInterface!.clearTribeMeterQuestionListData();

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

  Future<void> viewTribeMeterQuestionCompleteListAPI() async {
    _isLoading = true;
    ApiResponse apiResponse = await profileServiceInterface!.viewTribeMeterQuestionCompletedList();
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final response = ViewTribeMeterCompletedListResponse.fromJson(apiResponse.response!.data);
      viewTribeMeterQuestionCompleteList = response.data ?? [];
    } else {
      showCustomSnackBar(
        apiResponse.error ?? "Something went wrong",
        Get.context!,
        isError: true,
      );
      ApiChecker.checkApi(apiResponse);
    }

    notifyListeners();
  }

  Future<void> sendTribeMeterQuestionCompleteListData(BuildContext context) async {
    _isLoadingBtn = true;
    notifyListeners();
    try {
      final jsonBody = createTribeMeterCompleteAnswerJson(viewTribeMeterQuestionCompleteList ?? []);
      ApiResponse apiResponse = await profileServiceInterface!.sendTribeMeterQuestionCompleteListData(jsonBody);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        String msg = apiResponse.response!.data['message'] ?? "Submission successful";
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

//-----------------------------------------
  TextEditingController tellUsController = TextEditingController();
  FocusNode tellUsFocus = FocusNode();
  File? file;

  void updateFileData(File data) {
    file = data;
    notifyListeners();
  }

  void updateInitData() {
    tellUsController.text = "";
    file = null;
    notifyListeners();
  }

  void initData() {
    tellUsController = TextEditingController();
    tellUsFocus = FocusNode();
    file = null;
  }

  List<ViewSupportHistoryListData>? supportHistoryData;
  List<ViewUserChatMessages>? messagesList;
  ViewUserChatSupportMessage? supportMessage;

  Future<void> viewSupportHistoryListAPI() async {
    _isLoading = true;

    Map<String, dynamic> request = {"Page": 1, "userId": userProfileData!.id.toString()};

    ApiResponse apiResponse = await profileServiceInterface!.viewSupportHistoryList(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final response = ViewSupportHistoryListResponse.fromJson(apiResponse.response!.data);
      supportHistoryData = response.data ?? [];
    } else {
      showCustomSnackBar(
        apiResponse.error ?? "Something went wrong",
        Get.context!,
        isError: true,
      );
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<ApiResponse> sendOffloadingData(String message, String image) async {
    _isLoadingBtn = true;
    notifyListeners();
    Map<String, dynamic> request = {"message": message, "userId": userProfileData!.id, "orgId": userProfileData!.orgId, "image": image};
    ApiResponse apiResponse = await profileServiceInterface!.addCustomerSupport(request);
    _isLoadingBtn = false;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> viewChatMessages(int feedbackId) async {
    Map<String, dynamic> request = {"supportId": feedbackId};
    ApiResponse apiResponse = await profileServiceInterface!.viewChatMessages(request);
    Map<String, dynamic> map = apiResponse.response!.data;
    ViewUserChatMessagesResponse response = ViewUserChatMessagesResponse.fromJson(map);
    messagesList = [];
    messagesList = response.data!.messages!;
    supportMessage = response.data!.supportMessage;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> sendChatMessages(String msgType, String message, String feedbackId) async {
    _isLoadingData = true;
    notifyListeners();
    Map<String, dynamic> request = {"sendFrom": userProfileData!.id, "sendTo": "1", "message": message, "supportId": feedbackId, "postType": msgType};
    ApiResponse apiResponse = await profileServiceInterface!.sendChatMessages(request);
    _isLoadingData = false;
    updateInitData();
    viewChatMessages(int.parse(feedbackId.toString()));
    notifyListeners();
    return apiResponse;
  }

  Future<void> updatePushNotificationStatus(bool status, bool deviceValue) async {
    int statusValue = 0;
    if (status) {
      statusValue = 1;
    } else {
      statusValue = 0;
    }

    //0: not enable , 1: enable

    int deviceStatus = 0;
    if (deviceValue) {
      deviceStatus = 1;
    } else {
      deviceStatus = 0;
    }
    Map<String, dynamic> requestData = {"userId": userProfileData!.id!, "appStatus": statusValue, "deviceStatus": deviceStatus};

    ApiResponse apiResponse = await profileServiceInterface!.updatePushNotificationStatus(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  List<ViewActionListData>? viewActionDetailsList;
  ViewActionListData? viewActionDetailsData;

  Future<ApiResponse> viewActionDetail(String actionId) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> request = {
      "actionId": actionId,
    };

    ApiResponse apiResponse = await profileServiceInterface!.viewActionDetail(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewActionDetailResponse response = ViewActionDetailResponse.fromJson(map);
      viewActionDetailsList = response.data;
      viewActionDetailsData = viewActionDetailsList![0];
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }
}
