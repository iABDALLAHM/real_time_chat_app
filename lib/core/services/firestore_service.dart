import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';

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
  Future<void> updateUserOnlineStatus({
    required String userId,
    required bool isOnline,
  }) async {
    try {
      var data = await firestore
          .collection(BackendEndPoints.getUsers)
          .doc(userId)
          .get();
      if (data.exists) {
        firestore.collection(BackendEndPoints.getUsers).doc(userId).update({
          "isOnline": isOnline,
          "lastSeen": DateTime.now(),
        });
      }
    } catch (e) {
      throw CustomException(
        exceptionMeassge:
            "Failed to update user online status :${e.toString()}",
      );
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
  Stream getUserStream({required String uId, required String path}) async* {
    var data = firestore.collection(path).doc(uId);
    await for (var result in data.snapshots()) {
      yield result.data();
    }
  }

  @override
  Stream<List<dynamic>> getAllUsersStream({required String path}) {
    var data = firestore
        .collection(path)
        .snapshots()
        .map((snapShots) => snapShots.docs.map((doc) => doc.data()).toList());
    return data;
  }
}
