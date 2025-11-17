import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aniview/ui/themes/colors.dart';
import 'package:aniview/ui/viewmodels/profile_viewmodel.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      backgroundColor: AppColors.bluePastel,
      appBar: AppBar(
        backgroundColor: AppColors.bluePastel,
        elevation: 0,
        foregroundColor: AppColors.navy,
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(vm),
    );
  }

  Widget _buildBody(ProfileViewModel vm) {
    switch (vm.state) {
      case ProfileState.loading:
        return const Center(child: CircularProgressIndicator());
      case ProfileState.error:
        return Center(child: Text("Error: ${vm.errorMessage}"));
      case ProfileState.idle:
        if (vm.user == null) {
          return const Center(child: Text("No profile data"));
        }
        return _modernProfileLayout(vm.user!);
    }
  }

  // ignore: strict_top_level_inference
  Widget _modernProfileLayout(user) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _headerSection(user),
            const SizedBox(height: 28),
            _infoSection(user),
          ],
        ),
      ),
    );
  }

  // ignore: strict_top_level_inference
  Widget _headerSection(user) {
    return Stack(
      children: [
        Container(
          height: 240,
          decoration: BoxDecoration(
            color: AppColors.bluePrimary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.navy,
                  child: Text(
                    user.name[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ignore: strict_top_level_inference
  Widget _infoSection(user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Profile Information",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 20),
        _infoCard("Username", user.name),
        const SizedBox(height: 16),
        _infoCard("Bio", user.bio),

        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.bluePrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(data: user),
                ),
              );
            },
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.navy.withValues(alpha: .6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value.isNotEmpty ? value : "-",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
        ],
      ),
    );
  }
}
