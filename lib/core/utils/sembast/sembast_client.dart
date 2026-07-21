import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class SembastClient {
  Database? _database;

  Future<Database> get database async {
    return _database ??= await _openDatabase();
  }

  Future<Database> _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'pokemon_day_care.db');
    return databaseFactoryIo.openDatabase(dbPath);
  }

  StoreRef<String, Map<String, Object?>> _store(String storeName) {
    return stringMapStoreFactory.store(storeName);
  }

  Future<void> put(
    String storeName,
    String key,
    Map<String, Object?> value,
  ) async {
    final db = await database;
    await _store(storeName).record(key).put(db, value);
  }

  Future<Map<String, Object?>?> get(String storeName, String key) async {
    final db = await database;
    return _store(storeName).record(key).get(db);
  }

  Future<void> delete(String storeName, String key) async {
    final db = await database;
    await _store(storeName).record(key).delete(db);
  }

  Future<List<Map<String, Object?>>> getAll(String storeName) async {
    final db = await database;
    final records = await _store(storeName).find(db);
    return records.map((record) => record.value).toList();
  }

  Future<void> clear(String storeName) async {
    final db = await database;
    await _store(storeName).delete(db);
  }
}
