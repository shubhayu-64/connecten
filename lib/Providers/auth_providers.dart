import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Services/auth_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authServicesProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.read(firebaseAuthProvider));
});

// Stream Provider to trace authentication state of a User
final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authServicesProvider).authStateChanges;
});

// Get the current User
final authUserProvider = Provider<User>((ref) {
  return AuthenticationService(ref.read(firebaseAuthProvider)).authUser!;
});
