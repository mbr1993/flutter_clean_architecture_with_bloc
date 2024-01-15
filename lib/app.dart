import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/presentation/login/pages/auth_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Demo App',
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
