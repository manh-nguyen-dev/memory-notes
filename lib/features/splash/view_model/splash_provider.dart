import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:memory_notes/app/routers.dart';


final splashProvider = StateNotifierProvider<SplashNotifier, bool>((ref) {
  return SplashNotifier();
});

class SplashNotifier extends StateNotifier<bool> {
  SplashNotifier() : super(false);

  Future<void> checkAppState(BuildContext context) async {
    if(!context.mounted) return;

    await Future.delayed(Duration(seconds: 3));
    context.go(Routes.beenTogether);
  }
}

