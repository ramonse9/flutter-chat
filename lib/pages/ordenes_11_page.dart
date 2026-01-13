import 'package:flutter/material.dart';

class Ordenes11Page extends StatelessWidget {
  const Ordenes11Page({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF136dec);
    const bgColor = Color(0xFFf6f7f8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.garage, color: primaryColor, size: 28),
            SizedBox(width: 8),
            Text('BodyShop Pro',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle_outlined, color: Colors.black)),
        ],
      ),
      body: Column(
        children: [
          _buildHeaderSearch(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildOrderCard(
                  id: "OS-10245",
                  vehicle: "Nissan Versa 2019",
                  client: "Karla Fuente",
                  status: "En Proceso",
                  statusColor: Colors.blue,
                  concepts: {
                    "Faro delantero": 1450.00,
                    "Pintura costado": 2800.00,
                    "Alineación": 650.00,
                  },
                  footerIcon: Icons.verified_user,
                  footerLabel: "Factura Timbrada",
                  footerColor: Colors.green,
                  actionLabel: "Detalles",
                  actionIcon: Icons.arrow_forward_ios,
                ),
                _buildOrderCard(
                  id: "OS-10246",
                  vehicle: "Nissan Versa 2019",
                  client: "Roberto Jiménez",
                  status: "Cotización",
                  statusColor: Colors.orange,
                  concepts: {
                    "Espejo lateral": 1200.00,
                    "Mano de obra": 450.00,
                  },
                  footerIcon: Icons.pending_actions,
                  footerLabel: "Sin Facturar",
                  footerColor: Colors.grey,
                  actionLabel: "Enviar",
                  actionIcon: Icons.send,
                ),
                _buildOrderCard(
                  id: "OS-10240",
                  vehicle: "Nissan Versa 2019",
                  client: "Elena Martínez",
                  status: "Entregado",
                  statusColor: Colors.green,
                  concepts: {
                    "Pulido general": 2100.00,
                    "Lavado de vestiduras": 1200.00,
                  },
                  footerIcon: Icons.task_alt,
                  footerLabel: "Pagado",
                  footerColor: Colors.green,
                  actionLabel: "Historial",
                  actionIcon: Icons.history,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(primaryColor),
    );
  }

  // --- Buscador y Filtros ---
  Widget _buildHeaderSearch() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar por ID, cliente o vehículo',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFFf6f7f8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip("Todos", isSelected: true),
                _filterChip("Cotización", hasArrow: true),
                _filterChip("En Proceso", hasArrow: true),
                _filterChip("Entregado"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _filterChip(String label, {bool isSelected = false, bool hasArrow = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF136dec) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
          if (hasArrow) Icon(Icons.keyboard_arrow_down, size: 16, color: isSelected ? Colors.white : Colors.grey),
        ],
      ),
    );
  }

  // --- Tarjeta de Orden con Conceptos ---
  Widget _buildOrderCard({
    required String id,
    required String vehicle,
    required String client,
    required String status,
    required Color statusColor,
    required Map<String, double> concepts,
    required IconData footerIcon,
    required String footerLabel,
    required Color footerColor,
    required String actionLabel,
    required IconData actionIcon,
  }) {
    double total = concepts.values.fold(0, (sum, item) => sum + item);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha:0.02), blurRadius: 10)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("#$id", style: const TextStyle(color: Color(0xFF136dec), fontSize: 11, fontWeight: FontWeight.bold)),
                    Text(vehicle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha:0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(client, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 12),
            // Área de Conceptos
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFf6f7f8).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Column(
                children: [
                  ...concepts.entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.key, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            Text("\$${e.value.toStringAsFixed(2)}", style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      )),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("TOTAL", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      Text("\$${total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Footer de la tarjeta
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: footerColor.withValues(alpha:0.1), borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: [
                      Icon(footerIcon, size: 14, color: footerColor),
                      const SizedBox(width: 4),
                      Text(footerLabel, style: TextStyle(color: footerColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Text(actionLabel, style: const TextStyle(color: Color(0xFF136dec), fontWeight: FontWeight.bold, fontSize: 13)),
                  label: Icon(actionIcon, size: 14, color: const Color(0xFF136dec)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(Color primary) {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Órdenes'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Inventario'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Ajustes'),
        ],
      ),
    );
  }
}