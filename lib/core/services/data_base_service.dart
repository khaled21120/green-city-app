abstract class DatabaseService {
  Future<void> sendData({
    required String endPoint,
    required Map<String, dynamic> data,
    String? uId,
  });
  Future<Map<String, dynamic>> fetchMapData({
    required String endPoint,
    String? uId,
  });
  Future<List<dynamic>> fetchListData({required String endPoint, String? uId});
  Future<bool> checkIfUserExist({required String endPoint, String? uId});
  Future<void> deleteData({required String endPoint, String? uId});
  Future<bool> updateData({
    required String endPoint,
    required Map<String, dynamic> data,
    String? uId,
  });
}
