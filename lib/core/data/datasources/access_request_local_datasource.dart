import '../models/access_request_model.dart';

/// Локальный источник данных для заявок
abstract class AccessRequestLocalDataSource {
  /// Получить все заявки
  Future<List<AccessRequestModel>> getAllRequests();

  /// Получить заявку по ID
  Future<AccessRequestModel?> getRequestById(String id);

  /// Сохранить заявку
  Future<void> saveRequest(AccessRequestModel request);

  /// Обновить заявку
  Future<void> updateRequest(AccessRequestModel request);

  /// Удалить заявку
  Future<void> deleteRequest(String id);

  /// Очистить все заявки
  Future<void> clearAllRequests();
}

/// Реализация в памяти
class AccessRequestLocalDataSourceImpl implements AccessRequestLocalDataSource {
  final List<AccessRequestModel> _requests = [];
  AccessRequestModel? _lastDeleted;

  @override
  Future<List<AccessRequestModel>> getAllRequests() async {
    return List.from(_requests);
  }

  @override
  Future<AccessRequestModel?> getRequestById(String id) async {
    try {
      return _requests.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveRequest(AccessRequestModel request) async {
    _requests.add(request);
  }

  @override
  Future<void> updateRequest(AccessRequestModel request) async {
    final index = _requests.indexWhere((r) => r.id == request.id);
    if (index != -1) {
      _requests[index] = request;
    }
  }

  @override
  Future<void> deleteRequest(String id) async {
    final index = _requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      _lastDeleted = _requests.removeAt(index);
    }
  }

  @override
  Future<void> clearAllRequests() async {
    _requests.clear();
  }

  /// Получить последнюю удаленную заявку
  AccessRequestModel? getLastDeleted() {
    return _lastDeleted;
  }

  /// Восстановить последнюю удаленную заявку
  Future<void> restoreLastDeleted() async {
    if (_lastDeleted != null) {
      _requests.add(_lastDeleted!);
      _lastDeleted = null;
    }
  }
}

