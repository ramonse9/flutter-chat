import 'package:flutter/material.dart';

class VinScannerService with ChangeNotifier {
  final vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');

  String? _vinDetectado;
  String? get vinDetectado => _vinDetectado;

  void procesarTextoDetectado(String texto) {
    final posibles = texto.split(RegExp(r'\s+'));
    for (final palabra in posibles) {
      if (vinRegex.hasMatch(palabra)) {
        _vinDetectado = palabra;
        notifyListeners();
        break;
      }
    }
  }

  void limpiar() {
    _vinDetectado = null;
    notifyListeners();
  }
}
