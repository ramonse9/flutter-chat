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
  Cliente? cliente;
  Vehiculo? vehiculo;
  List<Factura> facturas = [];
  List<Nota> notas = [];

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
    this.cliente,
    this.vehiculo,
    required this.facturas,
    required this.notas,
    //required this.notas,    
  });

  factory Orden.fromJson(Map<String, dynamic> json) {
    print("Mapeando orden ID: ${json['id']} - Cliente: ${json['cliente']}");

    return Orden(
      liquidacionFactura: json["liquidacionFactura"],
      id: json["id"] ?? "Sin ID",
      descripcion: json["descripcion"],
      fechaIngreso: json["fechaIngreso"] == null ? null : DateTime.parse(json["fechaIngreso"]),
      fechaEntregaEstimada: json["fechaEntregaEstimada"] == null ? null : DateTime.parse(json["fechaEntregaEstimada"]),
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
      cliente: json["cliente"] == null ? null : Cliente.fromJson(json["cliente"]),
      vehiculo: json["vehiculo"] == null ? null : Vehiculo.fromJson(json["vehiculo"]),      
      facturas: json["facturas"] == null ?  [] : List<Factura>.from(json["facturas"].map((x) => Factura.fromJson(x))),    
      notas:    json["notas"] == null ?     [] : List<Nota>.from(json["notas"].map((x) => Nota.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "liquidacionFactura": liquidacionFactura,
    "id": id,
    "descripcion": descripcion,
    "fechaIngreso": fechaIngreso != null ? fechaIngreso!.toIso8601String() : '',
    "fechaEntregaEstimada": fechaEntregaEstimada != null
        ? fechaEntregaEstimada!.toIso8601String()
        : '',
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
    "cliente": cliente?.toJson(),
    "vehiculo": vehiculo?.toJson(),    
    "facturas": facturas == null ? [] : List<dynamic>.from(facturas.map((x) => x.toJson())),
    "notas": notas == null ? [] : List<dynamic>.from(notas.map((x) => x.toJson())),    
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

class Factura {
  String id;
  String estatus;
  String total;
  List<Pago> pagos;

  Factura({
    required this.id,
    required this.estatus,
    required this.total,
    required this.pagos,
  });

  factory Factura.fromJson(Map<String, dynamic> json) => Factura(
    id: json["id"],
    estatus: json["estatus"],
    total: json["total"],
    pagos: List<Pago>.from(json["pagos"].map((x) => Pago.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "estatus": estatus,
    "total": total,
    "pagos": List<dynamic>.from(pagos.map((x) => x.toJson())),
  };
}

class Pago {
  int id;
  int numeroParcialidad;
  String saldoAnterior;
  String monto;
  String saldoInsoluto;
  Complemento complemento;

  Pago({
    required this.id,
    required this.numeroParcialidad,
    required this.saldoAnterior,
    required this.monto,
    required this.saldoInsoluto,
    required this.complemento,
  });

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
    id: json["id"],
    numeroParcialidad: json["numeroParcialidad"],
    saldoAnterior: json["saldoAnterior"],
    monto: json["monto"],
    saldoInsoluto: json["saldoInsoluto"],
    complemento: Complemento.fromJson(json["complemento"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numeroParcialidad": numeroParcialidad,
    "saldoAnterior": saldoAnterior,
    "monto": monto,
    "saldoInsoluto": saldoInsoluto,
    "complemento": complemento.toJson(),
  };
}

class Complemento {
  String id;
  String estatus;
  String montoTotal;
  DateTime fechaPago;

  Complemento({
    required this.id,
    required this.estatus,
    required this.montoTotal,
    required this.fechaPago,
  });

  factory Complemento.fromJson(Map<String, dynamic> json) => Complemento(
    id: json["id"],
    estatus: json["estatus"],
    montoTotal: json["montoTotal"],
    fechaPago: DateTime.parse(json["fechaPago"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "estatus": estatus,
    "montoTotal": montoTotal,
    "fechaPago": fechaPago.toIso8601String(),
  };
}

class Nota {
  int id;
  String nota;
  String? estatus;
  DateTime createdAt;
  //List<dynamic> imagenes;

  Nota({
    required this.id,
    required this.nota,
    this.estatus,
    required this.createdAt,
    //required this.imagenes,
  });

  factory Nota.fromJson(Map<String, dynamic> json) => Nota(
    id: json["id"],
    nota: json["nota"],
    estatus: json["estatus"],
    createdAt: DateTime.parse(json["createdAt"]),
    //imagenes: List<dynamic>.from(json["imagenes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nota": nota,
    "estatus": estatus,
    "createdAt": createdAt.toIso8601String(),
    //"imagenes": List<dynamic>.from(imagenes.map((x) => x)),
  };
}

class SatMetodoPago {
  String clave;
  String descripcion;

  SatMetodoPago({required this.clave, required this.descripcion});

  factory SatMetodoPago.fromJson(Map<String, dynamic> json) =>
      SatMetodoPago(clave: json["clave"], descripcion: json["descripcion"]);

  Map<String, dynamic> toJson() => {"clave": clave, "descripcion": descripcion};
}

class Vehiculo {
  String id;
  int anio;
  String color;
  String? placa;
  String vin;
  String? descripcion;
  DateTime createdAt;
  DateTime updatedAt;
  Modelo modelo;

  Vehiculo({
    required this.id,
    required this.anio,
    required this.color,
    this.placa,
    required this.vin,
    this.descripcion,
    required this.createdAt,
    required this.updatedAt,
    required this.modelo,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
    id: json["id"],
    anio: json["anio"],
    color: json["color"],
    placa: json["placa"] ?? '',
    vin: json["vin"],
    descripcion: json["descripcion"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    modelo: Modelo.fromJson(json["modelo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "anio": anio,
    "color": color,
    "placa": placa,
    "vin": vin,
    "descripcion": descripcion,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "modelo": modelo.toJson(),
  };
}

class Modelo {
  String id;
  String nombre;
  Marca marca;

  Modelo({required this.id, required this.nombre, required this.marca});

  factory Modelo.fromJson(Map<String, dynamic> json) => Modelo(
    id: json["id"],
    nombre: json["nombre"],
    marca: Marca.fromJson(json["marca"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "marca": marca.toJson(),
  };
}

class Marca {
  String id;
  String nombre;

  Marca({required this.id, required this.nombre});

  factory Marca.fromJson(Map<String, dynamic> json) =>
      Marca(id: json["id"], nombre: json["nombre"]);

  Map<String, dynamic> toJson() => {"id": id, "nombre": nombre};
}
