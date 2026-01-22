import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';

class FirestoreService implements DataBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<void> getData({required String path, String? documentId}) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).get();
    } else {
      await firestore.collection(path).get();
    }
  }
}
