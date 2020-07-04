import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsRepository {
  final CollectionReference _collection;
  static String _path = 'users';

  UserDetailsRepository() : _collection = Firestore.instance.collection(_path);

  Future<void> updateUserDetails(
      String userId, String firstName, String lastName, String address, String phone) {
    return _collection.document(userId).setData({
      "firstName": firstName,
      "lastName": lastName,
      "address": address,
      "phone": phone
    }, merge: true);
  }

  Future<DocumentSnapshot> isUserDetailsEntered(String userID) {
    return _collection.document(userID).get();
  }
}
