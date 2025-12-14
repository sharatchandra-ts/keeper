import 'package:flutter/material.dart';
import 'package:keeper/pages/main/home/home_page.dart';
import 'package:keeper/pages/main/profile/profile_page.dart';
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
      body: const <Widget>[HomePage(), Scaffold(), ProfilePage()][_currentPage],

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
              enabled: false,
              icon: Icon(Icons.star_outline),
              label: 'PEOPLE',
              selectedIcon: Icon(Icons.star),
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person_2),
              icon: Icon(Icons.person_2_outlined),
              label: 'ME',
            ),
          ],
        ),
      ),
    );
  }
}
