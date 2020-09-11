import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';

abstract class DatabaseBase {
  Future<bool> saveUser(UserModel user);
  Future<UserModel> getUser(String userID);
}
