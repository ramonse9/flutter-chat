import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading3Page extends StatelessWidget {
  const Loading3Page({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FutureBuilder(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Cargando Page 3...'));
        }

        if (snapshot.data == true) {
          Future.microtask(() {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => UsuariosPage(),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          });
        } else {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, 'login2');
          });
        }

        return Container();
      },
    );
  }
}
