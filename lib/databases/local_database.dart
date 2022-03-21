import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';


export 'package:sembast/sembast.dart';

class LocalDatabase1 {
  static const String _DATABASE_NAME = "product.db";
  static final LocalDatabase _singleton = LocalDatabase._();

  static LocalDatabase get instance => _singleton;
 late Completer<Database> _dbOpenCompleter;
   LocalDatabase1._();
  Future<Database> get database async {
      _dbOpenCompleter = Completer();
      _openDatabase();
    return _dbOpenCompleter.future;
  }
  // var db = await factory.openDatabase('test.db');

  Future _openDatabase() async {
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, _DATABASE_NAME);

    final database = await databaseFactoryIo.openDatabase(dbPath);
    print('database$database');
    _dbOpenCompleter.complete(database);

  }

}




class LocalDatabase {
  static const String _DATABASE_NAME = "tasks111.db";
  static final LocalDatabase _singleton = LocalDatabase._();

  static LocalDatabase get instance => _singleton;
  late Completer<Database> _dbOpenCompleter;
  LocalDatabase._();

  Future<Database> get database async {

      _dbOpenCompleter = Completer();
      _openDatabase();
      return _dbOpenCompleter.future;

  }



  Future _openDatabase() async {
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, _DATABASE_NAME);

    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter.complete(database);

  }
}

