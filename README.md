# flutter_firebase_auth_mvvm

Flutter Firebase Auth MVVM by AZ Ackmatoff.<br>
Email sign in and create<br>
Google sign in<br>
Facebook login<br>
Simple Firestore CRUD<br>

## Getting Started

Things you need to do after having done with cloning the project:
1. Android setups
 - Create a firebase project
 - Get your google-services.json
 - Add your google-services.json under android/app/ directory
 - Do not forget to modify both project level and app level build.gradle files
 <br><br>
2. iOS setups are not configured, if you wish, you can do them yourself and feel free to PR.
<br><br>
3. Firebase Console works
 - Enable email, google, facebook sign-in providers under Authentication/Sign-in method
 - In order to enable Facebook, you need to create a Facebook App and get your App ID and Secret Key here: https://developers.facebook.com/
 - Do not forget to add Android and iOS as platforms and to take care of needed modifications
 <br><br>
4. The packages I'm using are*:<br>
 dependencies:<br>
  flutter:<br>
    sdk: flutter<br>
  cupertino_icons: ^0.1.3<br>
  firebase_core: ^0.5.0<br>
  cloud_firestore: ^0.14.0<br>
  firebase_auth: ^0.18.0<br>
  flutter_facebook_login: ^3.0.0<br>
  google_sign_in: ^4.5.1<br>
  provider: ^4.3.2<br>
  get_it: ^4.0.4
  
  *NOTE: Do not forget to configure Android and iOS related setups of needed packages<br>
  For Google Sign In: do not forget to get your SHA-1 key and add it to your firebase project!<br>
  For Facebook Login: do not forget to get your SHA-1 key, convert its value to base64 (http://tomeko.net/online_tools/hex_to_base64.php), and add it to your facebook project (https://developers.facebook.com/docs/facebook-login/android)!<br>

## Flutter Documentation

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
