import 'package:flutter_dotenv/flutter_dotenv.dart';

final bool isProduction = dotenv.env['IS_PRODUCTION'] == 'true';
final String ipconfig = dotenv.env['IPCONFIG']!;
final String baseUrlDev = "http://$ipconfig:8000";
const String baseUrlProduction = "https://nha-gia-re-server.onrender.com";
final String apiDevUrl = "$baseUrlDev/api/v1";
const String apiProductionUrl = "$baseUrlProduction/api/v1";
final String baseAppUrl = isProduction ? baseUrlProduction : baseUrlDev;
final String apiAppUrl = isProduction ? apiProductionUrl : apiDevUrl;

const String kGetMe = '/users/profile';
const String kSignIn = '/auth/sign-in';
const String kSignUp = '/auth/sign-up';
const String kChangePassword = '/auth/change-password';
const String kSignOut = '/auth/sign-out';
const String kSignOutAll = '/auth/sign-out-all';
const String kActiveAccount = '/auth/active-account';
const String kResendActivationCode = '/auth/resend-activation-code';
const String kRefreshToken = '/auth/refresh-token';

const String kGetPostEndpoint = '/posts';
const String kCreatePostEndpoint = '/posts/create';
const String kGetSuggestKeywordsEndpoint =
    'https://gateway.chotot.com/v2/public/search-suggestion/search?keywords=KEY_WORD&site_id=3';
const String kGetLimitPostEndpoint = '/posts/check-limit-post';

const String kGetMembershipPackageEndpoint = '/membership-package';
const String kGetTransactionEndpoint = '/membership-package/transactions';
const String kCreateOrderEndpoint = '/membership-package/check-out';
const String kGetCurrentSubscriptionEndpoint =
    '/membership-package/current-subscription';
const String kUnsubscribeEndpoint = '/membership-package/unsubscribe';
const String kGetBlogEndpoint = '/blogs';

const String kPostImages = '/media/upload';

const String kGetOrCreateConversation = '/conversations/user/:id';

const kGetFollowersAndFollowingsCountEndpoint = '/users/follows';
const kFollowUserEndpoint = '/users/follow/:id';
const kGetDiscountCodeEndpoint = '/membership-package/discounts';
const kGetPostFavoriteEndpoint = '/posts/favorites';
