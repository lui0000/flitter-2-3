import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/access_requests_bloc.dart';
import '../bloc/access_requests_event.dart';
import '../bloc/access_requests_state.dart';
import '../widgets/access_request_item.dart';

/// Экран списка запросов доступа
/// 
/// Использует BlocBuilder для реактивного обновления UI
/// Не содержит бизнес-логики (она в Bloc и Use Cases)
class AccessRequestsPage extends StatelessWidget {
  const AccessRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Запросы доступа'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<AccessRequestsBloc>().add(LoadAccessRequests());
            },
          ),
        ],
      ),
      body: BlocConsumer<AccessRequestsBloc, AccessRequestsState>(
        listener: (context, state) {
          // Обработка побочных эффектов (snackbar, navigation)
          if (state is AccessRequestsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is AccessRequestCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Запрос успешно создан'),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is AccessRequestApproved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Запрос одобрен'),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is AccessRequestDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Запрос удален'),
                backgroundColor: Colors.orange,
                action: state.canUndo
                    ? SnackBarAction(
                        label: 'Отменить',
                        onPressed: () {
                          context
                              .read<AccessRequestsBloc>()
                              .add(UndoDeleteAccessRequest());
                        },
                      )
                    : null,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AccessRequestsInitial) {
            // Загружаем данные при первом открытии
            context.read<AccessRequestsBloc>().add(LoadAccessRequests());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AccessRequestsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AccessRequestsLoaded) {
            if (state.requests.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Нет запросов доступа',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Создайте первый запрос',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: state.requests.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final request = state.requests[index];
                return AccessRequestItem(
                  request: request,
                  onApprove: () {
                    context
                        .read<AccessRequestsBloc>()
                        .add(ApproveAccessRequest(request.id));
                  },
                  onDelete: () {
                    context
                        .read<AccessRequestsBloc>()
                        .add(DeleteAccessRequest(request.id));
                  },
                );
              },
            );
          }

          // Fallback для других состояний
          return const Center(child: Text('Неизвестное состояние'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/access-requests/create');
        },
        icon: const Icon(Icons.add),
        label: const Text('Создать запрос'),
      ),
    );
  }
}


