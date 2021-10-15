import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:recuperaposte/app/core/models/user_model.dart';

class HomeRepository extends Disposable {
  Future<List<OcurrencyModel>> getOcurrencies(String userId) async {
    List<OcurrencyModel> ocurrencies = [];
    var snapshot = await FirebaseFirestore.instance
        .collection('ocorrencias')
        .where('userId', isEqualTo: userId)
        .get()
        .catchError((onError) {
      log(onError.toString());
    });

    for (var element in snapshot.docs) {
      ocurrencies.add(OcurrencyModel.fromMap(element.data()));
    }

    return ocurrencies;
  }

  Future<UserModel> editUser(UserModel newUser) async {
    return newUser;
  }

  @override
  void dispose() {}
}
