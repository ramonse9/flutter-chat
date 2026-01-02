import 'package:chat/models/orden.dart';
import 'package:chat/services/ordenes_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdenesPage extends StatefulWidget {
  const OrdenesPage({super.key});

  @override
  State<OrdenesPage> createState() => _OrdenesPageState();
}

class _OrdenesPageState extends State<OrdenesPage> {
  final ScrollController _scrollController = ScrollController();
  List<Orden> _ordenes = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchOrdenes();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchOrdenes();
      }
    });
  }

  Future<void> _fetchOrdenes() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    final ordenesService = Provider.of<OrdenesService>(context, listen: false);

    final response = await ordenesService.paginarOrdenes(_currentPage);
    setState(() {
      _ordenes.addAll(response.ordenes);
      _currentPage++;
      _hasMore = _currentPage <= response.totalPages;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_ordenes.isEmpty && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          itemCount: _ordenes.length,
          itemBuilder: (context, index) {
            if (index < _ordenes.length) {
              final orden = _ordenes[index];
              return ListTile(
                title: Text(
                  'Orden #${orden.id.toUpperCase()}',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('Estatus Factura: ${orden.estatusFactura}'),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
        if (_isLoading)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
  
}
