import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/pages/home_page.dart';
import 'package:nisien_tea_round_picker_app/pages/participants_page.dart';

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
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
            icon: Icon(Icons.library_books_sharp),
            label: 'Team',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_added),
            label: 'something else',
          ),
        ],
      ),
      body:
          <Widget>[
            HomePage(),
            ParticipantsPage(),
            Placeholder(),
          ][currentPageIndex],
    );
  }
}
