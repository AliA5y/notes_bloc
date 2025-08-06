import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_bloc/core/services/data_service.dart';

class AdminService extends DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<bool> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    final collPath = path.split('/').first;
    final docPath = path.split('/').last;

    final doc = firestore.collection(collPath).doc(docPath);
    try {
      await doc.set(data, SetOptions(merge: true));
      return true;
    } on TimeoutException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String docuementId}) {
    // TODO: implement checkIfDataExists
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> getData(
      {required String path,
      String? docuementId,
      Map<String, dynamic>? query}) async {
    final collPath = path.split('/').first;
    final docPath = path.split('/').last;
    final doc = firestore.collection(collPath).doc(docPath);
    return (await doc.get()).data();
  }

  Future<List<Map<String, dynamic>>?> getAllOnCollectionData({
    required String collPath,
  }) async {
    try {
      final coll = await firestore.collection(collPath).get();
      return coll.docs.map((doc) => doc.data()).toList();
    } on Exception catch (_) {
      return null;
    }
  }
}
