import 'package:flutter/material.dart';

class OrdenDetalle3Page extends StatelessWidget {
  const OrdenDetalle3Page({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF136dec);
    const bgColor = Color(0xFFf6f7f8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios, color: Color(0xFF111418), size: 20),
        title: const Text(
          'ord000020',
          style: TextStyle(color: Color(0xFF111418), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "COTIZACIÓN",
                style: TextStyle(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVehicleCard(primaryColor),
            _buildSectionHeader("Cliente y Empresa"),
            _buildClientCard(primaryColor),
            _buildSectionHeader("Descripción del Servicio"),
            _buildDescriptionCard(primaryColor),
            _buildDatesGrid(primaryColor),
            _buildBillingCard(primaryColor),
          ],
        ),
      ),
      bottomSheet: _buildBottomBar(primaryColor),
    );
  }

  // --- Header de Sección ---
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.black.withValues( alpha: 0.6 ),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  // --- 1. Información del Vehículo ---
  Widget _buildVehicleCard(Color primary) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_car, color: primary, size: 14),
                      const SizedBox(width: 4),
                      const Text("INFORMACIÓN DEL VEHÍCULO", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text("Nissan Versa 2019", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text("Blanco | VIN: 3N1CN7AP5KL", style: TextStyle(color: Color(0xFF617289), fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.speed, color: primary, size: 16),
                      const SizedBox(width: 4),
                      Text("40,000 km", style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(image: NetworkImage("https://via.placeholder.com/100"), fit: BoxFit.cover),
                boxShadow: [BoxShadow(color: Colors.black.withValues( alpha: 0.05 ), blurRadius: 5)],
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- 2. Tarjeta del Cliente ---
  Widget _buildClientCard(Color primary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Karla Fuente", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Escuela Kemper Urate", style: TextStyle(color: Color(0xFF617289), fontSize: 14)),
                ],
              ),
            ),
            _iconAction(Icons.phone, primary.withValues( alpha: 0.1), primary),
            const SizedBox(width: 8),
            _iconAction(Icons.chat, Colors.green.shade50, Colors.green),
          ],
        ),
      ),
    );
  }

  // --- 3. Descripción ---
  Widget _buildDescriptionCard(Color primary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_list_bulleted, color: primary, size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Reparación mayor de hojalatería y pintura en facia delantera, ajuste de cofre y sustitución de faro derecho. Pulido general y encerado de protección.",
                style: TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF111418)),
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- 4. Grid de Fechas ---
  Widget _buildDatesGrid(Color primary) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: _dateItem("Entrada", "12 Oct, 2023", Icons.calendar_today, Colors.grey)),
          const SizedBox(width: 16),
          Expanded(child: _dateItem("Promesa", "18 Oct, 2023", Icons.event_available, primary)),
        ],
      ),
    );
  }

  Widget _dateItem(String label, String date, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(date, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color == Colors.grey ? const Color(0xFF111418) : color)),
            ],
          )
        ],
      ),
    );
  }

  // --- 5. Tarjeta de Facturación ---
  Widget _buildBillingCard(Color primary) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: _cardDecoration(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Monto Total", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text("\$20,300.00", style: TextStyle(color: primary, fontSize: 28, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text("Método", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text("Transferencia", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    )
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("UUID: 550e8400-e29b...", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Row(
                      children: [
                        Icon(Icons.description, color: primary, size: 16),
                        const SizedBox(width: 4),
                        Text("Ver factura", style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(12)),
              ),
              child: const Text("TIMBRADA", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  // --- Barra de Navegación Estilo iOS ---
  Widget _buildBottomBar(Color primary) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: Colors.white.withValues( alpha: 0.9),
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _btn(Icons.edit, "Editar", Colors.grey.shade100, const Color(0xFF111418)),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: _btn(Icons.share, "Enviar PDF", primary, Colors.white, hasShadow: true),
          ),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, String text, Color bg, Color textCol, {bool hasShadow = false}) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: hasShadow ? [BoxShadow(color: bg.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))] : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textCol, size: 20),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: textCol, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Decoración común para tarjetas
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFF3F4F6)),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2))],
    );
  }

  Widget _iconAction(IconData icon, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 20),
    );
  }
}