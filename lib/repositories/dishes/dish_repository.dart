import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:path/path.dart' as path;

class DishRepository {
  final CollectionReference _collection;
  final StorageReference _storage;
  static String _path = 'dishes';
  static String _storagePath = 'admin/dishes/';

  DishRepository()
      : _collection = Firestore.instance.collection(_path),
        _storage = FirebaseStorage.instance.ref();

  Future<dynamic> uploadImage(String url) async {
    final uploadTask =
        _storage.child(_storagePath + path.basename(url)).putFile(File(url));
    return (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<void> addDish(Dish dish) async {
    return _collection.add(dish.toJson());
  }

  Future<Dishes> loadDishes() async {
    final collection = await _collection.getDocuments();
    return Future.value(Dishes.fromDocuments(collection.documents));
  }

  Future<void> deleteDish(Dish dish) async {
    final document = _collection.document(dish.id);
    var fileUrl = Uri.decodeFull(path.basename(dish.image))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    await _storage.child(_storagePath + path.basename(fileUrl)).delete();
    await Firestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(document);
    });
  }
}
