import 'package:expenso_391/data/local/models/expense_model.dart';

class ExpenseFilteredModel {
  String title;
  num totalAmt;
  List<ExpenseModel> mExpList;

  ExpenseFilteredModel({
    required this.title,
    required this.totalAmt,
    required this.mExpList,
  });
}
