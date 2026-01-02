// To parse this JSON data, do
//
//     final paginadoOrdenesResponse = paginadoOrdenesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/orden.dart';

PaginadoOrdenesResponse paginadoOrdenesResponseFromJson(String str) => PaginadoOrdenesResponse.fromJson(json.decode(str));

String paginadoOrdenesResponseToJson(PaginadoOrdenesResponse data) => json.encode(data.toJson());

class PaginadoOrdenesResponse {
    int page;
    int limit;
    int totalItems;
    int totalPages;
    bool hasNextPage;
    List<Orden> ordenes;

    PaginadoOrdenesResponse({
        required this.page,
        required this.limit,
        required this.totalItems,
        required this.totalPages,
        required this.hasNextPage,
        required this.ordenes,
    });

    factory PaginadoOrdenesResponse.fromJson(Map<String, dynamic> json) => PaginadoOrdenesResponse(
        page: json["page"],
        limit: json["limit"],
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        hasNextPage: json["hasNextPage"],
        ordenes: List<Orden>.from(json["ordenes"].map((x) => Orden.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "totalItems": totalItems,
        "totalPages": totalPages,
        "hasNextPage": hasNextPage,
        "ordenes": List<dynamic>.from(ordenes.map((x) => x.toJson())),
    };
}