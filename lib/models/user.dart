/*class Usuario{
  bool online;
  String email;
  String nombre;
  String uid;

  Usuario({
    required this.online,
    required this.email,
    required this.nombre,
    required this.uid
  });

}
*/

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String fullName;
  String email;
  List<String> roles;
  Compania compania;
  ZonaHoraria zonaHoraria;
  bool online = false;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.roles,
    required this.compania,
    required this.zonaHoraria,
    required this.online,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    compania: Compania.fromJson(json["compania"]),
    zonaHoraria: ZonaHoraria.fromJson(json["zonaHoraria"]),
    online: json["online"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "compania": compania.toJson(),
    "zonaHoraria": zonaHoraria.toJson(),
    "online": online,
  };
}

class Compania {
  String id;
  String nombre;

  Compania({required this.id, required this.nombre});

  factory Compania.fromJson(Map<String, dynamic> json) =>
      Compania(id: json["id"], nombre: json["nombre"]);

  Map<String, dynamic> toJson() => {"id": id, "nombre": nombre};
}

class ZonaHoraria {
  String clave;
  String descripcion;

  ZonaHoraria({required this.clave, required this.descripcion});

  factory ZonaHoraria.fromJson(Map<String, dynamic> json) =>
      ZonaHoraria(clave: json["clave"], descripcion: json["descripcion"]);

  Map<String, dynamic> toJson() => {"clave": clave, "descripcion": descripcion};
}
