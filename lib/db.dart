import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE user_data(
          id INTEGER PRIMARY KEY,
          Gauge TEXT,
          Distance TEXT,
          Elevation TEXT
        )
      ''');
      },
    );
  }

  Future<void> insertUserData(
      {required int gauge,
      required int distance,
      required int elevation}) async {
    final Database db = await database;
    await db.insert(
      'user_data',
      {'gauge': gauge, 'distance': distance, 'elevation': elevation},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllUserData() async {
    final Database db = await database;
    return await db.query('user_data');
  }

  Future<Map<String, dynamic>?> fetchLastRow() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'user_data',
      orderBy: 'id DESC',
      limit: 1,
    );

    return result.isNotEmpty ? result.first : null;
  }
}

class DatabaseTable extends StatefulWidget {
  @override
  _DatabaseTableState createState() => _DatabaseTableState();
}

class _DatabaseTableState extends State<DatabaseTable> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    initDatabase().then((db) {
      db.rawQuery('SELECT * FROM user_data').then((result) {
        setState(() {
          tableData = result;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Table'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columns: getColumns(),
            rows: tableData != null ? getRows() : [],
            dataRowHeight: 40.0, // Adjust the height between rows
          ),
        ),
      ),
    );
  }

  List<DataColumn> getColumns() {
    return [
      DataColumn(
        label: Text('Gauge'),
      ),
      DataColumn(
        label: Text('Distance'),
      ),
      DataColumn(
        label: Text('Elevation'),
      ),
    ];
  }

  List<DataRow> getRows() {
    return tableData.map((row) {
      return DataRow(
        cells: getCells(row),
      );
    }).toList();
  }

  List<DataCell> getCells(Map<String, dynamic> row) {
    return [
      DataCell(
        Text('${row['Gauge']}'),
      ),
      DataCell(
        Text('${row['Distance']}'),
      ),
      DataCell(
        Text('${row['Elevation']}'),
      ),
    ];
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE user_data(
            id INTEGER PRIMARY KEY,
            Gauge TEXT,
            Distance TEXT,
            Elevation TEXT
          )
        ''');
      },
    );
  }
}
