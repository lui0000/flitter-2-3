import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: DeletableList()));
}

class DeletableList extends StatefulWidget {
  const DeletableList({super.key});

  @override
  State<DeletableList> createState() => _DeletableListState();
}

class _DeletableListState extends State<DeletableList> {
  List<String> items = List.generate(10, (index) => 'Элемент ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список с удалением')),
      body: ListView(
        children: items.map((item) {
          return Container(
            key: ValueKey(item),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item,
                  style: const TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      items.remove(item);
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
