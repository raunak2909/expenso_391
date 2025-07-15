import 'package:expenso_391/data/local/helper/db_helper.dart';
import 'package:expenso_391/data/local/models/category_model.dart';
import 'package:expenso_391/data/local/models/expense_filter_model.dart';
import 'package:expenso_391/utils/constants/app_constants.dart';
import 'package:intl/intl.dart';

import '../models/expense_model.dart';

class ExpenseRepository {
  DBHelper dbHelper;

  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpense({required ExpenseModel newExpense}) async {
    return await dbHelper.addExpense(newExp: newExpense);
  }

  Future<List<ExpenseFilteredModel>> getAllExpenses({
    required int filterType,
  }) async {
    var allExp = await dbHelper.getAllExpenses();
    return filterExpenses(allExp: allExp, filterType: filterType);
  }

  List<ExpenseFilteredModel> filterExpenses({
    required List<ExpenseModel> allExp,
    required int filterType,
  }) {
    List<ExpenseFilteredModel> mFilteredExp = [];

    if (filterType <= 3) {
      DateFormat df = DateFormat.yMMMEd();
      if (filterType == 2) {
        df = DateFormat.yMMM();
      } else if (filterType == 3) {
        df = DateFormat.y();
      }

      ///1. get uniquesDates
      List<String> uniqueDates = [];
      //Set<String> uDates = {};
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
    } else {
      ///catWise
      for (CategoryModel eachCat in AppConstants.mCat) {
        num eachCatAmt = 0;
        List<ExpenseModel> eachCatExp = [];

        for (ExpenseModel eachExp in allExp) {
          if (eachCat.id == eachExp.catId) {
            eachCatExp.add(eachExp);

            if (eachExp.type == 1) {
              eachCatAmt -= eachExp.amt;
            } else {
              eachCatAmt += eachExp.amt;
            }
          }
        }
        if(eachCatExp.isNotEmpty){
          mFilteredExp.add(
            ExpenseFilteredModel(
              title: eachCat.name,
              totalAmt: eachCatAmt,
              mExpList: eachCatExp,
            ),
          );
        }
      }
    }

    return mFilteredExp;
  }
}
