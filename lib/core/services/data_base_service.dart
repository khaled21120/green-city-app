abstract class DatabaseService {
  Future<bool> sendData({
    required String endPoint,
    required Map<String, dynamic> data,
  });
  Future<Map<String, dynamic>> fetchMapData({required String endPoint});
  Future<List<dynamic>> fetchListData({required String endPoint});
  Future<void> deleteData({required String endPoint});
  Future<bool> updateData({required String endPoint, required data});
  Future<bool> postByID({required String endPoint, required String id});
}
