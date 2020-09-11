import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_mvvm/locator.dart';
import 'package:flutter_firebase_auth_mvvm/repos/repository.dart';
import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';
import 'package:flutter_firebase_auth_mvvm/services/auth_base.dart';

enum ViewState { IDLE, BUSY }

class UserViewModel extends ChangeNotifier implements AuthBase {
  ViewState _viewState = ViewState.IDLE;
  Repository _repository = locator<Repository>();

  UserModel _userModel;
  String wrongEmailMessage;
  String wrongPasswordMessage;

  UserModel get user => _userModel;

  ViewState get state => _viewState;

// to notify UI of ViewState's state changes we use notifyListeners()
  set state(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      _viewState = ViewState.BUSY;
      _userModel = await _repository.currentUser();
      notifyListeners();
      if (_userModel != null) {
        return _userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("Currentuser Error at UserViewModel: " + e.toString());
      return null;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }

  Future<bool> saveUser(UserModel user) async {
    try {
      return await _repository.saveUser(user);
    } catch (e) {
      print("saveUser Error at UserViewModel: " + e.toString());
      return null;
    }
  }

  Future<UserModel> getUser(String userID) async {
    try {
      return await _repository.getUser(userID);
    } catch (e) {
      print("getUser Error at UserViewModel: " + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel> createUserModelWithEmailandPassword(
      String email, String password) async {
    if (email != null && password != null) {
      if (_checkEmailPassword(email, password)) {
        try {
          _viewState = ViewState.BUSY;
          notifyListeners();
          _userModel = await _repository.createUserModelWithEmailandPassword(
            email,
            password,
          );
          if (_userModel != null) {
            return _userModel;
          } else {
            return null;
          }
        } catch (e) {
          print("createUserModelWithEmailandPassword Error at UserViewModel: " +
              e.toString());
          return null;
        } finally {
          _viewState = ViewState.IDLE;
          notifyListeners();
        }
      } else {
        return null;
      }
    } else
      return null;
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String password) async {
    if (email != null && password != null) {
      if (_checkEmailPassword(email, password)) {
        try {
          _viewState = ViewState.BUSY;
          notifyListeners();
          _userModel = await _repository.signInWithEmailandPassword(
            email,
            password,
          );
          if (_userModel != null) {
            return _userModel;
          } else {
            return null;
          }
        } catch (e) {
          print("signInWithEmailandPassword Error at UserViewModel: " +
              e.toString());
          return null;
        } finally {
          _viewState = ViewState.IDLE;
          notifyListeners();
        }
      } else {
        return null;
      }
    } else {
      wrongPasswordMessage = "Password field is empty";
      wrongEmailMessage = "Email field is empty";
      return null;
    }
  }

  bool _checkEmailPassword(String email, String password) {
    var _result = true;
    // Validate empty field
    if (email.length < 1 || password.length < 1) {
      wrongPasswordMessage = "Password field is empty";
      wrongEmailMessage = "Email field is empty";
      _result = false;
    } else {
      wrongEmailMessage = null;
      wrongPasswordMessage = null;
    }

    if (password.length < 6) {
      // Firebase asks for at least 6 character password
      wrongPasswordMessage = "Password needs to be at least 6 characters";
      _result = false;
    } else {
      wrongPasswordMessage = null;
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      wrongEmailMessage = "Please write a valid email";
      _result = false;
    } else {
      wrongEmailMessage = null;
    }

    return _result;
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      _viewState = ViewState.BUSY;
      notifyListeners();
      _userModel = await _repository.signInWithFacebook();
      if (_userModel != null) {
        return _userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("signInWithFacebook Error at UserViewModel: " + e.toString());
      return null;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      _viewState = ViewState.BUSY;
      notifyListeners();
      _userModel = await _repository.signInWithGoogle();
      if (_userModel != null) {
        print("userModel signInWithGoogle at UserViewModel $_userModel");
        return _userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("signInWithGoogle Error at UserViewModel: " + e.toString());
      return null;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      _viewState = ViewState.BUSY;
      notifyListeners();
      bool _result = await _repository.signOut();
      _userModel = null;
      return _result;
    } catch (e) {
      print("signOut Error at UserViewModel: " + e.toString());
      return false;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }

  @override
  Future<UserModel> singInAnonymously() async {
    try {
      _viewState = ViewState.BUSY;
      notifyListeners();
      _userModel = await _repository.singInAnonymously();
      if (_userModel != null) {
        return _userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("singInAnonymously Error at UserViewModel: " + e.toString());
      return null;
    } finally {
      _viewState = ViewState.IDLE;
      notifyListeners();
    }
  }
}
