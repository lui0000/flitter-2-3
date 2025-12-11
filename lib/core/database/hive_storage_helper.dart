import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageHelper {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    _initialized = true;
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  Future<void> delete(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  Future<void> clear(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  Future<Map<String, dynamic>> getAll(String boxName) async {
    final box = await openBox<dynamic>(boxName);
    return Map<String, dynamic>.from(box.toMap());
  }

  Future<List<String>> getKeys(String boxName) async {
    final box = await openBox(boxName);
    return box.keys.cast<String>().toList();
  }

  Future<bool> containsKey(String boxName, String key) async {
    final box = await openBox(boxName);
    return box.containsKey(key);
  }

  Future<void> putAll(String boxName, Map<String, dynamic> entries) async {
    final box = await openBox<dynamic>(boxName);
    await box.putAll(entries);
  }

  Future<void> deleteAll(String boxName, List<String> keys) async {
    final box = await openBox(boxName);
    await box.deleteAll(keys);
  }

  Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }

  Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }
}

