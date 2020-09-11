import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';
import 'package:flutter_firebase_auth_mvvm/services/db_base.dart';

class FirestoreDatabaseService implements DatabaseBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(UserModel user) async {
    print("UserModel user at FirestoreDatabaseService $user");

    DocumentSnapshot _getUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.userID)
        .get();

    print("saveUser at FirestoreDatabaseService _getUser ${_getUser.data()}");

    if (_getUser.data() == null) {
      await _firebaseFirestore
          .collection("users")
          .doc(user.userID)
          .set(user.toMap());
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserModel> getUser(String userID) async {
    DocumentSnapshot _getUser =
        await _firebaseFirestore.collection("users").doc(userID).get();
    Map<String, dynamic> _getUserMap = _getUser.data();

    UserModel _userModel = UserModel.fromMap(_getUserMap);
    print("getUser at FirestoreDatabaseService: " + _userModel.toString());
    return _userModel;
  }
}
