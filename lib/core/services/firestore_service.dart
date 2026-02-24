import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
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

        if (query["senderId"] != null) {
          var senderId = query["senderId"];
          data = data.where("senderId", isEqualTo: senderId);
        }

        if (query["createdAt"] != null) {
          var createdAt = query["createdAt"];
          data = data.orderBy("createdAt", descending: createdAt);
        }

        if (query["userIds"] != null) {
          var userIds = query["userIds"];
          data = data.where("userIds", arrayContains: userIds);
        }

        if (query["userId"] != null) {
          var userId = query["userId"];
          data = data.where("userId", isEqualTo: userId);
        }

        // if (query["senderId"] != null) {
        //   var senderId = query["senderId"];
        //   data = data.where("senderId", whereIn: senderId);
        // }
      }

      // هنا أنت بتعمل transformation للـ Stream
      var listOfMap = data.snapshots().map(
        (stream) => stream.docs.map((doc) => doc.data()).toList(),
      );
      yield* listOfMap;
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
    Map<String, dynamic>? query,
    bool isQuery = false,
    String? relatedId,
    required String path,
  }) async {
    Query<Map<String, dynamic>> data = firestore.collection(path);

    if (query != null) {
      if (query["userId"] != null) {
        var userId = query["userId"];
        data = data.where("userId", isEqualTo: userId);
      }

      if (query["type"] != null) {
        var type = query["type"];
        data = data.where("type", isEqualTo: type);
      }

      if (query["senderId"] != null) {
        var senderId = query["senderId"];
        data = data.where("senderId", isEqualTo: senderId);
      }

      if (query["receiverId"] != null) {
        var receiverId = query["receiverId"];
        data = data.where("receiverId", isEqualTo: receiverId);
      }

      if (query["status"] != null) {
        var status = query["status"];
        data = data.where("status", isEqualTo: status);
      }
    }

    final result = await data.get();

    // a lot of operations Done Here !!
    WriteBatch batch = firestore.batch();
    for (var doc in result.docs) {
      Map<String, dynamic> data = doc.data();

      if ((data["data"]["senderId"] == relatedId ||
          data["data"]["requestId"] == relatedId)) {
        batch.delete(doc.reference);
      }
    }
    await batch.commit();
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
