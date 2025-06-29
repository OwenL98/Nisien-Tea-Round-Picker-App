import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/pages/home_page.dart';
import 'package:nisien_tea_round_picker_app/pages/participants_page.dart';
import 'package:nisien_tea_round_picker_app/pages/history_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<NavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(icon: Icon(Icons.coffee), label: 'Picker'),
          NavigationDestination(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Team Members',
          ),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      body:
          <Widget>[
            HomePage(),
            ParticipantsPage(),
            HistoryPage(),
          ][currentPageIndex],
    );
  }
}
