//import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/paginado_ordenes_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrdenesService with ChangeNotifier {
  Future<PaginadoOrdenesResponse> paginarOrdenes(int pagina) async {
    final parameters = {'page': '$pagina', 'limit': '10', 'fSearch': ''};

    try {
      final token = await AuthService.getToken();

      final uri = Uri.parse(
        '${Environment.apiUrl}/ordenes',
      ).replace(queryParameters: parameters);

      final resp = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (resp.statusCode == 200) {
        //final jsonBody = json.decode(resp.body);
        return paginadoOrdenesResponseFromJson(resp.body);
      } else {
        print(resp);
        throw Exception('Error al obtener las órdenes: ${resp.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en paginarOrdenes: $e');
    }
  }
}
