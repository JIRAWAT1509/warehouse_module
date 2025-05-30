import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/app/routes.dart';
import 'package:warehouse_module/viewmodels/auth/auth_view_model.dart';

const Color kLightGreyOffWhite = Color(0xFFF8F9FE);
const Color kDarkGreyAlmostBlack = Color(0xFF212121);
const Color kMediumGrey = Color(0xFF868686);
const Color kPureWhite = Color(0xFFFFFFFF);

class UserProfilePage extends StatelessWidget {
  // Option A: Make it optional with a default value
  final String username;
  const UserProfilePage({super.key, this.username = 'username?'});
  // OR
  // Option B: Just remove it from constructor if it's purely internal dummy
  // final String username = 'username?'; // Define directly here
  // const UserProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    // ... (rest of your build method, using this.username)
    return Scaffold(
      backgroundColor: kLightGreyOffWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kDarkGreyAlmostBlack,
                    ),
                  ),
                  Text(
                    // Use the username from the class
                    '@${this.username}', // Make sure to use 'this.username' if you made it a class member
                    style: TextStyle(
                      fontSize: 18,
                      color: kDarkGreyAlmostBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                height: 1,
                color: Colors.grey[300],
                margin: const EdgeInsets.only(bottom: 30),
              ),
              _buildMenuItem(
                context,
                icon: Icons.person,
                text: 'User information',
                onTap: () {
                  print('User information tapped');
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.lock,
                text: 'Change Password',
                onTap: () {
                  print('Change Password tapped');
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.language,
                text: 'Just in case',
                onTap: () {
                  print('Just in case tapped');
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.logout,
                text: 'Log out',
                onTap: () {
                  Provider.of<AuthViewModel>(context, listen: false).logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Icon(icon, size: 28, color: kMediumGrey),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: kDarkGreyAlmostBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}