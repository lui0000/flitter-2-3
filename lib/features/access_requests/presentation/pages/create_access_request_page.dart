import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/access_requests_bloc.dart';
import '../bloc/access_requests_event.dart';
import '../bloc/access_requests_state.dart';

/// Экран создания нового запроса доступа
class CreateAccessRequestPage extends StatefulWidget {
  const CreateAccessRequestPage({super.key});

  @override
  State<CreateAccessRequestPage> createState() => _CreateAccessRequestPageState();
}

class _CreateAccessRequestPageState extends State<CreateAccessRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _employeeController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String? _selectedAccessType;
  
  final List<String> _accessTypes = [
    'Доступ к файловому серверу',
    'Доступ к базе данных',
    'Административные права',
    'VPN доступ',
    'Доступ к системе мониторинга',
    'Доступ к почтовому серверу',
  ];

  @override
  void dispose() {
    _employeeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AccessRequestsBloc>().add(
            CreateAccessRequest(
              employee: _employeeController.text.trim(),
              accessType: _selectedAccessType!,
              description: _descriptionController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать запрос'),
      ),
      body: BlocListener<AccessRequestsBloc, AccessRequestsState>(
        listener: (context, state) {
          if (state is AccessRequestCreated) {
            // Возвращаемся назад при успешном создании
            Navigator.pop(context);
          }
          
          if (state is AccessRequestsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Информационная карточка
                Card(
                  color: Colors.blue.shade50,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Заполните форму для создания нового запроса на доступ',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),

                // Поле "Сотрудник"
                TextFormField(
                  controller: _employeeController,
                  decoration: const InputDecoration(
                    labelText: 'Сотрудник',
                    hintText: 'Введите ФИО сотрудника',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Пожалуйста, введите имя сотрудника';
                    }
                    if (value.trim().length < 3) {
                      return 'Имя должно содержать минимум 3 символа';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Выпадающий список типов доступа
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Тип доступа',
                    prefixIcon: Icon(Icons.vpn_key),
                    border: OutlineInputBorder(),
                  ),
                  items: _accessTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAccessType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, выберите тип доступа';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Поле "Описание"
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Описание (необязательно)',
                    hintText: 'Дополнительная информация о запросе',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),

                const SizedBox(height: 24),

                // Кнопка создания
                BlocBuilder<AccessRequestsBloc, AccessRequestsState>(
                  builder: (context, state) {
                    final isLoading = state is AccessRequestsLoading;
                    
                    return ElevatedButton.icon(
                      onPressed: isLoading ? null : _submitForm,
                      icon: isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.check),
                      label: Text(isLoading ? 'Создание...' : 'Создать запрос'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Кнопка отмены
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Отмена'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

