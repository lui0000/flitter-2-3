import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../counter/delegate/counter.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Counter();

    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Observer(
          builder: (_) => Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
