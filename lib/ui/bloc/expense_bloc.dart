import 'package:expenso_391/data/local/models/expense_filter_model.dart';
import 'package:expenso_391/data/local/models/expense_model.dart';
import 'package:expenso_391/data/local/repository/expense_repo.dart';
import 'package:expenso_391/ui/bloc/expense_event.dart';
import 'package:expenso_391/ui/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  ExpenseRepository expRepo;
  ExpenseBloc({required this.expRepo}) : super(ExpenseInitialState()){

    on<AddExpenseEvent>((event, emit) async{

      emit(ExpenseLoadingState());

      bool check =await expRepo.addExpense(newExpense: event.mExp);

      if(check){
        List<ExpenseFilteredModel> mExpList = await expRepo.getAllExpenses();
        emit(ExpenseLoadedState(expList: mExpList));
      } else {
        emit(ExpenseErrorState(errorMsg: "Something went wrong"));
      }

    });

    on<FetchInitialExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      List<ExpenseFilteredModel> mExpList = await expRepo.getAllExpenses();
      emit(ExpenseLoadedState(expList: mExpList));
    });

  }

}