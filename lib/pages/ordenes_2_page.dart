import 'package:chat/models/orden.dart';
import 'package:chat/pages/ordenes_detalle_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/ordenes_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ordenes2Page extends StatefulWidget {
  const Ordenes2Page({super.key});

  @override
  State<Ordenes2Page> createState() => _Ordenes2PageState();
}

class _Ordenes2PageState extends State<Ordenes2Page> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  List<Orden> _ordenes = [];
  bool _isLoading = false;
  bool _hasNextPage = true;

  @override
  void initState() {
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
        _ordenes.addAll(response.data);
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug Órdenes")),
      body: Column(
        children: [
          // Indicador de estado rápido
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blueGrey[100],
            child: Text(
              "Total cargados: ${_ordenes.length} | Cargando: $_isLoading",
            ),
          ),

          Expanded(
            child: _ordenes.isEmpty
                ? const Center(child: Text("No hay datos todavía"))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _ordenes.length,
                    itemBuilder: (context, index) {
                      final orden = _ordenes[index];
                      return Card(
                        child: ListTile(
                          title: Text("ID: ${orden.id}"),
                          subtitle: Text("Status: ${orden.estatusFactura}"),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrdenDetallePage(orden: orden)
                              )
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),

          // Si se congela aquí, es que el _isLoading nunca vuelve a false
          if (_isLoading) const LinearProgressIndicator(),
        ],
      ),
    );
  }

  /*

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Forzamos fondo blanco para evitar pantalla negra
      appBar: AppBar(
        title: const Text("Debug Órdenes"),
        actions: [
          // Botón para resetear si algo sale mal
          IconButton(icon: Icon(Icons.refresh), onPressed: () => _fetchOrdenes())
        ],
      ),
      body: _isLoading && _ordenes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: _ordenes.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final orden = _ordenes[index];
                      return ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(orden.id),
                        subtitle: Text("Estado: ${orden.estatusFactura} - Descripcion: ${orden.descripcion}"),
                      );
                    },
                  ),
                ),
                if (_isLoading) 
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
    );
  }*/

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis órdenes")),
      body: _ordenes.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _ordenes.length + (_hasNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                //Si llegamos al final de la lista actual y hay más, mostrar loader
                if (index == _ordenes.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final orden = _ordenes[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Orden ID: ${orden.id}'),
                  subtitle: Text('Estado: ${orden.estatusFactura}')
                );
              },
            ),
    );
  }
  */

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis órdenes")),
      body: _ordenes.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _ordenes.length + (_hasNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _ordenes.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final orden = _ordenes[index];

                // USAMOS EL NUEVO DISEÑO AQUÍ
                return _buildOrderCard(orden);
              },
            ),
    );
  }

  Widget _buildOrderCard(Orden orden) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell( // Para que sea clickeable con efecto visual
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          print('Click en orden: ${orden.id}');
          // Aquí puedes navegar al detalle: Navigator.push(...)
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Folio: ${orden.id}', // O el campo que uses para el folio
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  _buildStatusBadge(orden.estatusFactura ?? 'PENDIENTE'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.receipt_long, size: 18, color: Colors.blueGrey),
                  const SizedBox(width: 8),
                  Text('Estado Factura: ${orden.estatusFactura}'),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Ver detalles',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.chevron_right, color: Colors.blue, size: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    // Definimos colores según el estado
    Color color;
    switch (status.toUpperCase()) {
      case 'FACTURADO': color = Colors.green; break;
      case 'PENDIENTE': color = Colors.orange; break;
      case 'CANCELADO': color = Colors.red; break;
      default: color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
  */
}
