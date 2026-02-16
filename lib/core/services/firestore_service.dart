import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/models/firestore_query_filter.dart';
import 'package:real_time_chat_app/core/models/query_filter_model.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';

class FirestoreService implements DataBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // delete Data
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

  // update Data
  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    await firestore.collection(path).doc(documentId).update(data);
  }

  // get Data
  @override
  Future<dynamic> getData({required String path}) async {
    return await firestore.collection(path).get();
  }

  @override
  Stream getSingleDataStream({
    required String uId,
    required String path,
  }) async* {
    var data = firestore.collection(path).doc(uId).snapshots();
    await for (var result in data) {
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
          data = data.where("receiverId", isEqualTo: receiverId);
        }

        if (query["status"] != null) {
          var status = query["status"];
          data = data.where("status", isEqualTo: status);
        }

        if (query["createdAt"] != null) {
          var createdAt = query["createdAt"];
          data = data.orderBy("createdAt", descending: createdAt);
        }
      }

      // هنا أنت بتعمل transformation للـ Stream
      var listOfMap = data.snapshots().map(
        (stream) => stream.docs.map((doc) => doc.data()).toList(),
      );

      await for (var result in listOfMap) {
        yield result;
      }
    }
  }

  @override
  Future<dynamic> getSingleData({
    required String path,
    required String documentId,
  }) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.data();
  }

  @override
  Future<dynamic> getQueryData({
    required String path,
    required List<QueryFilterModel> filters,
  }) async {
    Query query = firestore.collection(path);

    for (var filter in filters) {
      if (filter is FirestoreQueryFilter) {
        switch (filter.operator) {
          case "==":
            query = query.where(filter.field, isEqualTo: filter.value);
            break;
        }
      }
    }

    final snapshot = await query.get();

    // WriteBatch batch = firestore.batch();
    // for (var doc in snapshot.docs) {
    //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //   if (data["data"] != null &&
    //       (data["data"]["senderId"] == relatedUserId ||
    //           data["data"]["userId"] == relatedUserId)) {
    //     batch.delete(doc.reference);
    //   }
    //   await batch.commit();
    // }
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // add Data
  @override
  Future<void> addSinleData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    await firestore.collection(path).doc(documentId).set(data);
  }

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(path).add(data);
  }
}
