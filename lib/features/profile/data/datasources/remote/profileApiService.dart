import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:incident_tracker/conf/dio/dioservice.dart';

class ProfileApiService {
  final Dio _dio = DioService.instance.dio;

  Future<Uint8List?> fetchProtectedImage() async {
    try {
      final response = await _dio.get<List<int>>(
        '/uploads//users/profilePicture-1748607340320-742478406.jpg',
        options: Options(responseType: ResponseType.bytes),
      );
      return Uint8List.fromList(response.data!);
    } catch (e) {
      print("Image load error: $e");
      return null;
    }
  }
}
