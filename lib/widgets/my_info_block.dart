import 'package:flutter/material.dart';

class MyInfoBlock extends StatelessWidget {
  const MyInfoBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'ФИО: Бондаренко Елизавета Алексеевна',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          'Группа: ИКБО-11-22',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          'Студенческий билет: 22И2027',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
