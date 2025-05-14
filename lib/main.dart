import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'features/onboarding/presentation/welcome_page.dart';
import 'features/auth/presentation/forgot_password_page.dart';
import 'features/auth/presentation/otp_verification_page.dart';
import 'features/auth/presentation/reset_password_page.dart';
import 'features/auth/presentation/reset_success_page.dart';
import 'features/auth/presentation/signup_page.dart';
import 'features/auth/presentation/signin_page.dart';
import 'features/home/presentation/home_page.dart';
import 'features/dashboard/presentation/emotion_dashboard_page.dart';
import 'features/profile/presentation/profile_page.dart';
import 'features/settings/settings_page.dart';   

import 'main_navigation.dart'; 
import 'features/auth/data/auth_repository.dart';  // Add this import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Check if user is already authenticated
  bool get isUserAuthenticated => AuthRepository().currentUser != null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mochi AI',
      debugShowCheckedModeBanner: false,
      initialRoute: isUserAuthenticated ? '/home' : '/',
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
        '/main': (_) => const MainNavigation(),
        '/profile': (_) => const ProfilePage(), // Create this page
        '/settings': (_) => const SettingsPage(), // Create this page
      },
    );
  }
}