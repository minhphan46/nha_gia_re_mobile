import 'package:nhagiare_mobile/core/resources/data_state.dart';

import '../../../core/resources/pair.dart';
import '../entities/user/account_verification_requests.dart';
import '../enums/verification_status.dart';

abstract class UserRepository {
  Future<DataState<bool>> followOrUnfollowUser(String userId);
  Future<DataState<Pair<int, int>>> getFollowersAndFollowingsCount(
      String userId);

  Future<DataState<void>> sendVerificationUser(
      AccountVerificationRequestEntity entity);
  Future<DataState<Pair<VerificationStatus, String>>> getVerificationStatus();
}
