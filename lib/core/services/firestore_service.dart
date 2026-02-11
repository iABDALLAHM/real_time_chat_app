import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
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
  Future<dynamic> getData({required String path, String? documentId}) async {
    if (documentId != null) {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.data();
    } else {
      return await firestore.collection(path).get();
    }
  }

  @override
  Future<dynamic> deleteData({required String path, String? documentId}) async {
    try {
      await firestore.collection(path).doc(documentId).delete();
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to deleteData :${e.toString()}",
      );
    }
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    await firestore.collection(path).doc(documentId).update(data);
  }

  @override
  Stream getDataStream({required String uId, required String path}) async* {
    var data = firestore.collection(path).doc(uId);
    await for (var result in data.snapshots()) {
      yield result.data();
    }
  }

  @override
  Stream<List<dynamic>> getAllDataStream({
    required String path,
    bool isQuery = false,
    String? documentId,
    Map<String, dynamic>? query,
  }) async* {
    if (isQuery == false) {
      yield* firestore
          .collection(path)
          .snapshots()
          .map((snapShots) => snapShots.docs.map((doc) => doc.data()).toList());
    } else {
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        if (query["receiverId"] != null) {
          var receiverId = query["receiverId"];
          data.where("receiverId", isEqualTo: documentId);
        }

        if (query["status"] != null) {
          var status = query["status"];
          data.where("status", isEqualTo: "pending");
        }

        if (query["createdAt"] != null) {
          var createdAt = query["createdAt"];
          data = data.orderBy("createdAt", descending: true);
        }
      }
      var result = data.snapshots().map(
        (snapShots) => snapShots.docs.map((doc) => doc.data()).toList(),
      );
      // yield result;
    }
  }
}
