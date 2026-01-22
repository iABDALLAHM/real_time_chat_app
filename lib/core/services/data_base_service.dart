abstract class DataBaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });
  Future<void> getData({required String path});
}
