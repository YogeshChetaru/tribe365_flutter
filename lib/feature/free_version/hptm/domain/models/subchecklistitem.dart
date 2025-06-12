class SubChecklistItem {
  final int checklistId;
  final int? principleId;
  final int typeId;
  final String link;
  final String document;
  final String checklistTitle;
  final String description;
  final String learningTypeTitle;
  bool userReadChecklist;

  SubChecklistItem({
    required this.checklistId,
    this.principleId,
    required this.typeId,
    required this.link,
    required this.document,
    required this.checklistTitle,
    required this.description,
    required this.learningTypeTitle,
    this.userReadChecklist = false,
  });

  factory SubChecklistItem.fromJson(Map<String, dynamic> json) {
    return SubChecklistItem(
      checklistId: json['checklistId'],
      principleId: json['principleId'],
      typeId: json['typeId'],
      link: json['link'],
      document: json['document'],
      checklistTitle: json['checklistTitle'],
      description: json['description'],
      learningTypeTitle: json['learningTypeTitle'],
      userReadChecklist: json['userReadChecklist'] ?? false,
    );
  }
}