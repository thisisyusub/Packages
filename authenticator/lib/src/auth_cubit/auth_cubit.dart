part of authenticator;

/// handles [Authentication] logic of app
class AuthCubit extends Cubit<AuthState> {
  /// provides instance of [AuthCubit]
  AuthCubit({@required this.baseAuthRepository})
      : assert(baseAuthRepository != null),
        super(const AuthState.initial());

  /// holds [authentication] logic of app
  /// should be implemented by your repositories to inject it
  /// to [AuthCubit]
  final BaseAuthRepository baseAuthRepository;

  /// checks [Authentication Status] of user
  void checkAuth() async {
    try {
      emit(AuthState.progress());
      await Future.delayed(Duration(seconds: 1));

      final userAuthenticated = await baseAuthRepository.isUserAuthenticated();

      emit(userAuthenticated
          ? AuthState.authenticated()
          : AuthState.unauthenticated());
    } on Exception {
      emit(AuthState.failure());
    }
  }

  /// used to call when the [login process] is completed successfully
  void loggedIn() => emit(AuthState.authenticated());

  /// handles [log out] process of current user
  void logOut() {
    baseAuthRepository.signOut();
    emit(AuthState.unauthenticated());
  }
}
