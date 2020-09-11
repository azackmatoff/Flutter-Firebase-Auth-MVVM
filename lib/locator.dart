import 'package:flutter_firebase_auth_mvvm/repos/repository.dart';
import 'package:flutter_firebase_auth_mvvm/services/fake_auth_service.dart';
import 'package:flutter_firebase_auth_mvvm/services/firebase_auth_service.dart';
import 'package:flutter_firebase_auth_mvvm/services/firestore_db_service.dart';
import 'package:flutter_firebase_auth_mvvm/viewmodels/user_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthService());
  locator.registerLazySingleton(() => FirestoreDatabaseService());
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton(() => UserViewModel());
}
