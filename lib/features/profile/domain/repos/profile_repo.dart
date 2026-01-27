abstract class ProfileRepo {
  Future<void> signOut({required String userId});
  Future<void> deleteUser({required String userId});
}
