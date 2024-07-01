import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_architecture/di/firebase_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthDataSource {
  final FirebaseService _firebaseService;

  const AuthDataSource(this._firebaseService);

  Future<User> registerUser(String email, String password, String name) async {
    final UserCredential userCredential = await _firebaseService.auth
        .createUserWithEmailAndPassword(email: email, password: password);

    final User? user = userCredential.user;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();
      User? updatedUser = _firebaseService.auth.currentUser;

      if (updatedUser == null) {
        throw Exception('User registration failed');
      }

      return updatedUser;
    } else {
      throw Exception('User registration failed');
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await _firebaseService.auth
        .signInWithEmailAndPassword(email: email, password: password);
    final User? user = userCredential.user;
    if (user != null) {
      return user;
    } else {
      throw Exception('Sign in failed');
    }
  }

  Future<User> getCurrentUser() async {
    final User? user = _firebaseService.auth.currentUser;
    if (user != null) {
      return user;
    } else {
      throw Exception('No user logged in');
    }
  }

  Future<bool> isSignedIn() async {
    final User? user = _firebaseService.auth.currentUser;
    return user != null;
  }

  Future<void> signOut() async {
    _firebaseService.auth.signOut();
  }
}
