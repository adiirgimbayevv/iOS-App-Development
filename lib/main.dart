// Lab 6: Registration form
// Lab 7: BottomNavigationBar + Navigator.push/pop with product arguments
// Auth: local accounts stay after refresh; logout + login supported

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme.dart';
import 'auth_storage.dart';
import 'login_screen.dart';
import 'main_shell.dart';
import 'models.dart';
import 'registration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const SportNutritionApp());
}

class SportNutritionApp extends StatelessWidget {
  const SportNutritionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sport Nutrition Store',
      theme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const AuthGate(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegistrationScreen(),
      },
    );
  }
}

/// Opens Feed if a session exists, otherwise Login.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _auth = AuthStorage();
  late Future<AppUser?> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = _auth.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.purpleGlow),
            ),
          );
        }

        final user = snapshot.data;
        if (user != null) {
          return MainShell(user: user);
        }
        return const LoginScreen();
      },
    );
  }
}
