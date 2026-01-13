import 'package:flutter/material.dart';

class OrdenDetalle2Page extends StatelessWidget {
  OrdenDetalle2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Colores basados en tu configuración de Tailwind
    const primaryColor = Color(0xFF136dec);
    const backgroundLight = Color(0xFFf6f7f8);
    
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues( alpha: 0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Orden #29384',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: primaryColor)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: primaryColor)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Espacio para la barra inferior
        child: Column(
          children: [
            _buildStatusHeader(),
            _buildVehicleCard(primaryColor),
            _buildTimeline(primaryColor),
            _buildInfoAccordions(primaryColor),
            _buildNotesSection(primaryColor),
          ],
        ),
      ),
      bottomSheet: _buildBottomActionBar(primaryColor),
    );
  }

  // --- 1. Indicador de Estado ---
  Widget _buildStatusHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ESTADO ACTUAL", 
                  style: TextStyle(color: Colors.orange.shade700, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                const Text("Cotización", 
                  style: TextStyle(color: Color(0xFF9A3412), fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.request_quote, color: Colors.white, size: 32),
            )
          ],
        ),
      ),
    );
  }

  // --- 2. Tarjeta de Vehículo ---
  Widget _buildVehicleCard(Color primary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("VEHÍCULO", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                  Text("P-492KLR", style: TextStyle(color: primary, fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text("Toyota Hilux 2023", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Text("Gris Metálico • Diesel", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.image, size: 18),
                    label: const Text("Ver Galería (12)"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary.withValues(alpha: 0.1),
                      foregroundColor: primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade200,
                image: const DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/150"), // Reemplazar con tu URL
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- 3. Cronograma (Timeline) ---
  Widget _buildTimeline(Color primary) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("CRONOGRAMA DE SERVICIO", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            const SizedBox(height: 16),
            _timelineStep(Icons.check_circle, "Ingreso a Taller", "24 de Octubre, 2023", "Registrado por: Admin", Colors.green, true),
            _timelineStep(Icons.pending, "Estado: En Cotización", "Pendiente de Aprobación", "Iniciado hace 2 días", primary, true, isPending: true),
            _timelineStep(Icons.event_available, "Entrega Estimada", "30 de Octubre, 2023", "Sujeto a repuestos", Colors.grey, false),
          ],
        ),
      ),
    );
  }

  Widget _timelineStep(IconData icon, String title, String subtitle, String footer, Color color, bool showLine, {bool isPending = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, color: color, size: 28),
            if (showLine) Container(width: 2, height: 40, color: isPending ? Colors.grey.shade300 : color),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(footer, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }

  // --- 4. Acordeones (Expansion Tiles) ---
  Widget _buildInfoAccordions(Color primary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _customExpansionTile(primary, Icons.person, "Información del Cliente", [
            _infoRow("Nombre", "Juan Carlos Pérez", "Teléfono", "+502 4433-2211", primary),
            _infoRow("Email", "juan.perez@dominio.com", "", "", primary),
          ]),
          const SizedBox(height: 10),
          _customExpansionTile(primary, Icons.shield_moon, "Aseguradora y Empresa", [
            _infoRow("Compañía", "Seguros Universales S.A.", "Póliza", "POL-99283-A", primary),
          ]),
        ],
      ),
    );
  }

  Widget _customExpansionTile(Color primary, IconData icon, String title, List<Widget> children) {
    return Container(
      decoration: _cardDecoration(),
      child: ExpansionTile(
        leading: Icon(icon, color: primary),
        title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: children,
      ),
    );
  }

  Widget _infoRow(String label1, String value1, String label2, String value2, Color primary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: _infoItem(label1, value1, primary)),
          if (label2.isNotEmpty) Expanded(child: _infoItem(label2, value2, primary, isValuePrimary: true)),
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value, Color primary, {bool isValuePrimary = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isValuePrimary ? primary : Colors.black)),
      ],
    );
  }

  // --- 5. Notas ---
  Widget _buildNotesSection(Color primary) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("NOTAS DE SEGUIMIENTO", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                Icon(Icons.add_comment, color: primary, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            _noteItem("MA", "Mario Alfaro", "Hace 2h", "Se completó el desarme frontal. Se notificó a la aseguradora.", primary),
          ],
        ),
      ),
    );
  }

  Widget _noteItem(String initial, String name, String time, String body, Color primary) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 16, backgroundColor: primary.withOpacity(0.2), child: Text(initial, style: TextStyle(fontSize: 12, color: primary, fontWeight: FontWeight.bold))),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(body, style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
              ],
            ),
          ),
        )
      ],
    );
  }

  // --- Barra de Acción Inferior ---
  Widget _buildBottomActionBar(Color primary) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.sync),
              label: const Text("Actualizar Estado", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFF3F4F6)),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
      ],
    );
  }
}