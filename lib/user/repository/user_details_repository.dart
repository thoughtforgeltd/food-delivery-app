import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

class UserDetailsRepository {
  final CollectionReference _collection;
  final UserRepository _userRepository;
  static String _path = 'users';

  UserDetailsRepository({@required UserRepository userRepository})
      : _collection = Firestore.instance.collection(_path),
        _userRepository = userRepository;

  Future<void> updateUserDetails(UserDetails userDetails) async {
    final user = await _userRepository.getUserID();
    userDetails.email = user.email;
    return _collection
        .document(user.uid)
        .setData(userDetails.toJson(), merge: true);
  }

  Future<DocumentSnapshot> isUserDetailsEntered(String userID) {
    return _collection.document(userID).get();
  }
}
