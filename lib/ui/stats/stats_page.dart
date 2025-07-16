import 'dart:math';

import 'package:expenso_391/data/local/models/expense_filter_model.dart';
import 'package:expenso_391/ui/bloc/expense_bloc.dart';
import 'package:expenso_391/ui/bloc/expense_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expense_event.dart';
import '../sign_up/bloc/user_bloc.dart';
import '../sign_up/bloc/user_state.dart';

class StatsPage extends StatelessWidget {
  /*List<Map<String, dynamic>> mData = [
    {"title": "Jan", "amt": 24520, "exp": []},

    {"title": "Feb", "amt": 34250, "exp": []},

    {"title": "March", "amt": 15000, "exp": []},

    {"title": "Apr", "amt": 70000, "exp": []},

    {"title": "May", "amt": 43870, "exp": []},

    {"title": "Sep", "amt": 49370, "exp": []},
  ];*/

  int filterType = 1;
  String selectedFilterType = "Date wise";
  List<String> mFilterType = ["Date wise", "Month wise", "Year wise", "Category wise"];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                    trailing: StatefulBuilder(
                      builder: (context, ss) {
                        return DropdownButton(
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
                            ss(() {
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
                        );
                      }
                    ),
                  );
                }

                if (state is UserFailureState) {
                  return Center(child: Text("Something went wrong"));
                }
                return Container();
              },
            ),
            BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if(state is ExpenseLoadingState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is ExpenseLoadedState){

                  List<BarChartGroupData> barGroups = [];
                  List<FlSpot> lineBars = [];
                  List<ExpenseFilteredModel> mData = state.expList;

                  for (int i = 0; i < mData.length; i++) {
                    barGroups.add(
                      BarChartGroupData(
                        x: i+1,
                        barRods: [
                          BarChartRodData(
                            toY: mData[i].totalAmt.toDouble().abs(),
                            color: Colors.white,
                            width: 20,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                          ),
                        ],
                      ),
                    );
                    lineBars.add(
                      FlSpot(
                        i+1,
                        mData[i].totalAmt.toDouble().abs(),
                      ),
                    );
                  }

                  return Center(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      height: 250,
                      color: Colors.pink.shade100,
                      child: filterType == 3 ? PieChart(PieChartData(
                        sections: state.expList.map((e){
                          return PieChartSectionData(
                              title: e.title,
                              titleStyle: TextStyle(fontSize: 11),
                              radius: 31,
                              titlePositionPercentageOffset: 1.4,
                              showTitle: true,
                              badgeWidget: Text("${e.title}", style: TextStyle(fontSize: 16),),
                              value: e.totalAmt.toDouble(),
                              color: Colors.primaries[Random().nextInt(Colors.primaries.length)]);
                        }).toList()
                      ))
                          : filterType == 4 ? LineChart(LineChartData(
                        maxY: 25000,
                          minY: 0,
                          lineBarsData: [
                         LineChartBarData(
                           isStrokeCapRound: true,
                           barWidth: 2,
                           belowBarData: BarAreaData(
                             show: true,
                             gradient: LinearGradient(colors: [Colors.white70, Colors.pink.shade500], begin: Alignment.topLeft, end: Alignment.bottomRight),
                           ),
                           gradient: LinearGradient(colors: [Colors.white70, Colors.white54], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                           spots: lineBars,
                           color: Colors.white,
                           isCurved: true,
                         )
                      ])) : BarChart(
                        BarChartData(
                          barGroups: barGroups,
                          gridData: FlGridData(
                            show: false,
                          ),
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipColor: (group){
                                return Colors.white;
                              },
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(mData[groupIndex.toInt()].title, TextStyle(
                                  color: Colors.black,  ));
                              }
                            )
                          ),
                          maxY: 100000,
                          /*titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, __) {
                                  return Text(mData[value.toInt()].title, style: TextStyle(fontSize: 11),);
                                },
                              ),
                            ),
                            show: true,
                          ),*/
                        ),
                      ),
                    ),
                  );
                }
                if(state is ExpenseErrorState){
                  return Center(child: Text(state.errorMsg),);
                }
                return Container();
              }
            ),
          ],
        ),
      ),
    );
  }
}

///Row(
//               children: [
//                 Container(
//                   width: 1,
//                     height: double.infinity,
//                   color: Colors.white,
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//
//                           Container(
//                             width: 40,
//                             height: 75,
//                             color: Colors.white,
//                           ),
//                           Container(
//                             width: 40,
//                             height: 40,
//                             color: Colors.white,
//                           ),
//                           Container(
//                             width: 40,
//                             height: 165,
//                             decoration: BoxDecoration(
//                               color: Colors.pink,
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
//                               border: Border(
//                                 left: BorderSide(
//                                     width: 1,
//                                     color: Colors.white
//                                 ),
//                                 right: BorderSide(
//                                     width: 1,
//                                     color: Colors.white
//                                 ),
//                                 top: BorderSide(
//                                     width: 1,
//                                     color: Colors.white
//                                 ),
//                               )
//                             ),
//                           ),
//                           Container(
//                             width: 40,
//                             height: 15,
//                             color: Colors.white,
//                           )
//                         ],
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 1,
//                         color: Colors.white,
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
