import 'package:flutter/material.dart';

class Ordenes10Page extends StatelessWidget {
  const Ordenes10Page({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF136dec);
    const bgColor = Color(0xFFf6f7f8);

    return Scaffold(
      backgroundColor: bgColor,
      // 1. App Bar con estilo Glassmorphism
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            const Icon(Icons.garage, color: primaryColor, size: 28),
            const SizedBox(width: 8),
            const Text(
              'BodyShop Pro',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle_outlined, color: Colors.black)),
        ],
      ),
      body: Column(
        children: [
          // 2. Buscador y Filtros
          _buildSearchAndFilters(primaryColor),
          
          // 3. Lista de Órdenes
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildOrderCard(
                  id: "OS-10245",
                  vehicle: "Nissan Versa 2019",
                  client: "Karla Fuente",
                  status: "En Proceso",
                  progress: 0.65,
                  statusColor: Colors.blue,
                  primaryColor: primaryColor,
                  footerLabel: "Factura Timbrada",
                  footerIcon: Icons.verified_user,
                  footerColor: Colors.green,
                ),
                _buildOrderCard(
                  id: "OS-10246",
                  vehicle: "Mazda 3 2021",
                  client: "Roberto Jiménez",
                  status: "Cotización",
                  progress: 0.10,
                  statusColor: Colors.orange,
                  primaryColor: primaryColor,
                  footerLabel: "Sin Facturar",
                  footerIcon: Icons.pending_actions,
                  footerColor: Colors.grey,
                  actionLabel: "Enviar Cotización",
                  actionIcon: Icons.send,
                ),
                _buildOrderCard(
                  id: "OS-10240",
                  vehicle: "Kia Rio 2018",
                  client: "Elena Martínez",
                  status: "Entregado",
                  progress: 1.0,
                  statusColor: Colors.green,
                  primaryColor: primaryColor,
                  footerLabel: "Pagado",
                  footerIcon: Icons.task_alt,
                  footerColor: Colors.green,
                  isOpacityReduced: true,
                ),
              ],
            ),
          ),
        ],
      ),
      // 4. Floating Action Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60), // Subir un poco por la barra de abajo
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
      // 5. Bottom Navigation Bar Estilo iOS
      bottomNavigationBar: _buildBottomNav(primaryColor),
    );
  }

  // --- Buscador y Chips ---
  Widget _buildSearchAndFilters(Color primary) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar por ID, cliente o vehículo',
              hintStyle: const TextStyle(color: Color(0xFF617289)),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF617289)),
              filled: true,
              fillColor: const Color(0xFFf6f7f8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip("Todos", isSelected: true, primary: primary),
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

  Widget _filterChip(String label, {bool isSelected = false, bool hasArrow = false, Color? primary}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade700,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          if (hasArrow) ...[
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey.shade600),
          ]
        ],
      ),
    );
  }

  // --- Tarjeta de Orden ---
  Widget _buildOrderCard({
    required String id,
    required String vehicle,
    required String client,
    required String status,
    required double progress,
    required Color statusColor,
    required Color primaryColor,
    required String footerLabel,
    required IconData footerIcon,
    required Color footerColor,
    String actionLabel = "Detalles",
    IconData actionIcon = Icons.arrow_forward_ios,
    bool isOpacityReduced = false,
  }) {
    return Opacity(
      opacity: isOpacityReduced ? 0.7 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha:0.02), blurRadius: 10, offset: const Offset(0, 4))],
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
                      Text("#$id", style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                      Text(vehicle, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(client, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),
              // Barra de Progreso
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Progreso", style: TextStyle(color: Colors.grey, fontSize: 11)),
                        Text("${(progress * 100).toInt()}%", style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade200,
                      color: statusColor,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: footerColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
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
                    label: Text(actionLabel, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    icon: Icon(actionIcon, size: 14),
                    style: TextButton.styleFrom(foregroundColor: primaryColor),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // --- Bottom Navigation ---
  Widget _buildBottomNav(Color primary) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
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