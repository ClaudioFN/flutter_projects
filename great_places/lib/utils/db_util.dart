import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {

  // Ter certeza que a tabela e banco existem
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)'
        );
      },
      version: 1,
    );
  }

  // Inserir conteudo na tabela apontada
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Buscar conteudo na tabela indicada
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();

    return db.query(table);
  }

}