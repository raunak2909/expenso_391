import 'package:expenso_391/data/local/models/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  ExpenseModel mExp;
  int filterType;
  AddExpenseEvent({required this.mExp, required this.filterType});
}
class FetchInitialExpenseEvent extends ExpenseEvent {
  int filterType; ///1->dateWise 2->monthWise 3->yearWise 4->categoryWise
  FetchInitialExpenseEvent({this.filterType=1});


}

