import 'package:go_router/go_router.dart';

import 'package:memory_notes/app/routers.dart';
import 'package:memory_notes/core/ui/coming_soon_screen.dart';
import 'package:memory_notes/features/background_music/view/background_music_screen.dart';
import 'package:memory_notes/features/been_together/view/been_together_screen.dart';
import 'package:memory_notes/features/splash/view/splash_screen.dart';

import '../features/faq_tips/view/faq_tips_screen.dart';
import '../features/premium/view/premium_screen.dart';
import '../features/settings/view/settings_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.beenTogether,
      builder: (context, state) => const BeenTogetherScreen(),
    ),
    GoRoute(
      path: Routes.backgroundMusic,
      builder: (context, state) => const BackgroundMusicScreen(),
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: Routes.faqTipsScreen,
      builder: (context, state) => const FaqTipsScreen(),
    ),
    GoRoute(
      path: Routes.premiumScreen,
      builder: (context, state) => const PremiumScreen(),
    ),
    GoRoute(
      path: Routes.comingSoon,
      builder: (context, state) => const ComingSoonScreen(),
    ),
  ],
);
