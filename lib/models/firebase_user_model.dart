class UserRequestFirebase {

  final int id;
  final String username;
  final String? firstname;
  final String? lastname;
  final String? phone;
  final String? email;
  final String? avatar;
  final String? sex;
  final String? role;
  final DateTime createDate;
  final DateTime modifiedDate;
  final bool status;

  UserRequestFirebase({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.sex,
    required this.role,
    required this.createDate,
    required this.modifiedDate,
    required this.status
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "avatar": avatar,
    "sex": sex,
    "role": role,
    "createDate": createDate.toIso8601String(),
    "modifiedDate": modifiedDate.toIso8601String(),
    "status" : status
  };
}
