abstract class LocalStorageInterface {
  Future<dynamic> put(String key, dynamic value);

  Future<dynamic> get(String key);

  Future<dynamic> delete(String key);
}
