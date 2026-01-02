import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading4Page extends StatefulWidget {
  const Loading4Page({super.key});

  @override
  State<Loading4Page> createState() => _Loading4PageState();
}

class _Loading4PageState extends State<Loading4Page> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final isLoggedIn = await authService.isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, 'login2', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center( child: Text('Cargando Loading 4...'))
     );
  }
}
