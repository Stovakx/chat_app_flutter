import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //login
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //uložení user informací pokud neexistují
      _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({"uid": userCredential.user!.uid, 'email': email});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //logout
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //register
  Future<UserCredential> signUpWithEmailPassword(
      String email, password, firstName, lastName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //uložení informací o uživateli do rozdílného docs
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        'email': email,
        "fullName": '$firstName $lastName'
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //získání userDat
  Future<DocumentSnapshot> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await _firestore.collection("Users").doc(user.uid).get();
    } else {
      throw Exception("User not logged in");
    }
  }

//úprava userDat
  Future<void> updateUserData(
      String userId, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection("Users").doc(userId).update(newData);
    } catch (e) {
      throw Exception("Failed to update user data: $e");
    }
  }
}
