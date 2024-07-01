import 'package:flutter_firebase_architecture/di/firebase_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get firebaseService => FirebaseService.init();
}
