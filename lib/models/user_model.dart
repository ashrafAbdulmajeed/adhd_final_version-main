//model for users
class UserModel {
  String? id;
  String? username;
  String? phone;
  String? email;
  String? password;
  String? date;
  bool? isVerfied = false;
  String? image;
  String? role;
  int? permissions; //

  UserModel({
    this.permissions,
    this.role,
    this.id,
    this.username,
    this.phone,
    this.email,
    this.password,
    this.date,
    this.isVerfied,
    this.image,
  });

  UserModel.withId({
    this.id,
    this.username,
    this.phone,
    this.email,
    this.password,
    this.date,
    this.isVerfied,
    this.image,
    this.permissions,
    this.role,
  });

//convert text to map to be stored
  //TODO

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["username"] = username;
    map["phone"] = phone;
    map["email"] = email;
    map["password"] = password;
    map["date"] = date;
    map["isVerfied"] = isVerfied;
    map["image"] = image;
    map["role"] = role;
    map["permissions"] = permissions;
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.withId(
      id: map['id'],
      username: map['username'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
      date: map['date'],
      isVerfied: map['isVerfied'],
      image: map['image'],
      role: map['role'],
      permissions: map['permissions'],
    );
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? phone,
    String? email,
    String? password,
    String? date,
    bool? isVerfied,
    String? image,
    String? role,
    int? permissions,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      date: date ?? this.date,
      isVerfied: isVerfied ?? this.isVerfied,
      image: image ?? this.image,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
    );
  }
}
