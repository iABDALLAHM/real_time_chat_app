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
}
