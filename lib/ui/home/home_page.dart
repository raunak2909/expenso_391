import 'dart:math';

import 'package:expenso_391/ui/bloc/expense_bloc.dart';
import 'package:expenso_391/ui/bloc/expense_event.dart';
import 'package:expenso_391/ui/bloc/expense_state.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_event.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_state.dart';
import 'package:expenso_391/utils/app_route/app_routes.dart';
import 'package:expenso_391/utils/constants/app_constants.dart';
import 'package:expenso_391/utils/ui_helper/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/models/expense_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextTheme? txtTheme;
  String selectedMonth = "January";
  int filterType = 1;
  String selectedFilterType = "Date wise";
  List<String> mFilterType = ["Date wise", "Month wise", "Year wise", "Category wise"];

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserDetailEvent());
    context.read<ExpenseBloc>().add(FetchInitialExpenseEvent(filterType: filterType));
  }

  @override
  Widget build(BuildContext context) {

    txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      /* bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar),label: "Calendar"),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings),label: "Settings"),
      ]),*/
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset("assets/icons/mini_logo.png", width: 33),
                    SizedBox(width: 5),
                    Text(
                      "Monety",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Image.asset("assets/icons/ic_search.png", width: 27),
              ],
            ),
            SizedBox(height: 10),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is UserDetailsState) {
                  return ListTile(
                    leading: ClipOval(
                      child: SizedBox(
                        width: 55,
                        height: 55,
                        child: Image.network(
                          "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      "Morning",
                      style: TextStyle(color: Colors.grey),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.currentUser.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          state.currentUser.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    trailing: DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      underline: SizedBox(),
                      dropdownColor: Colors.grey.shade200,
                      elevation: 15,
                      value: selectedFilterType,
                      items: mFilterType.map((filterType) {
                        return DropdownMenuItem(
                          value: filterType,
                          child: Text("$filterType"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFilterType = value!;
                          if(value=="Date wise"){
                            filterType=1;
                          } else if(value=="Month wise"){
                            filterType=2;
                          } else if(value=="Year wise"){
                            filterType=3;
                          } else {
                            filterType=4;
                          }
                          context.read<ExpenseBloc>().add(FetchInitialExpenseEvent(filterType: filterType));
                        });
                      },
                    ),
                  );
                }

                if (state is UserFailureState) {
                  return Center(child: Text("Something went wrong"));
                }
                return Container();
              },
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness==Brightness.dark ?  Color(0xFF6674d3) :  Color(
                    0xff7c8dff),
                borderRadius: BorderRadius.all(Radius.elliptical(19, 13)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Expense total",
                    style: txtTheme!.bodySmall!.copyWith(color: Colors.white),
                  ),
                  Text(
                    "\$8,562",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white)
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "+\$240",
                          style: txtTheme!.bodySmall!.copyWith(color: Colors.white)
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "than last month",
                        style: txtTheme!.bodySmall!.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Expense List",
              style: txtTheme!.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (_, state) {
                if (state is ExpenseLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is ExpenseErrorState) {
                  return Center(child: Text(state.errorMsg));
                }

                if (state is ExpenseLoadedState) {
                  return Expanded(
                    child: state.expList.isNotEmpty
                        ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.expList.length,
                        itemBuilder: (_, index){
                          return Card(
                            child: Container(
                              padding: EdgeInsets.all(21),
                              margin: EdgeInsets.only(bottom: 11),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(state.expList[index].title, style: mTextStyle16(mFontWeight: FontWeight.w600),),
                                      Text('${state.expList[index].totalAmt>=0 ? "+ \$${state.expList[index].totalAmt}" : "- \$${(state.expList[index].totalAmt)*-1}"}', style: txtTheme!.bodySmall!.copyWith(fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                  Divider(color: Colors.grey.shade300, thickness: 2,),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                      itemCount: state.expList[index].mExpList.length,
                                      itemBuilder: (_, childIndex){

                                      ExpenseModel eachExp = state.expList[index].mExpList[childIndex];

                                      String imgPath = AppConstants.mCat.where((cat){
                                        return cat.id == eachExp.catId;
                                      }).toList()[0].imgPath;

                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        padding: EdgeInsets.all(8),
                                        child: Image.asset(imgPath),
                                        decoration: BoxDecoration(
                                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                      title: Text(eachExp.title, style: mTextStyle16(),),
                                      subtitle: Text(eachExp.desc, style: mTextStyle12(),),
                                      trailing: Text('${eachExp.type==1?"- ":"+ "}\$${eachExp.amt}', style: mTextStyle16(textColor: eachExp.type==1 ? Colors.redAccent : Colors.green)),
                                    );
                                  })
                                ],
                              ),
                            ),
                          );
                    })
                        : Center(child: Text('No Expenses yet!!')),
                  );
                }

                return Container();
              },
            ),
            /*Expanded(
              child: ListView.builder(
                itemCount: 3,
                  itemBuilder: (_,index){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 12,horizontal: 4),
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400,width: 1),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom:4),
                        margin: EdgeInsets.only(bottom:6),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1,color: Colors.grey.shade300))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tuesday" ", " "14",style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500
                            ),),
                            Text("-\$1380",style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (_,index){
                              return ListTile(
                                leading:  Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Icon(Icons.shopping_cart_outlined,color: Colors.blue.shade500,),
                                ),
                                title: Text("Shop",style: TextStyle(
                                  fontSize: 19,
                                ),),
                                subtitle: Text("Buy new Cloths",style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15
                                ),),
                                trailing: Text("-\$90",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red.shade300
                                ),),
                              );
                            }),
                      )
                    ],
                  ),
                );
              }),
            )*/
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addExpense, arguments: filterType);
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}
