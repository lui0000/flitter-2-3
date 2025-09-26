import 'package:flutter/material.dart';

class CounterPanel extends StatefulWidget {
  const CounterPanel({super.key, this.start, this.step});

  final int? start;
  final int? step;

  @override
  State<CounterPanel> createState() => _CounterPanelState();
}

class _CounterPanelState extends State<CounterPanel> {
  late int _value;
  late int _step;
  bool _highlight = false;

  @override
  void initState() {
    super.initState();
    _value = widget.start ?? 0;
    _step  = widget.step  ?? 1;
  }

  @override
  void didUpdateWidget(covariant CounterPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step != widget.step && widget.step != null) {
      _step = widget.step!;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _inc() {
    setState(() {
      _value += _step;
      _highlight = !_highlight;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color btnColor = _highlight
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Счётчик: $_value',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _inc,
          style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
            foregroundColor: Colors.white,
          ),
          child: Text('Добавить $_step'),
        ),
      ],
    );
  }
}
