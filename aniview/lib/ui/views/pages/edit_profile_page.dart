import 'package:aniview/data/models/user_model.dart';
import 'package:aniview/di/locator.dart';
import 'package:aniview/ui/viewmodels/edit_profile_viewmodel.dart';
import 'package:aniview/ui/viewmodels/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aniview/ui/themes/colors.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel data;

  const EditProfilePage({super.key, required this.data});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameC;
  late TextEditingController bioC;

  @override
  void initState() {
    super.initState();
    nameC = TextEditingController(text: widget.data.name);
    bioC = TextEditingController(text: widget.data.bio);
  }

  @override
  Widget build(BuildContext context) {
    /// AMBIL ProfileViewModel GLOBAL
    final profileVM = context.read<ProfileViewModel>();

    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(
        locator(),      // ProfileRepository
        profileVM,      // ProfileViewModel GLOBAL
      ),
      child: Consumer<EditProfileViewModel>(
        builder: (context, vm, _) => Scaffold(
          appBar: AppBar(
            foregroundColor: AppColors.navy,
            elevation: 0,
            backgroundColor: AppColors.bluePastel,
            title: const Text("Edit Profile"),
          ),
          backgroundColor: AppColors.bluePastel,
          body: _buildForm(vm),
        ),
      ),
    );
  }

  Widget _buildForm(EditProfileViewModel vm) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _inputField("Name", nameC),
          const SizedBox(height: 20),
          _inputField("Bio", bioC, maxLines: 3),

          const Spacer(),

          vm.state == EditState.loading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bluePrimary,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => _save(vm),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _inputField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
        ),
      ),
    );
  }

  Future<void> _save(EditProfileViewModel vm) async {
    final uid = widget.data.uid;

    await vm.updateProfile(uid, {
      "name": nameC.text.trim(),
      "bio": bioC.text.trim(),
    });

    if (vm.state == EditState.success) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else if (vm.state == EditState.error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${vm.errorMessage}")),
      );
    }
  }
}
