// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:kids_app/ui/apps/main_screen.dart' as _i4;
import 'package:kids_app/ui/apps/splash_app.dart' as _i8;
import 'package:kids_app/ui/screens/category/category_main_page.dart' as _i1;
import 'package:kids_app/ui/screens/category/category_new_category_page.dart'
    as _i2;
import 'package:kids_app/ui/screens/main/main_page.dart' as _i3;
import 'package:kids_app/ui/screens/onboarding/onboardingScreen.dart' as _i5;
import 'package:kids_app/ui/screens/register/register_gathering.dart' as _i6;
import 'package:kids_app/ui/screens/register/register_otp.dart' as _i7;
import 'package:kids_app/ui/screens/watchList/watch_new_page.dart' as _i9;
import 'package:kids_app/ui/screens/watchList/watchlist_page.dart' as _i10;
import 'package:kids_app/ui/screens/settings/settings.dart' as _i12;
import 'package:kids_app/ui/screens/login/login.dart' as _i13;

/// generated route for
/// [_i1.CategoryMainPage]
class CategoryMainPage extends _i11.PageRouteInfo<void> {
  const CategoryMainPage({List<_i11.PageRouteInfo>? children})
      : super(
          CategoryMainPage.name,
          initialChildren: children,
        );

  static const String name = 'CategoryMainPage';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.CategoryMainPage();
    },
  );
}

/// generated route for
/// [_i2.CategoryNewCategoryPage]
class CategoryNewCategoryPage extends _i11.PageRouteInfo<void> {
  const CategoryNewCategoryPage({List<_i11.PageRouteInfo>? children})
      : super(
          CategoryNewCategoryPage.name,
          initialChildren: children,
        );

  static const String name = 'CategoryNewCategoryPage';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.CategoryNewCategoryPage();
    },
  );
}

/// generated route for
/// [_i3.MainPage]
class MainPage extends _i11.PageRouteInfo<void> {
  const MainPage({List<_i11.PageRouteInfo>? children})
      : super(
          MainPage.name,
          initialChildren: children,
        );

  static const String name = 'MainPage';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainPage();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.OnboardingScreen]
class OnboardingRoute extends _i11.PageRouteInfo<void> {
  const OnboardingRoute({List<_i11.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i6.RegisterGathering]
class RegisterGathering extends _i11.PageRouteInfo<void> {
  const RegisterGathering({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterGathering.name,
          initialChildren: children,
        );

  static const String name = 'RegisterGathering';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.RegisterGathering();
    },
  );
}

/// generated route for
/// [_i7.RegisterOtp]
class RegisterOtp extends _i11.PageRouteInfo<void> {
  const RegisterOtp({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterOtp.name,
          initialChildren: children,
        );

  static const String name = 'RegisterOtp';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i7.RegisterOtp(
          phoneNumber: data.pathParams.getString('phoneNumber'),
          is_login: data.queryParams.getBool('is_login'));
    },
  );
}

/// generated route for
/// [_i8.SplashApp]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashApp();
    },
  );
}

/// generated route for
/// [_i9.WatchNewPage]
class WatchNewPage extends _i11.PageRouteInfo<void> {
  const WatchNewPage({List<_i11.PageRouteInfo>? children})
      : super(
          WatchNewPage.name,
          initialChildren: children,
        );

  static const String name = 'WatchNewPage';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.WatchNewPage();
    },
  );
}

/// generated route for
/// [_i10.WatchlistPage]
class WatchlistPage extends _i11.PageRouteInfo<void> {
  const WatchlistPage({List<_i11.PageRouteInfo>? children})
      : super(
          WatchlistPage.name,
          initialChildren: children,
        );

  static const String name = 'WatchlistPage';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.WatchlistPage();
    },
  );
}

/// generated route for
/// [_i12.SettingsPage]
class SettingsPage extends _i11.PageRouteInfo<void> {
  const SettingsPage({List<_i11.PageRouteInfo>? children})
      : super(
          SettingsPage.name,
          initialChildren: children,
        );

  static const String name = 'SettingsPage';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingsPage();
    },
  );
}

/// generated route for
/// [_i13.Login]
class Login extends _i11.PageRouteInfo<void> {
  const Login({List<_i11.PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i13.Login();
    },
  );
}
