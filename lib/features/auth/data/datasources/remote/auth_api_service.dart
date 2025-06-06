import 'package:dio/dio.dart';
import 'package:incident_tracker/conf/dio/dioservice.dart';
import 'package:incident_tracker/features/auth/data/datasources/local/tokenStore.dart';
import 'package:incident_tracker/features/auth/data/datasources/local/userPreference.dart';
import 'package:incident_tracker/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    try {
      final response = await _dio.post(
        '/users/login',
        data: {"email": email, "password": password},
      );
      final dataJson = response.data['user'];

      TokenStore.setToken(response.data['token']);

      await UserPreferences().saveLocalUser(UserModel.fromMap(dataJson));

      // Return the UserModel instance
      return UserModel.fromMap(dataJson);
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return Future.error('Something went wrong: $e');
    }
  }
}
