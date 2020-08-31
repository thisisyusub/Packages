part of authenticator;

enum AuthStatus {
  authenticated,
  unauthenticated,
  initial,
  progress,
  failure,
}

class AuthState extends Equatable {
  const AuthState._({this.authStatus = AuthStatus.initial});

  const AuthState.initial() : this._();

  const AuthState.authenticated()
      : this._(authStatus: AuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(authStatus: AuthStatus.unauthenticated);

  const AuthState.progress() : this._(authStatus: AuthStatus.progress);

  const AuthState.failure() : this._(authStatus: AuthStatus.failure);

  final AuthStatus authStatus;

  @override
  List<Object> get props => [authStatus];
}
