import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/login_labels.dart';
import 'package:chat/widgets/logo.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F2F9),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Logo( titulo: 'Messenger'),
                _Form(),
                Labels( ruta: 'register', pregunta: 'No tienes cuenta?', sugerencia: 'Crea una ahora!', ),
                Text('1 Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200))
            
              ]
            ),
          ),
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
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
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

