import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';

abstract class AuthBase {
  Future<UserModel> currentUser();
  Future<UserModel> singInAnonymously();
  Future<bool> signOut();
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithEmailandPassword(String email, String password);
  Future<UserModel> createUserModelWithEmailandPassword(
      String email, String password);
}
