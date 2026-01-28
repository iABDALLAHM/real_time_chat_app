abstract class AuthService {
  Future<void> register({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signInWithEmailAndPassword({
    required String password,
    required String email,
  });
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signOut();
  Future<void> deleteAccount();
  Future<void> updatePassword({required String newPassword});
}
