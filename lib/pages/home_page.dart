import 'package:chat/pages/config_page.dart';
import 'package:chat/pages/ordenes_2_page.dart';
import 'package:chat/pages/perfil_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Ordenes2Page(),
    const PerfilPage(),
    const ConfigPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent, //Fondo detrás de la barra
        color: Colors.blueAccent,            // Color de la barra
        buttonBackgroundColor: Colors.white, // Color del botón activo
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        index: _currentIndex,
        items: const <Widget>[
          Icon(Icons.list, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
          Icon(Icons.settings, size: 30, color: Colors.black)
        ],
        onTap: (index){
          setState( () {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
