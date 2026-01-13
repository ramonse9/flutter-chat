import 'package:chat/models/orden.dart';
import 'package:chat/pages/ordenes_detalle2_page.dart';
import 'package:chat/pages/ordenes_detalle_page.dart';
import 'package:chat/services/ordenes_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ordenes6Page extends StatefulWidget {
  const Ordenes6Page({super.key});

  @override
  State<Ordenes6Page> createState() => _Ordenes6PageState();
}

class _Ordenes6PageState extends State<Ordenes6Page> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  List<Orden> _ordenes = [];
  bool _isLoading = false;
  bool _hasNextPage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchOrdenes();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _fetchOrdenes();
      }
    });
  }

  Future<void> _fetchOrdenes() async {
    if (_isLoading || !_hasNextPage) return;
    setState(() => _isLoading = true);

    try {
      final ordenesService = Provider.of<OrdenesService>(
        context,
        listen: false,
      );

      final response = await ordenesService.paginarOrdenes(_currentPage);

      if (!mounted) return;

      setState(() {
        _ordenes.addAll(response.ordenes);
        _currentPage++;
        _hasNextPage = response.hasNextPage;
        _isLoading = false;
      });
    } catch (e) {
      print("ERROR EN PETICION: $e");

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Órdenes de Servicio")),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blueGrey[100],
            child: Text(
              "4 Total cargados: ${_ordenes.length} | Cargando: $_isLoading",
            ),
          ),
          Expanded(
            child: _ordenes.isEmpty && !_isLoading
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _ordenes.length + (_hasNextPage ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _ordenes.length) {
                        return _buildLoadingMore();
                      }
                      return _buildOrdenCard(_ordenes[index]);
                    },
                  ),
          ),
          //if (_isLoading) const LinearProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            "No hay órdenes",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),
          Text(
            "Las órdenes aparecerán aquí",
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingMore() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(strokeWidth: 2),
            const SizedBox(height: 8),
            Text(
              "Cargando más órdenes...",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdenCard(Orden orden) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrdenDetalle2Page(),
            ),
          );
        },
        // Efecto de elevacion al tocar
        onHighlightChanged: (pressed) {
          //Este efecto se ve al presionar
        },
        splashColor: Colors.blue.withValues(alpha: 0.3),
        highlightColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getEstatusBorderColor(orden.estatusFactura!),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Encabezado con gradiente
                //Fila 1: ID y Estatus
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Badge de ID
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade100,
                              Colors.blue.shade200,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.blue.shade200,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: Colors.blue.shade800,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              orden.id,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Badge de estatus
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getEstatusColor(orden.estatusFactura!),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: _getEstatusColor(
                                orden.estatusFactura!,
                              ).withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            _getEstatusIcon(orden.estatusFactura!),
                            const SizedBox(width: 6),
                            Text(
                              _getEstatusText(orden.estatusFactura!),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                //Linea divisoria
                //Divider(color: Colors.grey[300], height: 1),
                //const SizedBox(height: 12),

                // Fila 2: Cliente con icono
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 20),
                        Icon(
                          Icons.directions_car_outlined,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 20),
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    //Columna de informacion
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${orden.cliente?.nombre ?? 'N/A'} ${orden.cliente?.paterno ?? ''}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "${orden.vehiculo?.modelo?.marca?.nombre ?? ''} ${orden.vehiculo?.modelo?.nombre ?? ''}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            "${orden.vehiculo?.anio ?? ''} • ${orden.vehiculo?.color ?? ''}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Recibido: ${_formatDate(orden.fechaIngreso.toString())}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //Si tiene factura ó notas, mostral
                if (orden.facturas.isNotEmpty || orden.notas.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      Divider(color: Colors.grey[200], height: 1),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          if (orden.facturas.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.green.shade100,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    size: 12,
                                    color: Colors.green.shade700,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    " ${orden.facturas[0].total} ",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (orden.notas.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.amber.shade100,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.note_add,
                                    size: 12,
                                    color: Colors.amber.shade700,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${orden.notas.length} nota(s)",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.amber.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getEstatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'timbrada':
        return Colors.green;
      case 'cotizacion':
        return Colors.orange;
      case 'cancelada':
        return Colors.red;
      case 'pendiente':
        return Colors.blue;
      default:
        return Colors.blueGrey;
    }
  }

  Color _getEstatusBorderColor(String estatus) {
    switch (estatus.toLowerCase()) {
      case 'timbrada':
        return Colors.green.shade200;
      case 'cotizacion':
        return Colors.orange.shade200;
      case 'cancelada':
        return Colors.red.shade200;
      case 'pendiente':
        return Colors.blue.shade200;
      default:
        return Colors.blueGrey;
    }
  }

  Icon _getEstatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'timbrada':
        return const Icon(Icons.check_circle, size: 12, color: Colors.white);
      case 'cotizacion':
        return const Icon(Icons.hourglass_empty, size: 12, color: Colors.white);
      case 'cancelada':
        return const Icon(Icons.cancel, size: 12, color: Colors.white);
      case 'pendiente':
        return const Icon(Icons.info, size: 12, color: Colors.white);
      default:
        return const Icon(Icons.info, size: 12, color: Colors.white);
    }
  }

  String _getEstatusText(String estatus) {
    switch (estatus.toLowerCase()) {
      case 'timbrada':
        return 'TIMBRADA';
      case 'cotizacion':
        return 'COTIZACION';
      case 'cancelada':
        return 'CANCELADA';
      case 'pendiente':
        return 'PENDIENTE';
      default:
        return estatus.toUpperCase();
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';

    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Fecha Inválida';
    }
  }
}
