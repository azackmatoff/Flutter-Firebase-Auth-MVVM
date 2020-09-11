import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';
import 'package:flutter_firebase_auth_mvvm/screens/sign_in_with_email.dart';
import 'package:flutter_firebase_auth_mvvm/viewmodels/user_view_model.dart';
import 'package:flutter_firebase_auth_mvvm/widgets/fb_auth_button.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  void _signInWithGoogle(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    try {
      UserModel _user = await _userViewModel.signInWithGoogle();
    } on PlatformException catch (e) {
      print("signInWithGoogle Error :" + e.message.toString());
    }
  }

  void _signInWithFacebook(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      UserModel _user = await _userViewModel.signInWithFacebook();
    } on PlatformException catch (e) {
      print("signInWithFacebook Error :" + e.message.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => SignInWithEmailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase MVVM Auth"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN IN",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 8,
            ),
            FirebaseAuthButton(
              buttonText: "Sign in with Gmail",
              textColor: Colors.black87,
              buttonColor: Colors.white,
              buttonIcon: Image.asset("assets/images/google-logo.png"),
              onPressed: () => _signInWithGoogle(context),
              email: false,
            ),
            FirebaseAuthButton(
              buttonText: "Sign in with Facebook",
              buttonIcon: Image.asset("assets/images/facebook-logo.png"),
              onPressed: () => _signInWithFacebook(context),
              buttonColor: Color(0xFF334D92),
              email: false,
            ),
            FirebaseAuthButton(
              onPressed: () => _signInWithEmail(context),
              buttonIcon: Icon(
                Icons.email,
                color: Colors.white,
                size: 36,
              ),
              buttonText: "Sign in with Your Email",
              buttonColor: Colors.amberAccent,
              textColor: Colors.black,
              email: true,
            ),
          ],
        ),
      ),
    );
  }
}
