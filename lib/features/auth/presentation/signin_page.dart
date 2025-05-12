import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/input_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text("Welcome Back 👋",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Login to your account and continue connecting hearts."),
              const SizedBox(height: 30),

              InputField(
                controller: _emailController,
                label: "Email",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),

              InputField(
                controller: _passwordController,
                label: "Password",
                icon: Icons.lock_outline,
                obscureText: _obscureText,
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: const Text("Forgot Password?",
                      style: TextStyle(color: Colors.pinkAccent)),
                ),
              ),

              const SizedBox(height: 20),
              CustomButton(
                text: "Sign in",
                onPressed: () {
                  // Handle login logic
                },
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-up");
                  },
                  child: const Text("Don't have an account? Sign up",
                      style: TextStyle(color: Colors.pinkAccent)),
                ),
              ),

              const Divider(height: 32),
              const Center(child: Text("or continue with")),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialIconButton("G"),
                  socialIconButton(""),
                  socialIconButton("f"),
                  socialIconButton("X"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialIconButton(String label) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey.shade200,
      child: Text(label, style: const TextStyle(fontSize: 20, color: Colors.black)),
    );
  }
}
