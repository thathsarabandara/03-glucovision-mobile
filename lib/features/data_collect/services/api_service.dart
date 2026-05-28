import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class DataCollectApiService {
  static const String _baseUrl = 'http://192.168.1.1:8000';
  final Dio _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<Map<String, dynamic>?> uploadData({
    required File imageFile,
    required String arData,
    required String metadata,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
        'ar_data': MultipartFile.fromString(arData, filename: 'ar_data.json'),
        'metadata': metadata,
      });

      Response response = await _dio.post('/upload', data: formData);
      return response.data;
    } catch (e) {
      print('Error uploading data: $e');
      return null;
    }
  }

  Future<List<dynamic>?> getRecords() async {
    try {
      Response response = await _dio.get('/records');
      return response.data;
    } catch (e) {
      print('Error getting records: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> createRecord(Map<String, dynamic> record) async {
    try {
      Response response = await _dio.post('/records', data: record);
      return response.data;
    } catch (e) {
      print('Error creating record: $e');
      return null;
    }
  }
}
