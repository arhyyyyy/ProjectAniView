import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/viewmodels/login_viewmodel.dart';
import '../../themes/colors.dart';
import '../pages/home_screen.dart';
import 'forget_pw.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Scaffold(
      body: Container(
        color: AppColors.bluePastel,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: 220,
                        height: 220,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "AniView",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navy,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Login to continue",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.black.withValues(alpha: .7),
                        ),
                      ),
                      const SizedBox(height: 28),

                      /// email
                      TextField(
                        controller: emailCtrl,
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor:
                              AppColors.bluePastel.withValues(alpha: .8),
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.bluePrimary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// password
                      TextField(
                        controller: passCtrl,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor:
                              AppColors.bluePastel.withValues(alpha: .8),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.bluePrimary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgetPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: AppColors.bluePrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// LOGIN BUTTON MVVM
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bluePrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 2,
                          ),
                          onPressed: vm.isLoading
                              ? null
                              : () async {
                                  final msg = await vm.login(
                                    emailCtrl.text,
                                    passCtrl.text,
                                  );

                                  if (msg != null) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(msg,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  Navigator.pushReplacement(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomeScreen(),
                                    ),
                                  );
                                },
                          child: vm.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: AppColors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
