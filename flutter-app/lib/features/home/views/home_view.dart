import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeView({super.key, required this.navigationShell});

  void _handleTabTap(int index) {
    // Tapping the active tab again pops it back to its first page
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _handleTabTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Conversation"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Profile"),
        ],
      ),
    );
  }
}
