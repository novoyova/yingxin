import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuanrung/features/auth/infrastructure/auth_repository.dart';
import 'package:yuanrung/features/splash/application/cubits/splash_state.dart';

final class SplashCubit extends Cubit<SplashState> {
  static const String className = 'SplashCubit';

  final AuthRepository _authRepository;

  SplashCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(SplashState()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(Duration(milliseconds: 1500));

    final isSignedIn = await _authRepository.isSignedIn();

    return emit(
      state.copyWith(isSuccess: true, isLoading: false, isSignedIn: isSignedIn),
    );
  }
}
