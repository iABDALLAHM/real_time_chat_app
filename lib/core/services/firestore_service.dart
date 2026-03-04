import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/models/firestore_query.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';

class FirestoreService implements DataBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<dynamic> deleteSingleData({
    required String path,
    required String documentId,
  }) async {
    try {
      await firestore.collection(path).doc(documentId).delete();
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to deleteData :${e.toString()}",
      );
    }
  }

  @override
  Future<void> updateSingleData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    await firestore.collection(path).doc(documentId).update(data);
  }

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
  Stream<List<dynamic>> getAllDataQueryStream({
    required String path,
    required QueryParams query,
  }) async* {
    Query<Map<String, dynamic>> data = firestore.collection(path);
    for (var condition in query.conditions) {
      if (condition.isEqualTo != null) {
        data = data.where(condition.field, isEqualTo: condition.isEqualTo);
      }

      if (condition.arrayContains != null) {
        data = data.where(
          condition.field,
          arrayContains: condition.arrayContains,
        );
      }

      if (condition.whereIn != null) {
        data = data.where(condition.field, whereIn: condition.whereIn);
      }
    }
    for (var order in query.orders) {
      data = data.orderBy(order.field, descending: order.descending);
    }

    var listOfMap = data.snapshots().map(
      (stream) => stream.docs.map((doc) => doc.data()).toList(),
    );
    yield* listOfMap;
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

  @override
  Stream<List<dynamic>> getAllDataStream({required String path}) async* {
    yield* firestore
        .collection(path)
        .snapshots()
        .map((snapShots) => snapShots.docs.map((doc) => doc.data()).toList());
  }

  @override
  Future<void> deleteBatchData({
    required String path,
    required QueryParams query,
  }) async {
    Query<Map<String, dynamic>> data = firestore.collection(path);
    for (var condition in query.conditions) {
      if (condition.isEqualTo != null) {
        data = data.where(condition.field, isEqualTo: condition.isEqualTo);
      }
      if (condition.whereIn != null) {
        data = data.where(condition.field, whereIn: condition.whereIn);
      }
      if (condition.arrayContains != null) {
        data = data.where(
          condition.field,
          arrayContains: condition.arrayContains,
        );
      }
    }

    for (var order in query.orders) {
      data = data.orderBy(order.field, descending: order.descending);
    }
    var result = await data.get();
    WriteBatch batch = firestore.batch();

    for (var doc in result.docs) {
      batch.delete(doc.reference);
    }
    batch.commit();
  }

  @override
  Future<void> updateBatchData({
    required String path,
    required Map<String, dynamic> updatedData,

    required QueryParams query,
  }) async {
    Query<Map<String, dynamic>> data = firestore.collection(path);

    for (var condition in query.conditions) {
      if (condition.isEqualTo != null) {
        data = data.where(condition.field, isEqualTo: condition.isEqualTo);
      }
      if (condition.whereIn != null) {
        data = data.where(condition.field, whereIn: condition.whereIn);
      }
      if (condition.arrayContains != null) {
        data = data.where(
          condition.field,
          arrayContains: condition.arrayContains,
        );
      }
    }

    for (var order in query.orders) {
      data = data.orderBy(order.field, descending: order.descending);
    }

    var result = await data.get();
    WriteBatch batch = firestore.batch();

    for (var doc in result.docs) {
      batch.update(doc.reference, updatedData);
    }

    batch.commit();
  }
}
