import 'package:flutter/material.dart';
import 'package:namer/pages/favorite_page.dart';
import 'package:namer/pages/generator_page.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<Widget> pages = [GeneratorPage(), FavoritePage()];

Widget selectPageById(int id) {
  return pages[min(pages.length - 1, id.abs())];
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: selectPageById(selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
