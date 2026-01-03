import 'package:chat/services/ordenes_service.dart';
import 'package:chat/services/vin_scanner_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/routes/routes.dart';

import 'services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => OrdenesService() ),
        ChangeNotifierProvider(create: ( _ ) => VinScannerService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'escanear',
        routes: appRoutes
      ),
    );
  }
}