import 'package:yingxin/features/home/domain/home_failure.dart';

final class HomeState {
  final String userId;
  final bool isLoading;
  final HomeFailure? failure;

  const HomeState({this.userId = '', this.isLoading = false, this.failure});

  HomeState copyWith({String? userId, bool? isLoading, HomeFailure? failure}) {
    return HomeState(
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  @override
  String toString() {
    return '''HomeState(
      userId: $userId, 
      isLoading: $isLoading, 
      failure: $failure
    )''';
  }
}
