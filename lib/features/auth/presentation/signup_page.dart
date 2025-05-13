import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/input_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agree = false;
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
              const Text("Join monchi Today!",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Create your account and start vibing with monchi today!"),
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

              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    activeColor: Colors.pinkAccent,
                    onChanged: (val) => setState(() => _agree = val!),
                  ),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "I agree to Monchi's ",
                        children: [
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(
                                color: Colors.pinkAccent, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              CustomButton(
                text: "Sign up",
                onPressed: () {
                  // Handle signup logic
                  Navigator.pushNamed(
                    context,
                    '/log-in'
                  );
                },
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/log-in");
                  },
                  child: const Text("Already have an account? Sign in",
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
