import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/login_labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login2Page extends StatelessWidget {
  const Login2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Color(0xffF9F2F9),
      body: Stack(
        children: [
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      // Esta es la clave: La altura mínima es la altura disponible total
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Bloque Superior (Logo + Form)
                          Column(
                            children: [
                              Logo(titulo: 'Messenger'),
                              _Form(),
                            ],
                          ),

                          // Bloque Inferior (Labels + Términos)
                          Column(
                            children: [
                              Labels(
                                ruta: 'register',
                                pregunta: 'No tienes cuenta?',
                                sugerencia: 'Crea una ahora!',
                              ),
                              SizedBox(height: 10), // Un pequeño respiro
                              Text(
                                '3 Términos y condiciones de uso',
                                style: TextStyle(fontWeight: FontWeight.w200),
                              ),
                              SizedBox(
                                height: 10,
                              ), // Margen para que no pegue con el borde
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (authService.autenticando) _LoadingOverlay(),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                      emailCtrl.text.trim(),
                      passCtrl.text.trim(),
                    );

                    if (loginOk) {
                      Navigator.pushReplacementNamed(context, 'ordenes2');
                    } else {
                      //Mostrar una alerta si algo salió mal
                      mostrarAlerta(
                        context, 
                        'Login incorrecto',
                        'Revise sus credenciales nuevamente'
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      //Color oscuto semitransparente para dar foco al spinner
      color: Colors.black26,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }
}
