import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';
import 'package:flutter_firebase_auth_mvvm/screens/landing_screen.dart';
import 'package:flutter_firebase_auth_mvvm/viewmodels/user_view_model.dart';
import 'package:flutter_firebase_auth_mvvm/widgets/fb_auth_button.dart';
import 'package:provider/provider.dart';

class SignInWithEmailScreen extends StatefulWidget {
  SignInWithEmailScreen({Key key}) : super(key: key);

  @override
  _SignInWithEmailScreenState createState() => _SignInWithEmailScreenState();
}

class _SignInWithEmailScreenState extends State<SignInWithEmailScreen> {
  String _email, _password;
  bool registering;
  UserModel _userModel;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    final form = _formKey.currentState;

    form.save();
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      if (registering == false) {
        _userModel =
            await _userViewModel.signInWithEmailandPassword(_email, _password);
      } else if (form.validate()) {
        _userModel = await _userViewModel.createUserModelWithEmailandPassword(
            _email, _password);
        // Save data to Firestore Database
        await _userViewModel.saveUser(_userModel);
      }

      if (_userModel != null) {
        SnackBar snackbar = SnackBar(
            content: Text("Your signed in/registered as ${_userModel.email}"));
        _scaffoldKey.currentState.showSnackBar(snackbar);

        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => SignInWithEmailScreen(),
          ),
        );
      }
    } on PlatformException catch (e) {
      print("signInWithEmail Error :" + e.message.toString());
    }
  }

  @override
  void initState() {
    setState(() {
      registering = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:
            registering ? Text("Get Registered") : Text("Sign In with Email"),
      ),
      body: _userViewModel.state == ViewState.IDLE
          ? SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            //initialValue: "az@az.com",
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorText:
                                  _userViewModel.wrongEmailMessage != null
                                      ? _userViewModel.wrongEmailMessage
                                      : null,
                              prefixIcon: Icon(Icons.mail),
                              hintText: 'Email',
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (String email) {
                              _email = email;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            //initialValue: "password",
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText:
                                  _userViewModel.wrongPasswordMessage != null
                                      ? _userViewModel.wrongPasswordMessage
                                      : null,
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password',
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          registering
                              ? SizedBox(
                                  height: 8,
                                )
                              : Container(),
                          registering
                              ? TextFormField(
                                  //initialValue: "password",
                                  controller: confirmPassController,
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return "Password field is empty";
                                    if (val != passwordController.text)
                                      return "Password doesn't match";

                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: 'Reenter Password',
                                    labelText: 'Reenter Password',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (String password) {
                                    _password = password;
                                  },
                                )
                              : Container(),
                          SizedBox(
                            height: 8,
                          ),
                          FirebaseAuthButton(
                            buttonText:
                                registering ? "Get Registered" : "Sign In",
                            textColor: Colors.black,
                            height: 50,
                            buttonColor: Colors.lightBlueAccent,
                            radius: 40,
                            onPressed: () => _submit(),
                            email: true,
                          ),
                          registering ? Container() : Text("NOT REGISTERED?"),
                          FirebaseAuthButton(
                            buttonText: registering
                                ? "Back to Login"
                                : "Create your account",
                            textColor: Colors.black,
                            buttonColor: Colors.white,
                            radius: 40,
                            onPressed: () {
                              setState(() {
                                if (registering == false) {
                                  registering = true;
                                } else {
                                  registering = false;
                                }
                              });
                            },
                            email: true,
                          )
                        ],
                      )),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
