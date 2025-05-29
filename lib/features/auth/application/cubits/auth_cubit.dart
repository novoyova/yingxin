import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuanrung/features/auth/application/cubits/auth_state.dart';
import 'package:yuanrung/features/auth/infrastructure/auth_repository.dart';

final class AuthCubit extends Cubit<AuthState> {
  static const String className = 'AuthCubit';

  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthState());

  Future<void> signIn(String userId) async {
    emit(state.copyWith(isLoading: true));
    await _authRepository.signIn(userId.toLowerCase());
    return emit(state.copyWith(isSuccess: true, isLoading: false));
  }
}
