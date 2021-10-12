import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';

class SignupRepository extends Disposable {
  Future<UserModel?> signup(
      {required UserModel userModel, required String password}) async {
    try {
      UserCredential userCredential;
      UserModel model = UserModel();
      log('criando usuario...');

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: userModel.email.toString(),
        password: password,
      )
          .then((credential) async {
        userCredential = credential;

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toMap());

        var snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .get();
        model = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
        model.id = credential.user!.uid;
      }).catchError((onError) {
        throw onError;
      });
      return model;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');

        rethrow;
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        rethrow;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {}
}
//

