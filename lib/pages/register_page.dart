import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/login_labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F2F9),
      body: SafeArea(
        child: LayoutBuilder(
          builder:(context, constraints) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Logo( titulo: 'Registro'),
                          _Form()
                        ],
                      ),
                      Column(
                        children: [
                          Labels( ruta: 'login3', pregunta: 'Ya tienes cuenta?', sugerencia: 'Ingresa con tu cuenta ahora!'),
                          SizedBox(height: 10),
                        ]
                      )
                    ]
                  )

                )
              )
            );
          },
        )
      ),
   );
  }
}


class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl  = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl
          ),

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
