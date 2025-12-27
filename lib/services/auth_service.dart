import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/global/environment.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token ?? '';
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    try {
      final resp = await http
          .post(
            Uri.parse('${Environment.apiUrl}/auth/login'),
            body: jsonEncode(data),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 5));

      this.autenticando = false;

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        this.user = loginResponse.user;

        //TODO: Guardar token en lugar seguro

        await this._guardarToken(loginResponse.token);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      this.autenticando = false;
      print('Error en Login: $e');
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;

    final data = {'fullName': nombre, 'email': email, 'password': password};

    try {
      final resp = await http
          .post(
            Uri.parse('${Environment.apiUrl}/auth/register'),
            body: jsonEncode(data),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 5));

      this.autenticando = false;

      if (resp.statusCode == 201) {
        final loginResponse = loginResponseFromJson(resp.body);
        this.user = loginResponse.user;

        await this._guardarToken(loginResponse.token);
        return true;
      }

      final respBody = jsonDecode(resp.body);
      return respBody['message'];
    } catch (e) {
      autenticando = false;
      print('Error en registro: $e');
      return false;
    }
  }

  //TODO
  Future<bool> isLoggedIn() async {
    
    final token = await this._storage.read(key: 'token') ?? '';

    if (token.isEmpty) return false;    

    final resp = await http.get(
      Uri.parse('${Environment.apiUrl}/auth/check-status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      await this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');

    notifyListeners();
  }
}
