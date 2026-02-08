abstract class DataBaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });
  Future<dynamic> getData({required String path, String? documentId});
  Future<dynamic> deleteData({required String path, String? documentId});
  Future<void> updateUserOnlineStatus({
    required String userId,
    required bool isOnline,
  });
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });
  Stream getDataStream({required String uId, required String path});
  Stream<List<dynamic>> getAllDataStream({required String path});
}
