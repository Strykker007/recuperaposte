import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';

class LoginRepository extends Disposable {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserModel?> login(
      {required String email, required String password}) async {
    UserModel model = UserModel();

    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((onError) {
        throw onError;
      });
      User user = FirebaseAuth.instance.currentUser as User;

      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      model = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      model.id = user.uid;
      return model;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        rethrow;
      }
    }
  }

  Future<void> passwordRecovery(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
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
