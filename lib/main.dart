import 'package:flutter/material.dart';
import 'features/onboarding/presentation/welcome_page.dart';
import 'features/auth/presentation/forgot_password_page.dart';
import 'features/auth/presentation/otp_verification_page.dart';
import 'features/auth/presentation/reset_password_page.dart';
import 'features/auth/presentation/reset_success_page.dart';

import 'features/auth/presentation/signup_page.dart';
import 'features/auth/presentation/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mochi AI',
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      routes: {
        '/forgot-password': (_) => const ForgotPasswordPage(),
        '/otp': (_) => const OTPVerificationPage(),
        '/reset-password': (_) => const ResetPasswordPage(),
        '/reset-success': (_) => const ResetSuccessPage(),
        '/log-in': (_) => const SigninPage(),
        '/sign-up': (_) => const SignupPage(),


      },
    );
  }
}
