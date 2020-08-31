part of authenticator;

/// base class that should be implemented to follow guidelines
/// [AuthCubit] use this type of repository to handle
/// authentication process
abstract class BaseAuthRepository {
  /// handles [registration] of user
  Future<bool> registerUser(String email, String password, [String username]);

  /// handles [signIn] of user
  Future<bool> signIn(String email, String password);

  /// checks if the user is [authenticated] or not
  Future<bool> isUserAuthenticated();

  /// [sign out] current user
  void signOut();
}
