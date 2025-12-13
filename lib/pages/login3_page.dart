import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/login_labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';

class Login3Page extends StatelessWidget {
  const Login3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F2F9),
      body: SafeArea(
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
                          Logo( titulo: 'Messenger'),
                          _Form(),
                        ],
                      ),
                      
                      // Bloque Inferior (Labels + Términos)
                      Column(
                        children: [
                          Labels( ruta: 'register', pregunta: 'No tienes cuenta?', sugerencia: 'Crea una ahora!'),
                          SizedBox(height: 10), // Un pequeño respiro
                          Text('3 Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200)),
                          SizedBox(height: 10), // Margen para que no pegue con el borde
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
    return Container(
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true
          ),
          //CustomInput(),
          //CustomInput(),
          //TextField(),
          BotonAzul(
            text: 'Ingrese',
            onPressed: (){
              print( emailCtrl.text );
              print( passCtrl.text );
            },
          ),
        ]
      ) 
    );
  }
}
