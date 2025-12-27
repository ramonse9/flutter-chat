import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading2_page.dart';
import 'package:chat/pages/loading3_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login2_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': ( _ ) => UsuariosPage(),
  'chat'    : ( _ ) => ChatPage(),
  'login'   : ( _ ) => LoginPage(),
  'register': ( _ ) => RegisterPage(),
  'loading' : ( _ ) => LoadingPage(),
  'login2'  : ( _ ) => Login2Page(),
  'loading2': ( _ ) => Loading2Page(),
  'loading3': ( _ ) => Loading3Page(),
};