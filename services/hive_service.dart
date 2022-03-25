import 'package:hive/hive.dart';

import '../interfaces/local_storage_interface.dart';

class HiveService implements LocalStorageInterface {
  final String _tableName;
  Box? _database;

  HiveService(String tableName) : _tableName = tableName {
    Hive.init('/database');
  }

  Future<void> init() async {
    _database ??= await Hive.openBox(_tableName);
  }

  @override
  Future<dynamic> get(key) async {
    await init();
    return _database!.get(key);
  }

  @override
  Future<void> put(key, value) async {
    await init();
    return await _database!.put(key, value);
  }

  @override
  Future<void> delete(key) async {}
}
