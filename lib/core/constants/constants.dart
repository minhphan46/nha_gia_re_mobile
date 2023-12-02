const String baseUrl = "http://192.168.9.218:8000";
const String apiDevUrl = "$baseUrl/api/v1";
const String apiProductionUrl = "https://nha-gia-re-server.onrender.com/api/v1";
const String apiUrl = apiDevUrl;

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

const String kGetMembershipPackageEndpoint = '/membership-package';
const String kGetTransactionEndpoint = '/membership-package/transactions';
const String kCreateOrderEndpoint = '/membership-package/check-out';
const String kGetBlogEndpoint = '/blogs';

const String kPostImages = '/media/upload';

const String kGetOrCreateConversation = '/conversations';
const String kGetCurrentSubscriptionEndpoint = '/membership-package/current';
