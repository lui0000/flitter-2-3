import 'package:flutter/material.dart';
import 'package:project1/screens/columnscreen/column_screen.dart';
import 'package:project1/screens/listviewscreen/listview_screen.dart';
import 'package:project1/screens/separatedscreen/separated_screen.dart';


void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final pages = [
    const ColumnScreen(),
    const ListViewScreen(),
    const SeparatedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.vertical_align_top), label: 'Column'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'ListView'),
          BottomNavigationBarItem(icon: Icon(Icons.line_weight), label: 'Separated'),
        ],
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}
