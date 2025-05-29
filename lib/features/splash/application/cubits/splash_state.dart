final class SplashState {
  final bool isSuccess;
  final bool isLoading;
  final bool isSignedIn;

  const SplashState({
    this.isSuccess = false,
    this.isLoading = false,
    this.isSignedIn = false,
  });

  SplashState copyWith({bool? isSuccess, bool? isLoading, bool? isSignedIn}) {
    return SplashState(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }

  @override
  String toString() {
    return '''SplashState(
      isSuccess: $isSuccess, 
      isLoading: $isLoading, 
      isSignedIn: $isSignedIn
    )''';
  }
}
