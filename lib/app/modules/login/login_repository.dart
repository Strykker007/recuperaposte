import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginRepository extends Disposable {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Map<String, dynamic>?> login(
      {required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((onError) {
        throw onError;
      });
      User user = FirebaseAuth.instance.currentUser as User;

      var data = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      return data.data();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        rethrow;
      }
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  @override
  void dispose() {}
}
