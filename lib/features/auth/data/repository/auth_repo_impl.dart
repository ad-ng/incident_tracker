import 'package:incident_tracker/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:incident_tracker/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future login(String email, String password) async {
    return await AuthApiService().login(email, password);
  }
}
