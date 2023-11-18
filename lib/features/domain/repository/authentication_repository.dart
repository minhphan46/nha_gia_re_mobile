import '../../../../core/resources/data_state.dart';

abstract class AuthenticationRepository {
  // API remote
  Future<DataState<void>> signIn(String email, String password);
  Future<DataState<void>> signOut();
  Future<DataState<String>> signUp(
      String email, String password, String confirmPassword);

  // Local
  Future<DataState<bool>> checkActiveToken();
  Future<DataState<bool>> checkRefreshToken();
  Future<DataState<void>> refreshNewAccessToken();
}
