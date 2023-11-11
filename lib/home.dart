import 'package:assignment/constant/color.dart';
import 'package:assignment/tabs/first.dart';
import 'package:assignment/tabs/second.dart';
import 'package:flutter/material.dart';

import 'tabs/fifth.dart';
import 'tabs/fourth.dart';
import 'tabs/third.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> icons = [
    Icon(Icons.home, color: black),
    Icon(Icons.table_chart_rounded, color: black),
    Icon(Icons.calendar_month, color: black),
    Icon(Icons.chat, color: black),
    Icon(Icons.contacts_rounded, color: black),
  ];

  List<Widget> tabs = [
    First(),
    const Second(),
    const Third(),
    const Fourth(),
    const Fifth(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: red,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: icons[0], label: 'Home'),
          BottomNavigationBarItem(icon: icons[1], label: 'Home'),
          BottomNavigationBarItem(icon: icons[2], label: 'Home'),
          BottomNavigationBarItem(icon: icons[3], label: 'Home'),
          BottomNavigationBarItem(icon: icons[4], label: 'Home'),
        ],
      ),
    );
  }
}
