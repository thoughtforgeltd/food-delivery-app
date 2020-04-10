import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsRepository {
  final CollectionReference _collection;
  static String _path  = 'users';

  UserDetailsRepository({Firestore fireStore})
      : _collection = Firestore.instance.collection(_path);

  Future<void> updateUserDetails(
      String firstName, String lastName, String address, String phone) {
    return _collection.add({
      "firstName": firstName,
      "lastName": lastName,
      "address": address,
      "phone": phone
    });
  }
}
