import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignupRepository extends Disposable {
  Future<void> signup() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {}
}
//

