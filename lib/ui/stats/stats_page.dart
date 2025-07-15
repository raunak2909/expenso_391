import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  List<Map<String, dynamic>> mData = [
    {"title": "Jan", "amt": 24520, "exp": []},

    {"title": "Feb", "amt": 34250, "exp": []},

    {"title": "March", "amt": 15000, "exp": []},

    {"title": "Apr", "amt": 70000, "exp": []},

    {"title": "May", "amt": 43870, "exp": []},
    {"title": "Sep", "amt": 49370, "exp": []},
  ];

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < mData.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: mData[i]['amt'].toDouble(),
              color: Colors.white,
              width: 20,
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            height: 250,
            color: Colors.pink.shade200,
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                gridData: FlGridData(
                  show: false,
                ),
                maxY: 100000,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, __) {
                        return Text(mData[value.toInt()]["title"]);
                      },
                    ),
                  ),
                  show: true,
                ),
              ),
            ),
          ),
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
