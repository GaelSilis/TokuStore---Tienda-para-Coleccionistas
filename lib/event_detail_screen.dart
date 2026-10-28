import 'package:flutter/material.dart';
import 'home_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    const neonGreen = Color(0xFF00FF66);
    const neonCyan = Color(0xFF00E5FF);
    const darkBg = Color(0xFF0D0F14);
    const cardBg = Color(0xFF161922);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: Text(event.title),
        backgroundColor: cardBg,
        foregroundColor: neonCyan,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: neonCyan.withOpacity(0.5), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: neonCyan.withOpacity(0.12),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(event.icon, size: 90, color: neonCyan),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: darkBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: neonGreen, width: 1),
                      ),
                      child: Text(
                        event.category,
                        style: const TextStyle(
                          color: neonGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            
            Text(
              event.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, color: neonCyan, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        "Fecha: ${event.date}",
                        style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: neonGreen, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Lugar: ${event.location}",
                          style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "DETALLES Y AGENDA DEL EVENTO",
                    style: TextStyle(
                      color: neonCyan,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Acceso: Boleto Digital", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text("Estatus: Entradas Disponibles", style: TextStyle(color: neonGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonCyan,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 8,
                  shadowColor: neonCyan.withOpacity(0.4),
                ),
                icon: const Icon(Icons.confirmation_number_outlined, color: Colors.black),
                label: const Text(
                  'CONFIRMAR ASISTENCIA / REGISTRO',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.8),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('¡Te has registrado con éxito a "${event.title}"!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}