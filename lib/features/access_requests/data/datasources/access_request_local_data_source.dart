import 'api/dto/access_request_dto.dart';

abstract class AccessRequestLocalDataSource {
  Future<List<AccessRequestDTO>> getAll();
  Future<AccessRequestDTO> getById(String id);
  Future<void> save(AccessRequestDTO request);
  Future<void> update(AccessRequestDTO request);
  Future<void> delete(String id);
  Future<void> clear();
}

class AccessRequestLocalDataSourceImpl implements AccessRequestLocalDataSource {
  final List<AccessRequestDTO> _storage = [];
  AccessRequestDTO? _lastDeleted;
  int? _lastDeletedIndex;

  @override
  Future<List<AccessRequestDTO>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_storage);
  }

  @override
  Future<AccessRequestDTO> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    
    try {
      return _storage.firstWhere((request) => request.id == id);
    } catch (e) {
      throw Exception('Запрос с ID $id не найден');
    }
  }

  @override
  Future<void> save(AccessRequestDTO request) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final existingIndex = _storage.indexWhere((r) => r.id == request.id);
    if (existingIndex != -1) {
      throw Exception('Запрос с ID ${request.id} уже существует');
    }
    
    _storage.add(request);
  }

  @override
  Future<void> update(AccessRequestDTO request) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final index = _storage.indexWhere((r) => r.id == request.id);
    if (index == -1) {
      throw Exception('Запрос с ID ${request.id} не найден');
    }
    
    _storage[index] = request;
  }

  @override
  Future<void> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final index = _storage.indexWhere((r) => r.id == id);
    if (index == -1) {
      throw Exception('Запрос с ID $id не найден');
    }
    
    _lastDeleted = _storage[index];
    _lastDeletedIndex = index;
    
    _storage.removeAt(index);
  }

  @override
  Future<void> clear() async {
    await Future.delayed(const Duration(milliseconds: 50));
    _storage.clear();
    _lastDeleted = null;
    _lastDeletedIndex = null;
  }

  Future<void> undoDelete() async {
    await Future.delayed(const Duration(milliseconds: 50));
    
    if (_lastDeleted == null || _lastDeletedIndex == null) {
      throw Exception('Нет удаленных элементов для восстановления');
    }
    
    final insertIndex = _lastDeletedIndex!.clamp(0, _storage.length);
    _storage.insert(insertIndex, _lastDeleted!);
    
    _lastDeleted = null;
    _lastDeletedIndex = null;
  }
}

