import 'package:bitvest/features/home/presentation/views/widgets/terms_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../onboarding/presentation/views/welcome_screen.dart';
import '../../../../profile/presentation/controller/profile_controller.dart';
import '../../../../profile/presentation/views/profile_view.dart';
import '../../../../settings/presentation/views/settings.dart';
import '../../../../wallet/presentation/views/widgets/transaction_history_screen.dart';
import 'PrivacyPolicyScreen.dart';
import 'help_screen.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Drawer(
      child: Container(
        color: kBackgroundColor,
        child: Column(
          children: [
            // 🔷 Header
            Obx(() {
              if (controller.isLoading.value) {
                return Skeletonizer(
                  enabled: true,
                  child: _buildUserHeaderPlaceholder(),
                );
              } else if (controller.profile.value != null) {
                return _buildUserHeader(
                  controller.profile.value!.name ?? '',
                  controller.profile.value!.email ?? '',
                  controller.profile.value?.profilePicture?.url,
                );
              } else {
                return _buildUserHeader("No Name", "No Email", null);
              }
            }),

            // 🔷 Options
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerTile(
                    icon: Icons.person,
                    label: "Edit Profile",
                    onTap: () => Get.to(ProfileView()),
                  ),
                  _buildDrawerTile(
                    icon: Icons.attach_money,
                    label: "Transaction History",
                    onTap: () => Get.to(TransactionHistoryScreen()),
                  ),
                  _buildDrawerTile(
                    icon: Icons.settings,
                    label: "Settings",
                    onTap: () => Get.to(SettingsScreen()),
                  ),
                  _buildDrawerTile(
                    icon: Icons.help_outline,
                    label: "Help",
                    onTap: () => Get.to(HelpScreen()),
                  ),
                  _buildDrawerTile(
                    icon: Icons.privacy_tip,
                    label: "Privacy Policy",
                    onTap: () => Get.to(PrivacyPolicyScreen()),
                  ),
                  _buildDrawerTile(
                    icon: Icons.rule,
                    label: "Terms & Conditions",
                    onTap: () => Get.to(const TermsConditionsScreen()),
                  ),

                  const Divider(color: Colors.white54),
                  _buildDrawerTile(
                    icon: Icons.exit_to_app,
                    label: "Logout",
                    iconColor: Colors.red,
                    onTap: () async {
                      bool? confirmLogout = await Get.dialog<bool>(
                        AlertDialog(
                          backgroundColor: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                              SizedBox(width: 8),
                              Text(
                                'Logout',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          content: Text(
                            "Are you sure you want to log out?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(result: false),
                              child: Text("No", style: TextStyle(color: Colors.grey)),
                            ),
                            ElevatedButton(
                              onPressed: () => Get.back(result: true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text("Yes", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        barrierDismissible: false,
                      );

                      if (confirmLogout == true) {
                        await sl<StorageService>().logOut();
                        Get.offAll(WelcomeScreen());
                      }
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🟡 User Header
  Widget _buildUserHeader(String name, String email, String? imageUrl) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: Colors.transparent),
      accountName: Text(
        name,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      accountEmail: Text(
        email,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        backgroundImage: imageUrl != null && imageUrl.isNotEmpty
            ? NetworkImage(imageUrl)
            : null,
        child: imageUrl == null
            ? const Icon(Icons.account_circle, size: 50, color: Colors.grey)
            : null,
      ),
    );
  }

  // 🟡 Placeholder While Loading
  Widget _buildUserHeaderPlaceholder() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: Colors.transparent),
      accountName: Container(width: 120, height: 20, color: Colors.white),
      accountEmail: Container(width: 180, height: 16, color: Colors.white),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.account_circle, size: 50.0),
      ),
    );
  }

  // 🔷 Drawer Tile
  Widget _buildDrawerTile({
    required IconData icon,
    required String label,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
