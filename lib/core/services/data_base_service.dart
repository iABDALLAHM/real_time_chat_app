import 'package:real_time_chat_app/core/models/query_filter_model.dart';

abstract class DataBaseService {
  // add Data
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  });
  Future<void> addSinleData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });
  // delete data
  Future<dynamic> deleteData({required String path, String? documentId});

  // update data
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  // get stream data
  Stream getSingleDataStream({required String uId, required String path});

  Stream<List<dynamic>> getAllDataStream({
    required String path,
    bool isQuery = false,
    String? documentId,
    Map<String, dynamic>? query,
  });

  // get data
  Future<dynamic> getSingleData({
    required String path,
    required String documentId,
  });
  Future<dynamic> getData({required String path});

  
  // قابلة للنقاش
  Future<dynamic> getQueryData({
    required String path,
    required List<QueryFilterModel> filters,
  });
}
