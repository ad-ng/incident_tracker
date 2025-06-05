import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_tracker/features/auth/data/models/user_model.dart';
import 'package:incident_tracker/features/auth/domain/repository/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthCubit(this._authRepo) : super(AuthInitial());

  Future login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await _authRepo.login(email, password);
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel response;
  AuthSuccess(this.response);
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}
