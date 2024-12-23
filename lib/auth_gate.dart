import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class AuthGate extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(authProvider);

    return userAsyncValue.when(
      data: (user) {
        if (user == null) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
          );
        } else {
          return HomeScreen();
        }
      },
      loading: () => CircularProgressIndicator(),
      error: (e, trace) => Center(child: Text('Error: $e')),
    );
  }
}
