// ignore_for_file: library_private_types_in_public_api

import 'package:calculator/calculator_screen.dart';
import 'package:calculator/currency_converter.dart';
import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(height: 35),
//           TabBar(
//             indicatorColor: Colors.indigo,
//             indicatorSize: TabBarIndicatorSize.label,
//             indicatorWeight: 2.0,
//             labelColor: Colors.indigo,
//             unselectedLabelColor: Colors.white,
//             // dividerColor: Colors.black,
//             controller: _tabController,
//             tabs: [
//               Tab(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       "assets/equal.png",
//                       width: 30,
//                       height: 30,
//                       color: Colors.indigo,
//                     ),
//                     const SizedBox(width: 10),
//                     const Text(
//                       "Calculator",
//                       style: TextStyle(fontSize: 18, color: Colors.indigo),
//                     )
//                   ],
//                 ),
//               ),
//               Tab(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       "assets/currency.png",
//                       width: 30,
//                       height: 30,
//                       color: Colors.indigo,
//                     ),
//                     const SizedBox(width: 10),
//                     const Text(
//                       "Currency",
//                       style: TextStyle(fontSize: 18, color: Colors.indigo),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: const [
//                 CalculatorScreen(),
//                 CurrencyConverter(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color activeTabColor = Colors.indigo; 
  Color inactiveTabColor = Colors.indigo; 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      
      setState(() {
        activeTabColor = Colors.indigo; 
        inactiveTabColor = Colors.indigo; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 35),
          TabBar(
            indicatorColor: activeTabColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            labelColor: activeTabColor,
            unselectedLabelColor: inactiveTabColor,
            controller: _tabController,
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/equal.png",
                      width: 30,
                      height: 30,
                      color: _tabController.index == 0
                          ? activeTabColor
                          : inactiveTabColor,
                    ),
                    const SizedBox(width: 10),
                    if (_tabController.index == 0)
                       Text(
                        "Calculator",
                        style: TextStyle(fontSize: 18, color: activeTabColor),
                      ),
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/currency.png",
                      width: 30,
                      height: 30,
                      color: _tabController.index == 1
                          ? activeTabColor
                          : inactiveTabColor,
                    ),
                    const SizedBox(width: 10),
                    if (_tabController.index == 1)
                       Text(
                        "Currency",
                        style: TextStyle(fontSize: 18, color: activeTabColor),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _tabController.index,
              children: [
                CalculatorScreen(),
                CurrencyConverter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
