import 'package:flutter/material.dart';
import 'package:test103/BMI/bmi_screen.dart';
import 'package:test103/about/about_Screen.dart';
import 'package:test103/auth/Password_reset/reset_password.dart';
import 'package:test103/auth/sign_in/sign_in.dart';
import 'package:test103/auth/sign_up/sign_up.dart';
import 'package:test103/home/HomeScreen.dart';
import 'package:test103/profile/profile_screen.dart';
import 'package:test103/user_info/user_info.dart';
import 'package:test103/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:test103/providers/auth_provider.dart';
import 'package:test103/providers/profile_provider.dart';
import 'package:test103/auth_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const FoodSnapApp(),
    ),
  );
}

class FoodSnapApp extends StatelessWidget {
  const FoodSnapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalCount',
      debugShowCheckedModeBanner: false,

        routes: {
          AppRoutes.home: (context) => const MainNavigationScreen(),
          AppRoutes.signUp: (context) => const SignupScreen(),
          AppRoutes.signIn: (context) => const SignIn(),
          AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
          AppRoutes.profile: (context) => const ProfileScreen(),
          AppRoutes.about: (context) => const AboutScreen(),
        },

      theme: ThemeData(
        primaryColor: const Color(0xFF667EEA),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      home: const AuthWrapper(),
    );
  }
}

// Main Navigation Screen with Bottom Nav Bar
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const UserInfoScreen(),
    const ProfileScreen(),
    const BMICalculatorScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF667EEA),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'BMI'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Deficit calc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

