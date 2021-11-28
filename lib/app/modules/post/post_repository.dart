import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recuperaposte/app/core/models/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PostRepository extends Disposable {
  Future<void> createPost(PostModel model, File image) async {
    try {
      String downloadUrl = '';
      log('criando poste...');

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('posts')
          .child(image.path.split('/').last);

      firebase_storage.UploadTask uploadTask = ref.putFile(image);

      firebase_storage.TaskSnapshot task = await uploadTask;

      downloadUrl = await task.ref.getDownloadURL();

      model.urlPhoto = downloadUrl;

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(model.postNumber.toString())
          .set(model.toMap())
          .then((result) {})
          .catchError(
        (onError) {
          throw onError;
        },
      );
    } on FirebaseException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<PostModel>> getPosts() async {
    List<PostModel> posts = [];
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('posts').get().catchError(
        (onError) {
          throw onError;
        },
      );

      for (var element in snapshot.docs) {
        posts.add(PostModel.fromMap(element.data()));
      }
      return posts;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getPostType() async {
    List<Map<String, dynamic>> postTypes = [];
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('utils')
          .doc('postType')
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      snapshot.data()!.forEach((key, value) {
        postTypes.add({
          'value': value,
          'label': value,
        });
      });

      return postTypes;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getIluminationType() async {
    List<Map<String, dynamic>> iluminationType = [];
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('utils')
          .doc('iluminationType')
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      snapshot.data()!.forEach((key, value) {
        iluminationType.add({
          'value': value,
          'label': value,
        });
      });

      return iluminationType;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getStatusType() async {
    List<Map<String, dynamic>> statusType = [];
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('utils')
          .doc('postStatus')
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      snapshot.data()!.forEach((key, value) {
        statusType.add({
          'value': value,
          'label': value,
        });
      });

      return statusType;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(String postNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postNumber)
          .delete()
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
