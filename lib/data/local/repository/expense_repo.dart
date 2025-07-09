import 'package:expenso_391/data/local/helper/db_helper.dart';

import '../models/expense_model.dart';

class ExpenseRepository {

  DBHelper dbHelper;
  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpense({required ExpenseModel newExpense}) async {
    return await dbHelper.addExpense(newExp: newExpense);
  }

  Future<List<ExpenseModel>> getAllExpenses() async{
    return await dbHelper.getAllExpenses();
  }

}