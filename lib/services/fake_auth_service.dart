import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';
import 'package:flutter_firebase_auth_mvvm/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  @override
  Future<UserModel> currentUser() async {
    return await Future.value(
        UserModel(userID: "fakeCurrentUserID", email: "fakeuser@fake.com"));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String password) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => UserModel(
            userID: "signedInFakeUserID_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserModel> createUserModelWithEmailandPassword(
      String email, String password) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => UserModel(
            userID: "createdFakeUserID_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => UserModel(
            userID: "facebookFakeUserID_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => UserModel(
            userID: "googleFakeUserID_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserModel> singInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => UserModel(
            userID: "fakeAnonymousUserID", email: "fakeuser@fake.com"));
  }
}
