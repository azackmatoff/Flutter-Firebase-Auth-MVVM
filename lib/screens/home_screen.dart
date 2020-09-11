import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_mvvm/models/user_model.dart';
import 'package:flutter_firebase_auth_mvvm/viewmodels/user_view_model.dart';
import 'package:flutter_firebase_auth_mvvm/widgets/fb_auth_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.userModel, Key key}) : super(key: key);

  final UserModel userModel;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool userSaved;
  UserModel _userModel;

  @override
  void initState() {
    userSaved = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _userViewModel.signOut(),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "User Data from Firebase",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            Text(widget.userModel.userID),
            Text(widget.userModel.email),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                FirebaseAuthButton(
                  buttonText: "Save User to Firestore",
                  buttonColor: Colors.amberAccent,
                  textColor: Colors.black,
                  email: true,
                  onPressed: () async {
                    print(
                        "widget.userSaved to Firestore ${widget.userModel.runtimeType}");
                    bool _userSaved =
                        await _userViewModel.saveUser(widget.userModel);
                    if (_userSaved) {
                      setState(() {
                        userSaved = true;
                      });
                      print("userSaved to Firestore $userSaved");
                    } else {
                      setState(() {
                        userSaved = false;
                      });
                      print("userSaved Firestore $userSaved");
                    }
                  },
                ),
                FirebaseAuthButton(
                  buttonText: "Get User from Firestore",
                  buttonColor: Colors.cyanAccent,
                  textColor: Colors.black,
                  email: true,
                  onPressed: () async {
                    var _userModelData =
                        await _userViewModel.getUser(widget.userModel.userID);

                    // I'm using setState to get the updated data of _userModel
                    // I'll be using _userModel to show fetched data from Firestore or not to show them
                    setState(() {
                      _userModel = _userModelData;
                    });
                  },
                )
              ],
            ),
            userSaved
                ? Text("User Successfully Saved to Firestore")
                : Container(),
            _userModel != null
                ? Expanded(
                    child: ListView(
                      children: [
                        Text(
                          "User Data From Firestore",
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        ),
                        Text(_userModel.userID),
                        Text(_userModel.username),
                        Text(_userModel.email),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
