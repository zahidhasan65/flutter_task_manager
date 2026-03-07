import 'package:flutter/material.dart';
import 'package:task_manager/screen/new_task_screen.dart';
import 'package:task_manager/screen/progress_screen.dart';

import '../widgets/app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  int _selectedIndex = 0;
  final List<Widget> _screen = [
    NewTaskScreen(),
    ProgressScreen(),
    ProgressScreen(),
    ProgressScreen(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,

        onDestinationSelected: (int index){
          _selectedIndex=index;
          setState(() {

          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.cancel_sharp), label: 'Cancelled'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
        ],
      ),
body: _screen[_selectedIndex],
    );
  }
}

