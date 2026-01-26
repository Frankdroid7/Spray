import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: TransactionHistoryRoute.page),
    AutoRoute(page: ReceivingSprayRoute.page),
    AutoRoute(page: EnterSprayCodeRoute.page),
    AutoRoute(page: GetSprayedRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: SetupDenominationsRoute.page),
    AutoRoute(page: SplashRoute.page),
    AutoRoute(page: SpraySessionCompleteRoute.page),
    AutoRoute(page: SpraySomeoneRoute.page),
    AutoRoute(page: SprayerSessionRoute.page),
  ];
}
