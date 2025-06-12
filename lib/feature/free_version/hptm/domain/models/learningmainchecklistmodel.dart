import 'package:tribe365_new/feature/free_version/hptm/domain/models/subchecklistitem.dart';

class LearningMainCheckListModel {
  final Map<String, List<SubChecklistItem>> learningCheckList;
  final List<String> learningTypeArr;

  LearningMainCheckListModel({
    required this.learningCheckList,
    required this.learningTypeArr,
  });

  factory LearningMainCheckListModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<SubChecklistItem>> checklistMap = {};
    final rawChecklist = json['data']['learningCheckList'] as Map<String, dynamic>;

    rawChecklist.forEach((key, value) {
      final itemList = (value as List)
          .map((item) => SubChecklistItem.fromJson(item))
          .toList();
      if (itemList.isNotEmpty) {
        checklistMap[key] = itemList;
      }
    });

    return LearningMainCheckListModel(
      learningCheckList: checklistMap,
      learningTypeArr: List<String>.from(json['data']['learningTypeArr'])
          .where((title) => checklistMap.containsKey(title))
          .toList(),
    );
  }
}