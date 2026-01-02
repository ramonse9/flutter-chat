// To parse this JSON data, do
//
//     final orden = ordenFromJson(jsonString);

import 'dart:convert';

Orden ordenFromJson(String str) => Orden.fromJson(json.decode(str));

String ordenToJson(Orden data) => json.encode(data.toJson());

class Orden {
  bool liquidacionFactura;
  String id;
  String? descripcion;
  DateTime? fechaIngreso;
  DateTime? fechaEntregaEstimada;
  dynamic? fechaEntregaReal;
  dynamic? kilometros;
  String? poliza;
  String? siniestro;
  String? estatus;
  String? estatusFactura;
  dynamic? fechaLiquidacion;
  dynamic? uuidFacturaPac;
  DateTime createdAt;
  DateTime updatedAt;
  //Cliente cliente;
  //String? clienteNombre;

  Orden({
    required this.liquidacionFactura,
    required this.id,
    this.descripcion,
    this.fechaIngreso,
    this.fechaEntregaEstimada,
    this.fechaEntregaReal,
    this.kilometros,
    this.poliza,
    this.siniestro,
    this.estatus,
    this.estatusFactura,
    this.fechaLiquidacion,
    this.uuidFacturaPac,
    required this.createdAt,
    required this.updatedAt,
    //required this.cliente,
    //this.clienteNombre,
  });

  factory Orden.fromJson(Map<String, dynamic> json) => Orden(
    liquidacionFactura: json["liquidacionFactura"],
    id: json["id"] ?? "Sin ID",
    descripcion: json["descripcion"],
    fechaIngreso: DateTime.parse(json["fechaIngreso"]),
    fechaEntregaEstimada: DateTime.parse(json["fechaEntregaEstimada"]),
    fechaEntregaReal: json["fechaEntregaReal"],
    kilometros: json["kilometros"],
    poliza: json["poliza"],
    siniestro: json["siniestro"],
    estatus: json["estatus"],
    estatusFactura: json["estatusFactura"],
    fechaLiquidacion: json["fechaLiquidacion"],
    uuidFacturaPac: json["uuidFacturaPAC"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    //cliente: Cliente.fromJson(json["cliente"]),
    //clienteNombre: json["cliente"] != null ? json["cliente"]["nombre"] : "Sin nombre",
  );

  Map<String, dynamic> toJson() => {
    "liquidacionFactura": liquidacionFactura,
    "id": id,
    "descripcion": descripcion,
    "fechaIngreso": fechaIngreso != null ? fechaIngreso!.toIso8601String() : '',
    "fechaEntregaEstimada": fechaEntregaEstimada != null ? fechaEntregaEstimada!.toIso8601String() : '',
    "fechaEntregaReal": fechaEntregaReal,
    "kilometros": kilometros,
    "poliza": poliza,
    "siniestro": siniestro,
    "estatus": estatus,
    "estatusFactura": estatusFactura,
    "fechaLiquidacion": fechaLiquidacion,
    "uuidFacturaPAC": uuidFacturaPac,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    //"cliente": cliente.toJson(),
    //"clienteNombre": clienteNombre,
  };
}

class Cliente {
  String id;
  String nombre;
  String paterno;
  String materno;
  String telefono;
  String email;
  String rfc;
  String razonSocial;
  String codigoPostal;
  DateTime createdAt;
  DateTime updatedAt;

  Cliente({
    required this.id,
    required this.nombre,
    required this.paterno,
    required this.materno,
    required this.telefono,
    required this.email,
    required this.rfc,
    required this.razonSocial,
    required this.codigoPostal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    id: json["id"],
    nombre: json["nombre"],
    paterno: json["paterno"],
    materno: json["materno"],
    telefono: json["telefono"],
    email: json["email"],
    rfc: json["rfc"],
    razonSocial: json["razonSocial"],
    codigoPostal: json["codigoPostal"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "paterno": paterno,
    "materno": materno,
    "telefono": telefono,
    "email": email,
    "rfc": rfc,
    "razonSocial": razonSocial,
    "codigoPostal": codigoPostal,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
