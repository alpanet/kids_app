import 'package:auto_route/auto_route.dart';
import 'package:kids_app/ui/router/auth_guard.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|App,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true, children: [
      AutoRoute(page: Login.page, path: "login"),
      AutoRoute(page: OnboardingRoute.page, path: "onboarding"),
      AutoRoute(page: RegisterGathering.page, path: "register"),
      AutoRoute(page: RegisterOtp.page, path: "registerOtp/:phoneNumber"),
      AutoRoute(page: MainPage.page, path: "mainpage", initial: true , guards: [AuthGuard()]),
      AutoRoute(page: WatchlistPage.page, path: "watchlistPage", guards: [AuthGuard()]),
      AutoRoute(page: WatchNewPage.page, path: "watchNewPage", guards: [AuthGuard()]),
      AutoRoute(page: CategoryMainPage.page, path: "categoryMainPage", guards: [AuthGuard()]),
      AutoRoute(page: CategoryNewCategoryPage.page, path: "categoryNewCategoryPage", guards: [AuthGuard()]),
      AutoRoute(page: SettingsPage.page, path: "settingsPage", guards: [AuthGuard()]),
    ]),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
