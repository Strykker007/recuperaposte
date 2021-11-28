import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recuperaposte/app/core/models/ocurrency_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class OcurrencyRepository extends Disposable {
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

  Future<void> registerOcurrency(OcurrencyModel ocurrency, File image) async {
    try {
      String downloadUrl = '';
      log('criando ocorrência...');

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('ocorrencias')
          .child(image.path.split('/').last);

      firebase_storage.UploadTask uploadTask = ref.putFile(image);

      firebase_storage.TaskSnapshot task = await uploadTask;

      downloadUrl = await task.ref.getDownloadURL();

      ocurrency.urlPhoto = downloadUrl;

      var snapshot = await FirebaseFirestore.instance
          .collection('utils')
          .doc('protocolSequence')
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      ocurrency.protocol = snapshot['id'];

      await FirebaseFirestore.instance
          .collection('ocorrencias')
          .doc(ocurrency.protocol.toString())
          .set(ocurrency.toMap())
          .then((result) {})
          .catchError(
        (onError) {
          throw onError;
        },
      );

      int id = snapshot['id'] + 1;

      await FirebaseFirestore.instance
          .collection('utils')
          .doc('protocolSequence')
          .set({'id': id}).catchError(
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

  Future<List<OcurrencyModel>> getOcurrencies() async {
    List<OcurrencyModel> ocurrencies = [];
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('ocorrencias')
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      for (var element in snapshot.docs) {
        ocurrencies.add(OcurrencyModel.fromMap(element.data()));
      }
      return ocurrencies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getProblemInfo() async {
    List<Map<String, dynamic>> problems = [];
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('utils')
          .doc('problems')
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      snapshot.data()!.forEach((key, value) {
        problems.add({
          'value': value,
          'label': value,
        });
      });

      return problems;
    } catch (e) {
      rethrow;
    }
  }

  Future<OcurrencyModel> getOcurrency(int protocol) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('ocorrencias')
          .doc(protocol.toString())
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      OcurrencyModel model =
          OcurrencyModel.fromMap(snapshot.data() as Map<String, dynamic>);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OcurrencyModel>> getFilteredOcurrencies(int protocol) async {
    List<OcurrencyModel> ocurrencies = [];
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('ocorrencias')
          .where('protocol', isEqualTo: protocol)
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      for (var element in snapshot.docs) {
        ocurrencies.add(OcurrencyModel.fromMap(element.data()));
      }
      return ocurrencies;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateOcurrency(OcurrencyModel ocurrency) async {
    try {
      await FirebaseFirestore.instance
          .collection('ocorrencias')
          .doc(ocurrency.protocol.toString())
          .set(ocurrency.toMap())
          .catchError(
        (onError) {
          throw onError;
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<OcurrencyModel> getOcurrencyByProtocol(int protocol) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('ocorrencias')
          .doc(protocol.toString())
          .get()
          .catchError(
        (onError) {
          throw onError;
        },
      );

      OcurrencyModel result =
          OcurrencyModel.fromMap(snapshot.data() as Map<String, dynamic>);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {}
}
