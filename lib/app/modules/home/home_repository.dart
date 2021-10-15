import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:recuperaposte/app/core/models/user_model.dart';

class HomeRepository extends Disposable {
  Future<List<OcurrencyModel>> getOcurrencies(String userId) async {
    List<OcurrencyModel> ocurrencies = [];
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('ocorrencias')
          .where('userId', isEqualTo: userId)
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );
      for (var element in snapshot.docs) {
        ocurrencies.add(OcurrencyModel.fromMap(element.data()));
      }
    } catch (e) {
      rethrow;
    }

    return ocurrencies;
  }

  Future<UserModel> editUser(UserModel newUser, File image) async {
    try {
      String downloadUrl = '';

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(newUser.id.toString())
          .child(image.path.split('/').last);

      firebase_storage.UploadTask uploadTask = ref.putFile(image);

      firebase_storage.TaskSnapshot task = await uploadTask;

      downloadUrl = await task.ref.getDownloadURL();

      newUser.avatarUrl = downloadUrl;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.id)
          .set(newUser.toMap())
          .catchError(
        (onError) {
          throw onError;
        },
      );
      return newUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    UserModel userModel;
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('users').get().catchError(
        (onError) {
          throw onError;
        },
      );
      for (var element in snapshot.docs) {
        userModel = UserModel.fromMap(element.data());
        userModel.id = element.id;
        users.add(userModel);
      }
    } catch (e) {
      rethrow;
    }

    return users;
  }

  Future<List<UserModel>> getFilteredUsers(String name) async {
    List<UserModel> users = [];
    UserModel userModel;
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('users').get().catchError(
        (onError) {
          throw onError;
        },
      );
      for (var element in snapshot.docs) {
        if (element['name']
            .toString()
            .toLowerCase()
            .contains(name.toLowerCase())) {
          userModel = UserModel.fromMap(element.data());
          userModel.id = element.id;
          users.add(userModel);
        }
      }
    } catch (e) {
      rethrow;
    }

    return users;
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toMap())
          .catchError(
        (onError) {
          throw onError;
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {}
}
