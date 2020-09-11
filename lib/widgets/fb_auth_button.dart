import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_mvvm/constants/constants.dart';

class FirebaseAuthButton extends StatelessWidget {
  final bool email;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double height;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  const FirebaseAuthButton({
    Key key,
    @required this.email,
    this.buttonText,
    this.buttonColor,
    this.textColor: kWhite,
    this.radius: 16,
    this.height,
    this.buttonIcon,
    @required this.onPressed,
  })  : assert(
          onPressed != null,
          email != null,
        ),
        super(key: key);

// You don't need to have two different widgets,
// this is just two show in case you wanna have
// different widget for email
// In my example both are the same widgets
  buildEmailButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: height,
        child: RaisedButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buttonIcon != null ? buttonIcon : Container(),
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor),
              ),
              Opacity(opacity: 0, child: buttonIcon)
            ],
          ),
          color: buttonColor,
        ),
      ),
    );
  }

  buildSocialButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: height,
        child: RaisedButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buttonIcon != null ? buttonIcon : Container(),
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor),
              ),
              Opacity(opacity: 0, child: buttonIcon)
            ],
          ),
          color: buttonColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return email ? buildEmailButton() : buildSocialButton();
  }
}
