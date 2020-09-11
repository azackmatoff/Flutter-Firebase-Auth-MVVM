import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_mvvm/locator.dart';
import 'package:flutter_firebase_auth_mvvm/services/fake_auth_service.dart';
import 'package:flutter_firebase_auth_mvvm/services/firebase_auth_service.dart';
import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';
import 'package:flutter_firebase_auth_mvvm/services/auth_base.dart';
import 'package:flutter_firebase_auth_mvvm/services/firestore_db_service.dart';

enum DatabaseMode { FAKEDB, FIREBASEDB }

class Repository extends ChangeNotifier implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FirestoreDatabaseService _firestoreDatabaseService =
      locator<FirestoreDatabaseService>();
  FakeAuthService _fakeAuthService = locator<FakeAuthService>();
  DatabaseMode _databaseMode = DatabaseMode.FIREBASEDB;

  @override
  Future<UserModel> currentUser() async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firebaseAuthService.currentUser();
    } else {
      return await _fakeAuthService.currentUser();
    }
  }

  Future<bool> saveUser(UserModel user) async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firestoreDatabaseService.saveUser(user);
    } else {
      return null;
    }
  }

  Future<UserModel> getUser(String userID) async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firestoreDatabaseService.getUser(userID);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String password) async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firebaseAuthService.signInWithEmailandPassword(
        email,
        password,
      );
    } else {
      return await _fakeAuthService.signInWithEmailandPassword(
        email,
        password,
      );
    }
  }

  @override
  Future<UserModel> createUserModelWithEmailandPassword(
      String email, String password) async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firebaseAuthService.createUserModelWithEmailandPassword(
        email,
        password,
      );
    } else {
      return await _fakeAuthService.createUserModelWithEmailandPassword(
        email,
        password,
      );
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firebaseAuthService.signInWithFacebook();
    } else {
      return await _fakeAuthService.signInWithFacebook();
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firebaseAuthService.signInWithGoogle();
    } else {
      return await _fakeAuthService.signInWithGoogle();
    }
  }

  @override
  Future<bool> signOut() async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firebaseAuthService.signOut();
    } else {
      return await _fakeAuthService.signOut();
    }
  }

  @override
  Future<UserModel> singInAnonymously() async {
    if (_databaseMode == DatabaseMode.FIREBASEDB) {
      return await _firebaseAuthService.singInAnonymously();
    } else {
      return await _fakeAuthService.singInAnonymously();
    }
  }
}
