import 'package:expenso_391/data/local/helper/db_helper.dart';
import 'package:expenso_391/data/local/models/expense_filter_model.dart';
import 'package:intl/intl.dart';

import '../models/expense_model.dart';

class ExpenseRepository {
  DBHelper dbHelper;

  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpense({required ExpenseModel newExpense}) async {
    return await dbHelper.addExpense(newExp: newExpense);
  }

  Future<List<ExpenseFilteredModel>> getAllExpenses() async {
    var allExp = await dbHelper.getAllExpenses();
    return filterExpenses(allExp: allExp);
  }

  List<ExpenseFilteredModel> filterExpenses({
    required List<ExpenseModel> allExp,
  }) {
    List<ExpenseFilteredModel> mFilteredExp = [];

    //date wise
    ///1. get uniquesDates
    List<String> uniqueDates = [];
    //Set<String> uDates = {};
    DateFormat df = DateFormat.yMMMEd();
    for (ExpenseModel eachExp in allExp) {
      String eachDate = df.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)),
      );

      //uDates.add(eachDate);

      if (!uniqueDates.contains(eachDate)) {
        uniqueDates.add(eachDate);
      }
    }

    ///2. filter expenses based on dates
    for (String eachDate in uniqueDates) {
      num eachDateAmt = 0;
      List<ExpenseModel> eachDateExp = [];

      for (ExpenseModel eachExp in allExp) {
        String expDate = df.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)),
        );

        if (expDate == eachDate) {
          eachDateExp.add(eachExp);

          if (eachExp.type == 1) {
            eachDateAmt -= eachExp.amt;
          } else {
            eachDateAmt += eachExp.amt;
          }
        }
      }

      mFilteredExp.add(
        ExpenseFilteredModel(
          title: eachDate,
          totalAmt: eachDateAmt,
          mExpList: eachDateExp,
        ),
      );
    }

    return mFilteredExp;
  }
}
