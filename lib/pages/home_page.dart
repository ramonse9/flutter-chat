import 'package:chat/pages/config_page.dart';
import 'package:chat/pages/escanear_vin_page.dart';
import 'package:chat/pages/ordenes_3_page.dart';
import 'package:chat/pages/ordenes_4_page.dart';
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
  bool _isInitialized = false;

  final List<Widget> _screens = [
    const Ordenes4Page(),
    const EscanearVinPage(),
    const PerfilPage(),
    const ConfigPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback( (_){
      if( mounted ){
        setState((){
          this._isInitialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens
      ),
      bottomNavigationBar: this._isInitialized ? 
        CurvedNavigationBar(
          backgroundColor: Colors.transparent, //Fondo detrás de la barra
          color: Colors.blueAccent,            // Color de la barra
          buttonBackgroundColor: Colors.white, // Color del botón activo
          animationDuration: const Duration(milliseconds: 300),
          height: 60,
          index: _currentIndex,
          items: const <Widget>[
            Icon(Icons.list, size: 30, color: Colors.black),
            Icon(Icons.search, size: 30, color: Colors.black),
            Icon(Icons.person, size: 30, color: Colors.black),
            Icon(Icons.settings, size: 30, color: Colors.black)
          ],
          onTap: (index){
            setState( () {
              _currentIndex = index;
            });
          },
        )
        : null,
    );
  }
}
