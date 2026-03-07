import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/models/query_params.dart';
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
        exceptionMeassge: "Failed to delete Data :${e.toString()}",
      );
    }
  }

  @override
  Future<void> updateSingleData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    try {
      await firestore.collection(path).doc(documentId).update(data);
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to update Data :${e.toString()}",
      );
    }
  }

  @override
  Future<dynamic> getData({required String path}) async {
    try {
      return await firestore.collection(path).get();
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to get Data :${e.toString()}",
      );
    }
  }

  @override
  Stream getSingleDataStream({
    required String uId,
    required String path,
  }) async* {
    try {
      var data = firestore.collection(path).doc(uId).snapshots();
      await for (var result in data) {
        yield result.data();
      }
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to get Stream Data :${e.toString()}",
      );
    }
  }

  @override
  Stream<List<dynamic>> getAllDataQueryStream({
    required String path,
    required QueryParams query,
  }) async* {
    try {
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
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to get query data Stream :${e.toString()}",
      );
    }
  }

  @override
  Future<dynamic> getSingleData({
    required String path,
    required String documentId,
  }) async {
    try {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.data();
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to get Data :${e.toString()}",
      );
    }
  }

  @override
  Future<void> addSinleData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    try {
      await firestore.collection(path).doc(documentId).set(data);
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to add Data :${e.toString()}",
      );
    }
  }

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      await firestore.collection(path).add(data);
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to Add Data :${e.toString()}",
      );
    }
  }

  @override
  Stream<List<dynamic>> getAllDataStream({required String path}) async* {
    try {
      yield* firestore
          .collection(path)
          .snapshots()
          .map((snapShots) => snapShots.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to get Stream Data :${e.toString()}",
      );
    }
  }

  @override
  Future<void> deleteBatchData({
    required String path,
    required QueryParams query,
  }) async {
    try {
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
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to delete batch Data :${e.toString()}",
      );
    }
  }

  @override
  Future<void> updateBatchData({
    required String path,
    required Map<String, dynamic> updatedData,

    required QueryParams query,
  }) async {
    try {
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
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "Failed to update batch Data :${e.toString()}",
      );
    }
  }
}
