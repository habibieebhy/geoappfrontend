import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      // baseUrl: 'http://10.0.2.2:8000',
      baseUrl: 'https://geoappbackend.brixtahomeserver.site/',
    ),
  );

  Future<List<dynamic>> getSites() async {
    final response = await dio.get('/sites');
    return response.data['data'];
  }

  Future<dynamic> createSite(
    Map<String, dynamic> body,
  ) async {
    final response = await dio.post(
      '/sites',
      data: body,
    );

    return response.data;
  }

  Future<dynamic> updateSite(
    int id,
    Map<String, dynamic> body,
  ) async {
    final response = await dio.put(
      '/sites/$id',
      data: body,
    );

    return response.data;
  }

  Future<dynamic> deleteSite(int id) async {
    final response = await dio.delete(
      '/sites/$id',
    );

    return response.data;
  }

  Future<String?> uploadPhoto(String path) async {

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path),
    });

    final response = await dio.post(
      '/api/supabase/photo-upload',
      data: formData,
    );

    return response.data['publicUrl'];
  }
}