import 'package:chat/models/orden.dart';
import 'package:flutter/material.dart';

class OrdenDetallePage extends StatelessWidget {
  final Orden orden;

  const OrdenDetallePage({super.key, required this.orden});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden #${orden.id.toUpperCase()}'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSeccion("Informacion General"),
            _infoCard([
              _datoRow("Estatus", orden.estatus ?? "N/A", Icons.info_outline),
              _datoRow(
                "Factura",
                orden.estatusFactura ?? "N/A",
                Icons.receipt_long,
              ),
              _datoRow(
                "Liquidada",
                orden.liquidacionFactura ? "Sí" : "No",
                Icons.payment_outlined,
              ),
            ]),
            const SizedBox(height: 20),
            _headerSeccion("Fechas"),
            _infoCard([
              _datoRow(
                "Ingreso",
                _formatDate( orden.fechaIngreso ),
                Icons.calendar_today,
              ),
              _datoRow(
                "Entrega Estimada",
                _formatDate( orden.fechaEntregaEstimada ),
                Icons.event,
              ),
              _datoRow(
                "Entrega Real",
                _formatDate( orden.fechaEntregaReal ),
                Icons.event_available,
              ),
            ]),
            const SizedBox(height: 20),
            _headerSeccion('Descripción'),
            _infoCard([
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text( orden.descripcion ?? "Sin descripción", style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                  ]
                )
              )
            ]),
          ],
        ),
      ),
    );
  }

  Widget _headerSeccion(String titulo) {
    return Text(
      titulo.toUpperCase(),
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _datoRow(String etiqueta, String valor, IconData icono) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icono, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 15),
          Expanded(
            child: Text(etiqueta, style: const TextStyle(color: Colors.grey)),
          ),
          Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return "Pendiente";
    if (date is DateTime) return "${date.day}/${date.month}/${date.year}";
    return date.toString();
  }
}
