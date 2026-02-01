import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page,initial: true),
    AutoRoute(page: HomeRoute.page, path: Paths.home),
    AutoRoute(page: TransactionHistoryRoute.page, path: Paths.transactionHistory),
    AutoRoute(page: ReceivingSprayRoute.page, path: Paths.receivingSpray),
    AutoRoute(page: EnterSprayCodeRoute.page, path: Paths.enterSprayCode),
    AutoRoute(page: GetSprayedRoute.page, path: Paths.getSprayed),
    AutoRoute(page: LoginRoute.page, path: Paths.login),
    AutoRoute(page: OnboardingRoute.page, path: Paths.onboarding),
    AutoRoute(page: SetupDenominationsRoute.page, path: Paths.setupDenomination),
    AutoRoute(page: SpraySessionCompleteRoute.page, path: Paths.spraySessionComplete),
    AutoRoute(page: SpraySomeoneRoute.page, path: Paths.spraySomeone),
    AutoRoute(page: SprayerSessionRoute.page, path: Paths.sprayerSession),
  ];
}

class Paths {
  static const String home = "/home";
  static const String transactionHistory = "/transaction-history";
  static const String receivingSpray = "/receive-spray";
  static const String enterSprayCode = "/enter-spray-code";
  static const String getSprayed = "/get-sprayed";
  static const String login  = "/login";
  static const String onboarding = "/onboarding";
  static const String setupDenomination = "/setup-denomination";
  static const String spraySessionComplete = "/spray-session-complete";
  static const String spraySomeone = "/spray-someone";
  static const String sprayerSession = "/sprayer-session";
}