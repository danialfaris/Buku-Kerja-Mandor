import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:buku_kerja_mandor/models/user_model.dart';

class AuthService{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user){
    if (user == null){
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user{
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
      String email,
      String password,
      )
  async {
    try{
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email,
      String password,
      )
  async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}