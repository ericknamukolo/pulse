import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/features/auth/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn({
    required String email,
    required String pwd,
    required String url,
  }) async {
    emit(AuthLoading());
    try {
      await AuthRepo().signIn(email: email, pwd: pwd, url: url);
      emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
