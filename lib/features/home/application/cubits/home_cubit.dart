import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yingxin/features/auth/infrastructure/auth_repository.dart';
import 'package:yingxin/features/home/application/cubits/home_state.dart';
import 'package:yingxin/features/home/domain/home_failure.dart';

class HomeCubit extends Cubit<HomeState> {
  static const String className = 'HomeCubit';

  final AuthRepository _authRepository;

  HomeCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(HomeState()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(isLoading: true));

    final userId = await _authRepository.getUserId();
    if (userId == null) {
      return await signOut();
    }

    return emit(state.copyWith(userId: userId, isLoading: false));
  }

  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));
    await _authRepository.signOut();
    emit(
      state.copyWith(
        isLoading: false,
        failure: HomeFailure(type: HomeFailureType.userNotFound),
      ),
    );
  }

  @override
  Future<void> close() {
    log('close', name: className);
    return super.close();
  }
}
