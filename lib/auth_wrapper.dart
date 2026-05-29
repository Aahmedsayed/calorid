import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test103/providers/auth_provider.dart';
import 'package:test103/auth/sign_in/sign_in.dart';
import 'package:test103/main.dart'; // for MainNavigationScreen

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    await Provider.of<AuthProvider>(context, listen: false).checkAuthStatus();
    if (mounted) {
      setState(() {
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.isAuthenticated) {
      return const MainNavigationScreen();
    } else {
      return const SignIn();
    }
  }
}
