import 'package:flutter/material.dart';
import 'package:keeper/pages/home_page.dart';
import 'package:keeper/themes/app_tokens.dart';
import 'package:keeper/widgets/popup_menu.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('keeper'), actions: [MyPopupMenu()]),
      body: const <Widget>[HomePage(), Scaffold(), Scaffold()][_currentPage],
      bottomNavigationBar: Material(
        shape: Border(top: AppBorders.thick),
        clipBehavior: .antiAliasWithSaveLayer,
        child: NavigationBar(
          labelBehavior: .onlyShowSelected,
          selectedIndex: _currentPage,
          onDestinationSelected: (int index) =>
              setState(() => _currentPage = index),
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'HOME',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              label: 'PEOPLE',
              selectedIcon: Icon(Icons.people),
            ),
            NavigationDestination(
              enabled: false,
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Saved',
            ),
          ],
        ),
      ),
    );
  }
}
