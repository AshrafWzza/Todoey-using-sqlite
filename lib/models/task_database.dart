//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todoey_sqlite/models/task.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();
  static Database? _database;
  TasksDatabase._init();
  Future<Database> get database async =>
      _database ??= await _initDB('tasks.db');
/*
 ** Instead of:
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, filePath);

  ** You can put:
  Future<Database> _initDB(String filePath) async {
    return await openDatabase(filePath, version: 1);
  }

  ** because openDatabase first parameter now gets the default database path automatically, just pass the database name "tasks.db"
 */

  Future<Database> _initDB(String filePath) async {
    // final dbPath = await getDatabasesPath();
    // final path = join(dbPath, filePath);
    return await openDatabase(filePath /**path*/,
        version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT';
    const boolType = 'BOOLEAN';

    /// sensitive indentation
    ///Be Careful with FORMATTING You need to remove space from table name and "(" and you have to remove the ending ",".
    await db.execute('''
    CREATE TABLE $tableTasks( 
    ${TaskFields.id} $idType, 
    ${TaskFields.name} $textType,
    ${TaskFields.isDone} $boolType)''');
  }

  Future<void> create(Task task) async {
    final db = await instance.database;
    // final id = await db.insert(
    //   tableTasks,
    //   task.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
    // return task.copyWith(id: id);
    await db.insert(
      tableTasks,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Task> readTask(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTasks,
      columns: TaskFields.values,

      ///where: '${TaskFields.id} = $id', use ? and whereArgs to prevent sqlInjection
      /// you can add more than one args -->  where: '${TaskFields.id} = ? ? ? ? ?',
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;

    const orderBy = '${TaskFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableTasks ORDER BY $orderBy');

    final result = await db.query(tableTasks, orderBy: orderBy);

    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<void> update(Task task) async {
    final db = await instance.database;

    db.update(
      tableTasks,
      task.toMap(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await instance.database;

    await db.delete(
      tableTasks,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
