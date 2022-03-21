
import 'dart:async';

import 'package:app_thuchi/models/products.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';


import '../databases/local_database.dart';

class ProductStore {
  static const String _STORE_NAME = "product";

  final _store = intMapStoreFactory.store(_STORE_NAME);
  Future<Database> get _db async => await LocalDatabase.instance.database;

  save(Product entity) async {
    debugPrint("SAVING $entity");
    await _store.add(await _db, entity.toJson());
    debugPrint("Ok $entity");
  }

  update(Product entity) async {
    debugPrint("UPDATING $entity");
    final finder = Finder(filter: Filter.byKey(entity.key));
    await _store.update(await _db, entity.toJson(), finder: finder);
    debugPrint("Ok $entity");
  }

  delete(Product entity) async {
    debugPrint("DELETING $entity");
    final finder = Finder(filter: Filter.byKey(entity.key));
    await _store.delete(await _db, finder: finder);
    debugPrint("Ok $entity");
  }

  Future<Stream<List<Product>>> stream() async {
    debugPrint("Geting Data Stream");
    var streamTransformer = StreamTransformer<
        List<RecordSnapshot<int, Map<String, dynamic>>>,
        List<Product>>.fromHandlers(
      handleData: _streamTransformerHandlerData,
    );

    return _store
        .query()
        .onSnapshots(await _db)
        .transform(streamTransformer);
  }

  Future fetch() async {
    debugPrint("fetch all");

    final snapshot = await _store.find(await _db);
    debugPrint("Ok $snapshot");
    return snapshot;
  }

  Future<List<Product>> findAll() async {
    final snapshot = await _store.find(await _db);
    print("kkkkkkk"+snapshot.toString());
    return snapshot.map((e) => Product.fromDatabase(e)).toList();
  }

  _streamTransformerHandlerData(
      List<RecordSnapshot<int, Map<String, dynamic>>> snapshotList,
      EventSink<List<Product>> sink) {
    List<Product> resultSet = [];
    snapshotList.forEach((element) {
      resultSet.add(Product.fromDatabase(element));
    });
    sink.add(resultSet);
  }
}
