import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const BotonAzul({
    super.key, 
    required this.text,
    required this.onPressed
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton( 
      style: ElevatedButton.styleFrom(
        elevation:2,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold
        )
      ),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text( this.text)
        )
      )
    );
  }
}