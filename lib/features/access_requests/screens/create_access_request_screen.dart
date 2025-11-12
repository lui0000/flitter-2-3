import 'package:flutter/material.dart';
import '../stores/access_requests_store.dart';
import '../models/access_request.dart';

class CreateAccessRequestScreen extends StatefulWidget {
  final AccessRequestsStore store;

  const CreateAccessRequestScreen({super.key, required this.store});

  @override
  State<CreateAccessRequestScreen> createState() => _CreateAccessRequestScreenState();
}

class _CreateAccessRequestScreenState extends State<CreateAccessRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _employeeCtrl = TextEditingController();
  final _accessTypeCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  @override
  void dispose() {
    _employeeCtrl.dispose();
    _accessTypeCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final item = AccessRequest(
      id: now.microsecondsSinceEpoch.toString(),
      employee: _employeeCtrl.text.trim(),
      accessType: _accessTypeCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      createdAt: now,
      isApproved: false,
    );
    widget.store.add(item);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новая заявка')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _employeeCtrl,
                decoration: const InputDecoration(labelText: 'Сотрудник'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Укажите сотрудника' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _accessTypeCtrl,
                decoration: const InputDecoration(labelText: 'Тип доступа'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Укажите тип доступа' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionCtrl,
                decoration: const InputDecoration(labelText: 'Описание'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              FilledButton(onPressed: _submit, child: const Text('Сохранить')),
            ],
          ),
        ),
      ),
    );
  }
}
