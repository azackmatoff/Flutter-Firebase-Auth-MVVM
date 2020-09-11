import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';
import 'package:flutter_firebase_auth_mvvm/services/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

//The FirebaseUser class has been renamed to User.
// Returning a UserModel class type
  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return UserModel(userID: user.uid, email: user.email);
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      //The FirebaseUser class has been renamed to User.
      //Accessing the current user via currentUser() is now synchronous via the currentUser getter.
      User _user = _firebaseAuth.currentUser;
      // async is needed to get Future<UserModel>
      return _userFromFirebase(_user);
    } catch (e) {
      print("CurrentUser Error: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _facebookLogin.logOut();

      await _googleSignIn.signOut();

      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("sign out Error:" + e.toString());
      return false;
    }
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //The AuthResult class has been renamed to UserCredential
      UserCredential _userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(_userCred.user);
    } catch (e) {
      print("signInWithEmailandPassword Error: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<UserModel> createUserModelWithEmailandPassword(
      String email, String password) async {
    try {
      //The AuthResult class has been renamed to UserCredential
      UserCredential _userCred = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(_userCred.user);
    } catch (e) {
      print("createUserModelWithEmailandPassword Error: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    FacebookLoginResult _facebookLoginResult =
        await _facebookLogin.logIn(['public_profile', 'email']);

    switch (_facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        if (_facebookLoginResult.accessToken != null &&
            _facebookLoginResult.accessToken.isValid()) {
          UserCredential _userCred = await _firebaseAuth.signInWithCredential(
            //getCredential is now credential
            FacebookAuthProvider.credential(
                _facebookLoginResult.accessToken.token),
          );
          //The FirebaseUser class has been renamed to User.
          User _user = _userCred.user;
          return _userFromFirebase(_user);
        } else {
          return null;
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("User cancelled Facebool login");
        break;
      case FacebookLoginStatus.error:
        print(
            "Facebook login error: ${_facebookLoginResult.errorMessage.toString()}");
        break;
      default:
        return null;
    }
    return null;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        //The AuthResult class has been renamed to UserCredential
        UserCredential _userCred = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: _googleAuth.idToken,
              accessToken: _googleAuth.accessToken),
        );
        //The FirebaseUser class has been renamed to User.
        // thus, if you have your own User model, it's better
        // to name it not as User but UserModel
        User _user = _userCred.user;
        return _userFromFirebase(_user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

//The AuthResult class has been renamed to UserCredential
  @override
  Future<UserModel> singInAnonymously() async {
    try {
      UserCredential _user = await _firebaseAuth.signInAnonymously();
      //Since FirebaseUser class renamed to User, we need to get _user.user
      return _userFromFirebase(_user.user);
    } catch (e) {
      print("Sing In Anonymously Error: ${e.toString()}");
      return null;
    }
  }
}
