final class AuthState {
  final bool isSuccess;
  final bool isLoading;

  const AuthState({this.isSuccess = false, this.isLoading = false});

  AuthState copyWith({bool? isSuccess, bool? isLoading}) {
    return AuthState(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return '''AuthState(
      isSuccess: $isSuccess, 
      isLoading: $isLoading
    )''';
  }
}
