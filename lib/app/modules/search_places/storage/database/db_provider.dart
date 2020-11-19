import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  //это если мы не хотим, чтобы объект создавался случайно с
  // использованием неявного конструктора по умолчанию
  DBProvider._();

  static const String DB_NAME = "places_search.db";
  static const String PLACES_TABLE_NAME = "Places";

  static const String CREATE_PLACES_TABLE = "CREATE TABLE $PLACES_TABLE_NAME ("
      "_id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "nameplace TEXT,"
      "addressplace TEXT,"
      "lat REAL,"
      "lng REAL"
      ")";

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    String path = join(await getDatabasesPath(), DB_NAME);
    return await openDatabase(path, version: 1, onOpen: (db){},
        onCreate: (Database db, int version) async {
          await db.execute(CREATE_PLACES_TABLE);
        }
    );
  }
}