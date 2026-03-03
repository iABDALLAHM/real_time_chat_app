import 'package:real_time_chat_app/core/models/firestore_query.dart';

abstract class DataBaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  });
  Future<void> addSinleData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });

  Future<dynamic> deleteSingleData({
    required String path,
    required String documentId,
  });

  Future<void> updateSingleData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });

  Future<void> updateBatchData({
    required String path,
    required Map<String,dynamic> updatedData,
    required QueryParams query,
  });

  Future<void> deleteBatchData({
    required String path,
    required QueryParams query,
  });

  Stream getSingleDataStream({required String uId, required String path});

  Stream<List<dynamic>> getAllDataQueryStream({
    required String path,
    required QueryParams query,
  });

  Stream<List<dynamic>> getAllDataStream({required String path});

  Future<dynamic> getSingleData({
    required String path,
    required String documentId,
  });

  Future<dynamic> getData({required String path});
}
