import 'package:warehouse_module/viewmodels/auth/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/app/routes.dart';
import 'package:warehouse_module/viewmodels/auth/auth_view_model.dart';

// LoginPage widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;
  bool _isPasswordError = false;
  String _countryCode = '+66';
  bool _isEmailValid = false;
  bool _isPhoneValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    // --- FOR FRONTEND TESTING ONLY ---
    // Simulate success and navigate directly
    await Future.delayed(const Duration(milliseconds: 500)); // Short delay for visual effect
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainHome, (route) => false);
    // --- END FRONTEND TESTING CODE ---

    // Original login logic (commented out for testing)
    /*
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final email = _emailController.text;
    final phoneNumber = _phoneController.text;
    final password = _passwordController.text;

    if (password.isEmpty) {
      setState(() { _isPasswordError = true; _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password cannot be empty')));
      return;
    }

    bool success = await authViewModel.login(email.isNotEmpty ? email : (_countryCode + phoneNumber), password);

    if (!mounted) return;

    setState(() { _isLoading = false; });

    if (success) {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainHome, (route) => false);
    } else {
      setState(() { _isPasswordError = true; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid credentials or wrong password')));
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 40),
              _buildEmailInputField(),
              const SizedBox(height: 20),
              _buildDividerWithOr(),
              const SizedBox(height: 20),
              _buildPhoneInputField(),
              const SizedBox(height: 20),
              _buildPasswordInputField(),
              const SizedBox(height: 30),
              _buildLoginButton(context),
              _buildSignUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
  return const AuthHeader(isLogin: true);
}


  Widget _buildEmailInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Email',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        _buildTextInputField(
          controller: _emailController,
          hintText: 'Test@gmail.com',
          keyboardType: TextInputType.emailAddress,
          suffixIcon: _isEmailValid ? const Icon(Icons.check, color: Colors.green) : null,
          onChanged: (value) {
            setState(() {
              _isEmailValid = value.contains('@') && value.length > 5;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDividerWithOr() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Or',
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildPhoneInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Phone number',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        _buildPhoneTextField(
          controller: _phoneController,
          countryCode: _countryCode,
          onCountryCodeChanged: (newCode) {
            setState(() {
              _countryCode = newCode;
            });
          },
          suffixIcon: _isPhoneValid ? const Icon(Icons.check, color: Colors.green) : null,
          onChanged: (value) {
            setState(() {
              _isPhoneValid = value.length > 8;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPasswordInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        _buildPasswordTextField(
          controller: _passwordController,
          isError: _isPasswordError,
          obscureText: _obscureText,
          onToggleVisibility: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        if (_isPasswordError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4.0),
            child: Text(
              'Wrong password',
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // For frontend testing, this button could also just go to mainHome
        Navigator.of(context).pushNamed(AppRoutes.signup);
      },
      child: const Text('Don\'t have an account? Sign Up'),
    );
  }

  Widget _buildTextInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildPhoneTextField({
    required TextEditingController controller,
    required String countryCode,
    required Function(String) onCountryCodeChanged,
    Widget? suffixIcon,
    Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: countryCode,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: <String>['+66', '+1', '+44', '+81']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onCountryCodeChanged(newValue);
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: '921111111',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required bool isError,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? Colors.red : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: '•••••••••',
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: GestureDetector(
            onTap: onToggleVisibility,
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}