import 'package:expenso_391/data/local/models/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  ExpenseModel mExp;
  AddExpenseEvent({required this.mExp});
}
class FetchInitialExpenseEvent extends ExpenseEvent {}