// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:spray/features/authentication/presentation/views/login_screen.dart'
    as _i3;
import 'package:spray/features/authentication/presentation/views/onboarding_screen.dart'
    as _i4;
import 'package:spray/features/authentication/presentation/views/splash_screen.dart'
    as _i7;
import 'package:spray/features/home/presentation/views/home_page.dart' as _i2;
import 'package:spray/features/spray/presentation/views/spray_session_complete.dart'
    as _i8;
import 'package:spray/features/spray/presentation/views/sprayee/get_sprayed.dart'
    as _i1;
import 'package:spray/features/spray/presentation/views/sprayee/receiving_spray.dart'
    as _i5;
import 'package:spray/features/spray/presentation/views/sprayer/scan_qr.dart'
    as _i6;
import 'package:spray/features/spray/presentation/views/sprayer/spray_someone.dart'
    as _i9;
import 'package:spray/features/spray/presentation/views/sprayer/sprayer_session.dart'
    as _i10;
import 'package:spray/features/transactions/presentation/views/transaction_history.dart'
    as _i11;

/// generated route for
/// [_i1.GetSprayedPage]
class GetSprayedRoute extends _i12.PageRouteInfo<void> {
  const GetSprayedRoute({List<_i12.PageRouteInfo>? children})
    : super(GetSprayedRoute.name, initialChildren: children);

  static const String name = 'GetSprayedRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.GetSprayedPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.OnboardingScreen]
class OnboardingRoute extends _i12.PageRouteInfo<void> {
  const OnboardingRoute({List<_i12.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i5.ReceivingSprayPage]
class ReceivingSprayRoute extends _i12.PageRouteInfo<void> {
  const ReceivingSprayRoute({List<_i12.PageRouteInfo>? children})
    : super(ReceivingSprayRoute.name, initialChildren: children);

  static const String name = 'ReceivingSprayRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.ReceivingSprayPage();
    },
  );
}

/// generated route for
/// [_i6.ScanQrPage]
class ScanQrRoute extends _i12.PageRouteInfo<void> {
  const ScanQrRoute({List<_i12.PageRouteInfo>? children})
    : super(ScanQrRoute.name, initialChildren: children);

  static const String name = 'ScanQrRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.ScanQrPage();
    },
  );
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashScreen();
    },
  );
}

/// generated route for
/// [_i8.SpraySessionCompletePage]
class SpraySessionCompleteRoute extends _i12.PageRouteInfo<void> {
  const SpraySessionCompleteRoute({List<_i12.PageRouteInfo>? children})
    : super(SpraySessionCompleteRoute.name, initialChildren: children);

  static const String name = 'SpraySessionCompleteRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.SpraySessionCompletePage();
    },
  );
}

/// generated route for
/// [_i9.SpraySomeonePage]
class SpraySomeoneRoute extends _i12.PageRouteInfo<void> {
  const SpraySomeoneRoute({List<_i12.PageRouteInfo>? children})
    : super(SpraySomeoneRoute.name, initialChildren: children);

  static const String name = 'SpraySomeoneRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.SpraySomeonePage();
    },
  );
}

/// generated route for
/// [_i10.SprayerSessionPage]
class SprayerSessionRoute extends _i12.PageRouteInfo<SprayerSessionRouteArgs> {
  SprayerSessionRoute({
    _i13.Key? key,
    required String receiverId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         SprayerSessionRoute.name,
         args: SprayerSessionRouteArgs(key: key, receiverId: receiverId),
         initialChildren: children,
       );

  static const String name = 'SprayerSessionRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SprayerSessionRouteArgs>();
      return _i10.SprayerSessionPage(
        key: args.key,
        receiverId: args.receiverId,
      );
    },
  );
}

class SprayerSessionRouteArgs {
  const SprayerSessionRouteArgs({this.key, required this.receiverId});

  final _i13.Key? key;

  final String receiverId;

  @override
  String toString() {
    return 'SprayerSessionRouteArgs{key: $key, receiverId: $receiverId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SprayerSessionRouteArgs) return false;
    return key == other.key && receiverId == other.receiverId;
  }

  @override
  int get hashCode => key.hashCode ^ receiverId.hashCode;
}

/// generated route for
/// [_i11.TransactionHistoryPage]
class TransactionHistoryRoute extends _i12.PageRouteInfo<void> {
  const TransactionHistoryRoute({List<_i12.PageRouteInfo>? children})
    : super(TransactionHistoryRoute.name, initialChildren: children);

  static const String name = 'TransactionHistoryRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.TransactionHistoryPage();
    },
  );
}
