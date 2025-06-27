import 'package:expenso_391/data/local/helper/db_helper.dart';

class ExpenseModel {
  int? eid;
  int uid;
  String title;
  String desc;
  String createdAt;
  num amt;
  num bal;
  int type;
  int catId;

  ExpenseModel({
    this.eid,
    required this.uid,
    required this.title,
    required this.desc,
    required this.createdAt,
    required this.amt,
    required this.bal,
    required this.type,
    required this.catId,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map){
    return ExpenseModel(
        eid: map[DBHelper.COLUMN_EXPENSE_ID],
        uid: map[DBHelper.COLUMN_USER_ID],
        title: map[DBHelper.COLUMN_EXPENSE_TITLE],
        desc: map[DBHelper.COLUMN_EXPENSE_DESC],
        createdAt: map[DBHelper.COLUMN_EXPENSE_CREATED_AT],
        amt: map[DBHelper.COLUMN_EXPENSE_AMT],
        bal: map[DBHelper.COLUMN_EXPENSE_BAL],
        type: map[DBHelper.COLUMN_EXPENSE_TYPE],
        catId: map[DBHelper.COLUMN_EXPENSE_CAT_ID]);
  }

  Map<String, dynamic> toMap(){
    return {
      DBHelper.COLUMN_USER_ID : uid,
      DBHelper.COLUMN_EXPENSE_TITLE : title,
      DBHelper.COLUMN_EXPENSE_DESC : desc,
      DBHelper.COLUMN_EXPENSE_CREATED_AT : createdAt,
      DBHelper.COLUMN_EXPENSE_CAT_ID : catId,
      DBHelper.COLUMN_EXPENSE_TYPE : type,
      DBHelper.COLUMN_EXPENSE_AMT : amt,
      DBHelper.COLUMN_EXPENSE_BAL : bal,
    };
  }

}
