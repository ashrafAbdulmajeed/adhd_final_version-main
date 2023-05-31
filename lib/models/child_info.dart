class ChildModel {
  String? id;
  String? name;
  String? gender;
  int? age;
  String? adhdResult;
  String? adhdResultAr;
  String? levelResultAr;

  String? levelResult;
  bool? isChild;

  ChildModel({
    this.id,
    this.name,
    this.gender,
    this.age,
    this.adhdResult,
    this.adhdResultAr,
    this.levelResultAr,
    this.levelResult,
    this.isChild,
  });

  ChildModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    adhdResultAr = json['resultAr'];
    levelResultAr = json['levelResultAr'];
    adhdResult = json['adhdResult'];
    levelResult = json['levelResult'];
    isChild = json['isChild'];
  }
}
