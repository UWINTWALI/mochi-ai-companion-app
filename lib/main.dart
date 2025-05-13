import 'package:flutter/material.dart';
import 'features/onboarding/presentation/welcome_page.dart';
import 'features/auth/presentation/forgot_password_page.dart';
import 'features/auth/presentation/otp_verification_page.dart';
import 'features/auth/presentation/reset_password_page.dart';
import 'features/auth/presentation/reset_success_page.dart';
import 'features/auth/presentation/signup_page.dart';
import 'features/auth/presentation/signin_page.dart';
import 'features/home/presentation/home_page.dart';
import 'features/dashboard/presentation/emotion_dashboard_page.dart';
import 'main_navigation.dart'; // ⬅️ New import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool get isUserAuthenticated => false; // TODO: Replace with auth check

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mochi AI',
      debugShowCheckedModeBanner: false,
      initialRoute: isUserAuthenticated ? '/main' : '/',
      routes: {
        '/': (_) => const WelcomePage(),
        '/forgot-password': (_) => const ForgotPasswordPage(),
        '/otp': (_) => const OTPVerificationPage(),
        '/reset-password': (_) => const ResetPasswordPage(),
        '/reset-success': (_) => const ResetSuccessPage(),
        '/log-in': (_) => const SigninPage(),
        '/sign-up': (_) => const SignupPage(),
        '/home': (_) => const HomePage(), // optional if still needed directly
        '/dashboard': (_) => const EmotionDashboardPage(), // same
        '/main': (_) => const MainNavigation(), // ⬅️ New route
      },
    );
  }
}
