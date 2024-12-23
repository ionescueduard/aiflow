import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aiflow/screens/chat_screen.dart';
import 'package:aiflow/screens/scripts_screen.dart';
import 'package:aiflow/screens/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      ScriptsScreen(),
      ChatScreen(),
      SettingsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AIFlow'),
        backgroundColor: Color(0xFFCDDDDD)
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all,
            backgroundColor: Color(0xFFACBDBA),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.code),
                selectedIcon: Icon(Icons.code_outlined),
                label: Text('Scripts'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chat),
                selectedIcon: Icon(Icons.chat_bubble_outline),
                label: Text('Chat'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings_outlined),
                label: Text('Settings'),
              ),
            ],
          ),
          Expanded(
            child: _pages[_selectedIndex]
          ),
        ],
      ),
    );
  }
}
