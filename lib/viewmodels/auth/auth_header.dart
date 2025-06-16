import 'package:flutter/material.dart';
import 'package:warehouse_module/app/routes.dart';

class AuthHeader extends StatelessWidget {
  final bool isLogin;

  const AuthHeader({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (!isLogin) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log in',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: isLogin ? FontWeight.bold : FontWeight.normal,
                  color: isLogin ? Colors.black : Colors.grey[400],
                ),
              ),
              if (isLogin)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 2,
                  width: 60,
                  color: Colors.black,
                ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            if (isLogin) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.signup);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: !isLogin ? FontWeight.bold : FontWeight.normal,
                  color: !isLogin ? Colors.black : Colors.grey[400],
                ),
              ),
              if (!isLogin)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 2,
                  width: 60,
                  color: Colors.black,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
