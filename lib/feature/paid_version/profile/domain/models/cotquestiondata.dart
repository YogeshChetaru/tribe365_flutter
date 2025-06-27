class CotQuestionData {
  final Map<String, int> scores;
  final Map<String, int> totalKeyCounts;
  final Map<String, String> mappers;

  CotQuestionData({
    required this.scores,
    required this.totalKeyCounts,
    required this.mappers,
  });

  factory CotQuestionData.fromJson(Map<String, dynamic> json) {
    return CotQuestionData(
      scores: {
        "resourceInvestigator": json["resourceInvestigator"] ?? 0,
        "implementer": json["implementer"] ?? 0,
        "monitorEvaluator": json["monitorEvaluator"] ?? 0,
        "plant": json["plant"] ?? 0,
        "coordinator": json["coordinator"] ?? 0,
        "completerFinisher": json["completerFinisher"] ?? 0,
        "teamworker": json["teamworker"] ?? 0,
        "shaper": json["shaper"] ?? 0,
      },
      totalKeyCounts: Map<String, int>.from(
        json["totalKeyCount"] ?? {},
      ),
      mappers: Map<String, String>.from(
        json["mapersArray"] ?? {},
      ),
    );
  }
}