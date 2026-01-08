import 'package:chat/models/orden.dart';
import 'package:chat/pages/ordenes_detalle_page.dart';
import 'package:chat/services/ordenes_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ordenes3Page extends StatefulWidget {
  const Ordenes3Page({super.key});

  @override
  State<Ordenes3Page> createState() => _Ordenes3PageState();
}

class _Ordenes3PageState extends State<Ordenes3Page> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  List<Orden> _ordenes = [];
  bool _isLoading = false;
  bool _hasNextPage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _fetchOrdenes();
    });

    _scrollController.addListener((){
      if(_scrollController.position.pixels >= 
          _scrollController.position.maxScrollExtent - 200){
            _fetchOrdenes();
          }
    });
  }

  Future<void> _fetchOrdenes() async {
    if(_isLoading || !_hasNextPage) return;
    setState(() => _isLoading = true);

    try{
      final ordenesService = Provider.of<OrdenesService>(context, listen: false);

      final response = await ordenesService.paginarOrdenes(_currentPage);

      if(!mounted) return;

      setState((){
        _ordenes.addAll(response.ordenes);
        _currentPage++;
        _hasNextPage = response.hasNextPage;
        _isLoading = false;
      });

    }catch(e){
      print("ERROR EN PETICION: $e");

      if( mounted ){
        setState(() => _isLoading = false);
        ScaffoldMessenger.of( context ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
              "Total cargados: ${_ordenes.length} | Cargando: $_isLoading",
            ),
          ),
          Expanded(
            child: _ordenes.isEmpty
              ? const Center( child: Text("No hay datos todavía"))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _ordenes.length,
                  itemBuilder: (context, index){
                    return _buildOrdenCard(_ordenes[index]);
                  },
                ),
          ),
          if(_isLoading) const LinearProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildOrdenCard(Orden orden){
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrdenDetallePage(orden: orden)
            )
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Orden: ${orden.id}", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[800]
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(orden.estatusFactura!),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text(
                      orden.estatusFactura!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),  
                    ),
                  )
                ]
              ),
              const SizedBox(height: 12),
              //"Cliente: ${orden.cliente!.nombre} ${orden.cliente.paterno}"
              Text(
                "Cliente: ${orden.cliente?.nombre ?? 'N/A'} ${orden.cliente?.paterno ?? ''}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700]
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Vehículo: ${orden.vehiculo?.modelo?.marca?.nombre ?? ''} ${orden.vehiculo?.modelo?.nombre ?? ''} ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700]
                )
              ),
              const SizedBox(height: 8),
              Text(
                "Ingreso ${_formatDates(orden.fechaIngreso.toString())}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                )
              ),
            ]
          ),
        )
      ),
    );
  }

  Color _getStatusColor(String status){
    switch (status.toLowerCase()){
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

  String _formatDates(String? dateString){
    if( dateString == null) return 'N/A';

    try{
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    }catch(e){
      return 'Fecha Inválida';
    }

  }


}