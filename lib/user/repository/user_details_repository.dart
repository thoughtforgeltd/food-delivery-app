import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';
import 'package:path/path.dart' as path;

class UserDetailsRepository {
  final CollectionReference _collection;
  final UserRepository _userRepository;
  static String _path = 'users';
  static String _storagePath = 'users/profile/';
  final StorageReference _storage;

  UserDetailsRepository({@required UserRepository userRepository})
      : _collection = Firestore.instance.collection(_path),
        _storage = FirebaseStorage.instance.ref(),
        _userRepository = userRepository;

  Future<void> updateUserDetails(UserDetails userDetails) async {
    final user = await _userRepository.getUserID();
    userDetails.email = user.email;
    return _collection
        .document(user.uid)
        .setData(userDetails.toJson(), merge: true);
  }

  Future<UserDetails> loadUserDetails() async {
    final user = await _userRepository.getUserID();
    final document = await _collection.document(user.uid).get();
    final details = UserDetails.fromJson(document.data);
    details.email = user.email;
    return Future.value(details);
  }

  Future<dynamic> uploadImage(String url) async {
    final uploadTask =
        _storage.child(_storagePath + path.basename(url)).putFile(File(url));
    return (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<DocumentSnapshot> isUserDetailsEntered(String userID) {
    return _collection.document(userID).get();
  }
}
