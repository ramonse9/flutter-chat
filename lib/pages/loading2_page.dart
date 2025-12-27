import 'package:chat/pages/login2_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading2Page extends StatefulWidget {
  const Loading2Page({super.key});

  @override
  State<Loading2Page> createState() => _Loading2PageState();
}

class _Loading2PageState extends State<Loading2Page> {
  late Future<bool> _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Provider.of<AuthService>(context, listen: false).isLoggedIn();
  }

  Widget build(BuildContext context) {    

    return Scaffold(
      body: FutureBuilder<bool>(
        future: _isLoggedIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const Text('Cargando... Loading 2'));
          }
      
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrió un error inesperado'));
          }
      
          if (snapshot.hasData && snapshot.data == true) {
            return UsuariosPage();
          }
      
          return Login2Page();
        },
      ),
    );
  }
}
