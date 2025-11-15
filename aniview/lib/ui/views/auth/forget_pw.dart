// lib/ui/views/auth/forget_password_screen.dart
import 'package:aniview/ui/themes/colors.dart';
import 'package:aniview/ui/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.bluePastel,
        ),

        child: Stack(
          children: [
            // === BACK ARROW FIXED DI PALING ATAS ===
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: AppColors.navy, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // === CONTENT SCROLLABLE ===
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 80), // jarak supaya arrow tidak ketiban

                    // Logo + Title
                    Column(
                      children: [
                        Image.asset("assets/logo.png",
                            width: 200, height: 200),
                        const SizedBox(height: 6),
                        const Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navy,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Card Form
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 14,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Reset Password",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.navy,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Enter your email to receive reset link",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.black.withValues(alpha: .7),
                            ),
                          ),

                          const SizedBox(height: 28),

                          TextField(
                            controller: emailCtrl,
                            decoration: InputDecoration(
                              labelText: "Email",
                              filled: true,
                              fillColor:
                                  AppColors.bluePastel.withValues(alpha: .8),
                              prefixIcon: const Icon(Icons.email,
                                  color: AppColors.bluePrimary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.bluePrimary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Reset link sent to email",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen(),
                                    ),
                                  );
                                });
                              },
                              child: const Text(
                                "Send Reset Link",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
