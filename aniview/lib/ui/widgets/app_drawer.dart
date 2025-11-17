import 'package:aniview/ui/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/colors.dart';
import '../viewmodels/profile_viewmodel.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "About This App",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Nama Aplikasi: AniView"),
              SizedBox(height: 4),
              Text("Versi: 1.0.0"),
              SizedBox(height: 4),
              Text("Developer: Arhy Ken"),
              SizedBox(height: 12),
              Text(
                "Aplikasi dalam tahap pengembangan.\n"
                "BetaTest",
                style: TextStyle(height: 1.3),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Tutup"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileVM, _) {
        if (profileVM.state == ProfileState.loading) {
          return const Drawer(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (profileVM.state == ProfileState.error) {
          return Drawer(
            child: Center(child: Text("Error: ${profileVM.errorMessage}")),
          );
        }
        final user = profileVM.user;
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.bluePastel),
                accountName: Text(
                  user?.name ?? "Unknown User",
                  style: TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  user?.email ?? "-",
                  style: TextStyle(color: AppColors.navy),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: AppColors.navy, size: 40),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info_outline, color: AppColors.navy),
                title: const Text("About App"),
                onTap: () => _showAboutDialog(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await profileVM.logout(); 
                  Navigator.pushAndRemoveUntil(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logout berhasil")),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
