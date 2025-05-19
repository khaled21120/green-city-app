abstract class DatabaseService {
  Future<bool> sendData({
    required String endPoint,
    required Map<String, dynamic> data,
  });
  Future<Map<String, dynamic>> fetchMapData({
    required String endPoint,
    String? uId,
  });
  Future<Map<String, dynamic>> fetchUserData({required String endPoint});
  Future<List<dynamic>> fetchListData({required String endPoint, String? uId});
  Future<void> deleteData({required String endPoint});
  Future<bool> updateData({
    required bool isImage,
    required String endPoint,
    required dynamic data,
  });
  Future<bool> postByID({required String endPoint, required String id});
}
