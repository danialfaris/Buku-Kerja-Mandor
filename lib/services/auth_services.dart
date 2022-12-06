import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:buku_kerja_mandor/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var uname = "";
  var role = "";
  String? get getEmail => _firebaseAuth.currentUser!.email;
  String? get getUsername => uname;
  String? get getRole => role;

  setLogin(String? email) async {
    final SharedPreferences prefs = await _prefs;
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _db
        .collection('akun').doc('$email').get();
    final String username = (snapshot.data()!["username"]);
    final String urole = (snapshot.data()!["role"]);
    await prefs.setString('username', username);
    await prefs.setString('role', urole);
    uname = username;
    role = urole;
  }

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
      String username,
      String password,
      )
  async {
    QuerySnapshot snap = await _db.collection("akun").where("username", isEqualTo: username).get();
    try{
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: snap.docs[0]['email'],
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
      String username,
      )
  async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    await _db.collection("akun").add({
      'email': email,
      'username': username,
      'role': "user",
    });
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}