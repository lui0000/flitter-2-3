import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Content Switch Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  String _userName = 'Елизавета Бондаренко';
  int _step = 1;
  int _counter = 0;
  final List<String> _tasks = [
    'Сверстать виджеты',
    'Добавить StatefulWidget',
    'Сделать навигацию',
    'Связать экраны состоянием',
    'Подготовить отчёт',
  ];

  void incrementCounter() {
    setState(() {
      _counter += _step;
    });
  }

  void updateStep(int newStep) {
    setState(() {
      _step = newStep.clamp(1, 10);
    });
  }

  void addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void removeTaskAt(int i) {
    setState(() {
      if (i >= 0 && i < _tasks.length) _tasks.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ProfileScreen(userName: _userName, counter: _counter),
      TasksScreen(tasks: _tasks, onAdd: addTask, onRemoveAt: removeTaskAt),
      StatsScreen(counter: _counter, step: _step, onIncrement: incrementCounter),
      SettingsScreen(step: _step, onStepChanged: updateStep),
      HelpScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ['Профиль', 'Задачи', 'Статистика', 'Настройки', 'Справка'][_index],
        ),
      ),
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
          NavigationDestination(icon: Icon(Icons.checklist), label: 'Задачи'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Статистика'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Настройки'),
          NavigationDestination(icon: Icon(Icons.help_outline), label: 'Справка'),
        ],
      ),
    );
  }
}
