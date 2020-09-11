import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_mvvm/screens/home_screen.dart';
import 'package:flutter_firebase_auth_mvvm/screens/sign_in_screen.dart';
import 'package:flutter_firebase_auth_mvvm/viewmodels/user_view_model.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  final bool state;

  const LandingScreen({this.state});

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);

    if (_userViewModel.state == ViewState.IDLE) {
      if (_userViewModel.user == null) {
        return SignInScreen();
      } else {
        print(
            "_userViewModel.user.email HomeScreen ${_userViewModel.user.email}");
        return HomeScreen(userModel: _userViewModel.user);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
