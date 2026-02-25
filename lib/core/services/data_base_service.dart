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
  Future<dynamic> deleteSingleData({required String path,required String documentId});
  
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

  // قابلة للنقاش والتعديل
  Future<dynamic> getQueryData({
    required String path,
    String? relatedId,
    Map<String, dynamic>? query,
    bool isQuery = false,
  });
}
