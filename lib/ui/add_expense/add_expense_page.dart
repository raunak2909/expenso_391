import 'package:expenso_391/data/local/models/expense_model.dart';
import 'package:expenso_391/ui/bloc/expense_bloc.dart';
import 'package:expenso_391/ui/bloc/expense_event.dart';
import 'package:expenso_391/ui/bloc/expense_state.dart';
import 'package:expenso_391/ui/dashboard_page/provider/navigation_provider.dart';
import 'package:expenso_391/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatelessWidget {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var amountController = TextEditingController();
  int filterType = 1;

  List<String> mType = ["Debit", "Credit"];
  String selectedType = "Debit";
  DateTime? selectedDate;
  DateFormat df = DateFormat.yMMMEd();
  int selectedCatIndex = -1;
  bool isAdding = false;

  @override
  Widget build(BuildContext context) {

    filterType = (ModalRoute.of(context)!.settings.arguments ?? 1) as int ;


    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: StatefulBuilder(
          builder: (context, ss) {
            return Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    prefixIcon: Icon(Icons.title),
                    hintText: "Enter Title here..",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
                SizedBox(height: 11),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: "Desc",
                    prefixIcon: Icon(Icons.description),
                    hintText: "Enter Desc here..",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
                SizedBox(height: 11),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    prefixIcon: Icon(Icons.money),
                    hintText: "Enter Title here..",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
                SizedBox(height: 11),
                DropdownMenu(
                  leadingIcon: Icon(Icons.category),
                  label: Text("Expense Type"),
                  width: double.infinity,
                  onSelected: (value) {
                    selectedType = value!;
                  },
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                  initialSelection: selectedType,
                  dropdownMenuEntries: mType.map((e) {
                    return DropdownMenuEntry(value: e, label: e);
                  }).toList(),
                ),
                /*StatefulBuilder(
                  builder: (context, ss) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: mType.map((e){
                        return RadioMenuButton(
                          value: e,
                          groupValue: selectedType,
                          onChanged: (value) {
                            selectedType = value!;
                            ss((){});
                          },
                          child: Text(e),
                        );
                      }).toList(),
                    );
                  }
                ),*/
                /* StatefulBuilder(builder: (_, ss){
                  return DropdownButton(
                    value: selectedType,
                      items: mType.map((e){
                    return DropdownMenuItem(child: Text(e), value: e,);
                  }).toList(), onChanged: (value){
                    selectedType = value!;
                    ss((){});
                  });
                })*/
                SizedBox(height: 11),
                OutlinedButton(
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 730)),
                      lastDate: DateTime.now(),
                    );
                    ss(() {});
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                    minimumSize: Size(double.infinity, 57),
                    maximumSize: Size(double.infinity, 57),
                  ),
                  child: Text(df.format(selectedDate ?? DateTime.now())),
                ),
                SizedBox(height: 11),
                OutlinedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Padding(
                          padding: EdgeInsets.all(11),
                          child: GridView.builder(
                            itemCount: AppConstants.mCat.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                ),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  selectedCatIndex = index;
                                  Navigator.pop(context);
                                  ss(() {});
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      AppConstants.mCat[index].imgPath,
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(height: 5),
                                    Text(AppConstants.mCat[index].name),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                    minimumSize: Size(double.infinity, 57),
                    maximumSize: Size(double.infinity, 57),
                  ),
                  child: selectedCatIndex >= 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppConstants.mCat[selectedCatIndex].imgPath,
                              width: 40,
                            ),
                            Text(
                              " - ${AppConstants.mCat[selectedCatIndex].name}",
                            ),
                          ],
                        )
                      : Text('Select Category'),
                ),
                SizedBox(height: 11),
                BlocConsumer<ExpenseBloc, ExpenseState>(
                  listener: (context, state) {
                    if (state is ExpenseLoadingState) {
                      isAdding = true;
                    }

                    if (state is ExpenseLoadedState) {
                      isAdding = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Expense Added Successfully')),
                      );
                      context.read<NavigationProvider>().updatePageIndex(index: 0);
                    }

                    if (state is ExpenseErrorState) {
                      isAdding = false;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 52),
                        maximumSize: Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      onPressed: () {
                        ///add expense
                        ExpenseModel newExp = ExpenseModel(
                          uid: 0,
                          title: titleController.text,
                          desc: descController.text,
                          createdAt: (selectedDate ?? DateTime.now())
                              .millisecondsSinceEpoch
                              .toString(),
                          amt: double.parse(amountController.text),
                          bal: 0,
                          type: selectedType == "Debit" ? 1 : 2,
                          catId: AppConstants.mCat[selectedCatIndex].id,
                        );

                        context.read<ExpenseBloc>().add(
                          AddExpenseEvent(mExp: newExp, filterType: filterType),
                        );
                      },
                      child: isAdding ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 11,),
                          Text('Adding...'),
                        ],
                      ) : Text('Add Expense'),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
