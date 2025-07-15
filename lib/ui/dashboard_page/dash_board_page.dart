import 'package:expenso_391/ui/add_expense/add_expense_page.dart';
import 'package:expenso_391/ui/dashboard_page/provider/navigation_provider.dart';
import 'package:expenso_391/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stats/stats_page.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  List<Widget> mNavPages = [HomePage(), AddExpensePage(), StatsPage()];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
        builder: (_, provider, __) {
          return Scaffold(
              body: mNavPages[provider.getCurrPageIndex()],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 11,
              iconSize: 25,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              currentIndex: provider.getCurrPageIndex(),
              selectedItemColor: Colors.pink.shade200,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
               provider.updatePageIndex(index: index);
              },
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home),
                  label: "",
                  icon: Icon(Icons.home_outlined),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart_outlined),
                  label: "",
                  activeIcon: Icon(Icons.area_chart),
                ),
              ],
            ),
          );
        }
    );
  }
}
