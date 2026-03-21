import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/features/authentication/data/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final signInWithGoogleProvider = FutureProvider.autoDispose<UserCredential?>((ref) async {
  return ref.read(authServiceProvider).signInWithGoogle();
});
