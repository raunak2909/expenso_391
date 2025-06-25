import 'package:expenso_391/data/local/helper/db_helper.dart';

class UserModel{
  int? id;
  String name;
  String email;
  String mobNo;
  String pass;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.mobNo,
    required this.pass,
  });

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
        name: map[DBHelper.COLUMN_USER_NAME],
        email: map[DBHelper.COLUMN_USER_EMAIL],
        mobNo: map[DBHelper.COLUMN_USER_MOB_NO],
        pass: map[DBHelper.COLUMN_USER_PASS]);
  }

  Map<String, dynamic> toMap(){
    return {
      DBHelper.COLUMN_USER_NAME : name,
      DBHelper.COLUMN_USER_EMAIL : email,
      DBHelper.COLUMN_USER_MOB_NO : mobNo,
      DBHelper.COLUMN_USER_PASS: pass,
    };
  }

}