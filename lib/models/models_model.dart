// generative constrcutor - always return new instance of the class
// hence no return keyword is used
class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.id,
    required this.created,
    required this.root,
  });
  // factory constructor - it can be used when u dont neccessarily want a constructor to create a new instance of ur class
  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        id: json["id"],
        created: json["created"],
        root: json["root"],
      );

  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}
