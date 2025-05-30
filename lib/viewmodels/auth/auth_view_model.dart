import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  // For frontend testing, we'll always act as if logged in.
  bool _isLoggedIn = true;
  String? _currentUsername = 'TestUser'; // Default username for testing

  bool get isLoggedIn => _isLoggedIn;
  String? get currentUsername => _currentUsername;

  // These methods will simply simulate success for testing
  Future<bool> login(String identifier, String password) async {
    _isLoggedIn = true;
    _currentUsername = 'TestUser'; // Or set a fixed test user
    notifyListeners();
    return true; // Always succeed
  }

  Future<bool> signUp({
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    debugPrint('Sign up called (frontend test mode)');
    return true; // Always succeed
  }

  void logout() {
    debugPrint('Logout called (frontend test mode)');
    // In test mode, you might not even change _isLoggedIn,
    // or you might change it temporarily to test the login screen path.
    // For now, let's keep it true to ensure the app stays in the main section.
    // _isLoggedIn = false;
    // _currentUsername = null;
    notifyListeners();
  }
}