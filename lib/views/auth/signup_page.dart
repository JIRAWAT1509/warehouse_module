import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/app/routes.dart';
import 'package:warehouse_module/viewmodels/auth/auth_view_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _countryCode = '+66';

  bool _isPasswordWeak = false;
  bool _passwordsMatch = true;

  void _signup() async {
    setState(() {
      _isLoading = true;
    });

    // --- FOR FRONTEND TESTING ONLY ---
    // Simulate success and navigate directly to login (or main home)
    await Future.delayed(const Duration(milliseconds: 500)); // Short delay for visual effect
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    // After signup, you might want to send them to the login page for testing the login flow
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    // OR directly to main home if you want to skip login after signup
    // Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainHome, (route) => false);
    // --- END FRONTEND TESTING CODE ---

    // Original signup logic (commented out for testing)
    /*
    final email = _emailController.text.trim();
    final phoneNumber = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || phoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      setState(() { _isLoading = false; });
      return;
    }

    if (password != confirmPassword) {
      setState(() { _passwordsMatch = false; _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
       setState(() { _isPasswordWeak = true; _isLoading = false; });
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password requires a capital letter')));
       return;
    }

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    bool success = await authViewModel.signUp(email: email, phoneNumber: _countryCode + phoneNumber, password: password);

    if (!mounted) return;

    setState(() { _isLoading = false; });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign up successful! Please log in.')));
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign up failed. Please try again.')));
    }
    */
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 2,
                        width: 70,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Your Email',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              _buildTextInputField(
                controller: _emailController,
                hintText: 'Test@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              Text(
                'Your Phone number',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              _buildPhoneInputField(
                controller: _phoneController,
                countryCode: _countryCode,
                onCountryCodeChanged: (newCode) {
                  setState(() {
                    _countryCode = newCode;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              _buildPasswordInputField(
                controller: _passwordController,
                isError: _isPasswordWeak,
                obscureText: _obscurePassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              if (_isPasswordWeak)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                  child: Text(
                    'password require Capital letter',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                'Confirm Password',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              _buildPasswordInputField(
                controller: _confirmPasswordController,
                isError: !_passwordsMatch,
                obscureText: _obscureConfirmPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Reusable Widget Builders (from previous responses) ---
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

  Widget _buildPhoneInputField({
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
                    child: Text(value, style: TextStyle(color: Colors.black)),
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

  Widget _buildPasswordInputField({
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
      )
    );
  }
}