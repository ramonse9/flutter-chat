import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    /*
    User(id: '1', nombre: 'Maria', email: 'test1@test.com', online: true),
    User(id: '2', nombre: 'Melissa', email: 'test2@test.com', online: false),
    User(id: '3', nombre: 'Fernando', email: 'test3@test.com', online: true),
    User(id: '4', nombre: 'Maria 4', email: 'test1@test.com', online: true),
    User(id: '5', nombre: 'Melissa 5', email: 'test2@test.com', online: false),
    User(id: '6', nombre: 'Fernando 6', email: 'test3@test.com', online: true),
    User(id: '7', nombre: 'Maria 7', email: 'test1@test.com', online: true),
    User(id: '8', nombre: 'Melissa 8', email: 'test2@test.com', online: false),
    User(id: '9', nombre: 'Fernando 9', email: 'test3@test.com', online: true),
    User(id: '10', nombre: 'Maria 10', email: 'test1@test.com', online: true),
    User(id: '11', nombre: 'Melissa 11', email: 'test2@test.com', online: false),
    User(id: '12', nombre: 'Fernando 12', email: 'test3@test.com', online: true),    */
  ];

  Future<void> _recargarDatos() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final nombre = authService.user.fullName;
    return Scaffold(
      appBar: AppBar(
        title: Text( nombre ),
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            final authService = Provider.of<AuthService>(
              context,
              listen: false,
            );

            await authService.logout();

            Navigator.pushNamedAndRemoveUntil(
              context,
              'login2',
              (route) => false,
            );
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            //child: Icon( Icons.check_circle, color: Colors.blue[400] )
            child: Icon(Icons.offline_bolt, color: Colors.red),
          ),
        ],
      ),
      body: _listViewUsuarios(),
    );
  }

  Widget _listViewUsuarios() {
    return RefreshIndicator(
      onRefresh: _cargarUsuarios,
      color: Colors.blue,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length,
      ),
    );
  }

  ListTile _usuarioListTile(User usuario) {
    return ListTile(
      title: Text(usuario.fullName),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.fullName.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  Future<void> _cargarUsuarios() async {
    await Future.delayed(Duration(seconds: 4));
  }
}
