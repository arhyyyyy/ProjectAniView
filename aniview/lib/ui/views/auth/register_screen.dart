import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/themes/colors.dart';
import '../../../ui/viewmodels/register_viewmodel.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RegisterViewModel>();

    final nameCtrl = TextEditingController();
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
                // HEADER
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Image.asset("assets/logo.png", width: 200, height: 200),
                      const SizedBox(height: 6),
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navy,
                        ),
                      ),
                    ],
                  ),
                ),

                // FORM CONTAINER
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
                        "Register",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // NAME
                      TextField(
                        controller: nameCtrl,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          filled: true,
                          fillColor: AppColors.bluePastel.withValues(alpha: .8),
                          prefixIcon: Icon(Icons.person, color: AppColors.bluePrimary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // EMAIL
                      TextField(
                        controller: emailCtrl,
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: AppColors.bluePastel.withValues(alpha: .8),
                          prefixIcon: Icon(Icons.email, color: AppColors.bluePrimary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // PASSWORD
                      TextField(
                        controller: passCtrl,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: AppColors.bluePastel.withValues(alpha: .8),
                          prefixIcon: Icon(Icons.lock, color: AppColors.bluePrimary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // BUTTON REGISTER
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bluePrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: vm.isLoading
                              ? null
                              : () async {
                                  bool ok = await vm.register(
                                    nameCtrl.text,
                                    emailCtrl.text,
                                    passCtrl.text,
                                  );

                                  if (ok) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Registration successful!"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const LoginScreen()),
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(vm.errorMessage ?? "Error occurred"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                          child: vm.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  "Register",
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
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
