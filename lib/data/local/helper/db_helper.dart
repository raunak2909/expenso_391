import 'dart:io';

import 'package:expenso_391/utils/constants/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense_model.dart';
import '../models/user_model.dart';

class DBHelper {
  DBHelper._();

  static DBHelper getInstance() => DBHelper._();

  Database? mDB;

  ///user
  static const String TABLE_USER = "user";
  static const String COLUMN_USER_ID = "u_id";
  static const String COLUMN_USER_NAME = "u_name";
  static const String COLUMN_USER_EMAIL = "u_email";
  static const String COLUMN_USER_MOB_NO = "u_mob_no";
  static const String COLUMN_USER_PASS = "u_pass";

  ///expense
  static const String TABLE_EXPENSE = "expense";
  static const String COLUMN_EXPENSE_ID = "e_id";
  static const String COLUMN_EXPENSE_TITLE = "e_title";
  static const String COLUMN_EXPENSE_DESC = "e_desc";
  static const String COLUMN_EXPENSE_AMT = "e_amt";
  static const String COLUMN_EXPENSE_BAL = "e_bal";
  static const String COLUMN_EXPENSE_CAT_ID = "e_cat_id";
  static const String COLUMN_EXPENSE_TYPE = "e_type";

  /// 1 -> debit , 2 -> credit
  static const String COLUMN_EXPENSE_CREATED_AT = "e_created_at";

  Future<Database> initDB() async {
    /*if(mDB==null){
      mDB = await openDB();
    }*/

    mDB ??= await openDB();

    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "expenseDB.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        ///create tables here
        db.execute(
          "Create table $TABLE_USER ( $COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_NAME text, $COLUMN_USER_EMAIL text, $COLUMN_USER_MOB_NO text, $COLUMN_USER_PASS text )",
        );

        db.execute(
          "Create table $TABLE_EXPENSE ( $COLUMN_EXPENSE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_EXPENSE_TITLE text, $COLUMN_EXPENSE_DESC text, $COLUMN_EXPENSE_AMT real, $COLUMN_EXPENSE_BAL real, $COLUMN_EXPENSE_TYPE integer, $COLUMN_EXPENSE_CAT_ID integer, $COLUMN_EXPENSE_CREATED_AT text)",
        );
      },
    );
  }

  ///queries
  Future<bool> registerUser({required UserModel newUser}) async {
    var db = await initDB();
    int rowsEffected = await db.insert(TABLE_USER, newUser.toMap());
    return rowsEffected > 0;
  }

  Future<bool> ifUserEmailExists({required String email}) async {
    var db = await initDB();
    var data = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ? ",
      whereArgs: [email],
    );
    return data.isNotEmpty;
  }

  Future<bool> ifUserMobileExists({required String mobNo}) async {
    var db = await initDB();
    var data = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_MOB_NO = ?",
      whereArgs: [mobNo],
    );
    return data.isNotEmpty;
  }

  Future<int> authenticateUser({
    required String email,
    required String pass,
  }) async {
    var db = await initDB();

    List<Map<String, dynamic>> mData = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ?",
      whereArgs: [email],
    );

    if (mData.isNotEmpty) {
      List<Map<String, dynamic>> mData = await db.query(
        TABLE_USER,
        where: "$COLUMN_USER_EMAIL = ? AND $COLUMN_USER_PASS = ?",
        whereArgs: [email, pass],
      );

      if (mData.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(AppConstants.PREF_USER_ID_KEY, mData[0][COLUMN_USER_ID]);

        return 1; //success
      } else {
        return 3; // incorrect password
      }
    } else {
      return 2; // email does not exist
    }
  }

  Future<UserModel?> getUserDetails() async {
    var db = await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt(AppConstants.PREF_USER_ID_KEY) ?? 0;

    var mData = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_ID = ?",
      whereArgs: ["$userId"],
    );

    if (mData.isNotEmpty) {
      UserModel currUser = UserModel.fromMap(mData[0]);
      return currUser;
    } else {
      return null;
    }
  }

  Future<bool> addExpense({required ExpenseModel newExp}) async {
    var db = await initDB();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt(AppConstants.PREF_USER_ID_KEY) ?? 0;

    newExp.uid = userId;

    int rowsEffected = await db.insert(TABLE_EXPENSE, newExp.toMap());

    return rowsEffected > 0;
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    var db = await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt(AppConstants.PREF_USER_ID_KEY) ?? 0;

    List<Map<String, dynamic>> mData = await db.query(
      TABLE_EXPENSE,
      where: "$COLUMN_USER_ID = ?",
      whereArgs: ["$userId"],
    );
    List<ExpenseModel> allExp = [];
    for(Map<String, dynamic> eachMap in mData){
      allExp.add(ExpenseModel.fromMap(eachMap));
    }
    return allExp;
  }
}
