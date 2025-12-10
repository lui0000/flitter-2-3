import 'package:flutter/material.dart';

/// Экран настроек
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Уведомления'),
            subtitle: const Text('Получать уведомления о заявках'),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          SwitchListTile(
            title: const Text('Тёмная тема'),
            subtitle: const Text('Использовать тёмное оформление'),
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('О приложении'),
            subtitle: const Text('Версия 1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Справка'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}


