import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String userEmail;

  const ProfileScreen({super.key, required this.userEmail});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    String defaultName = widget.userEmail.split('@').first;
    _nameController = TextEditingController(text: defaultName.toUpperCase());
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const neonGreen = Color(0xFF00FF66);
    const neonCyan = Color(0xFF00E5FF);
    const darkBg = Color(0xFF0D0F14);
    const cardBg = Color(0xFF161922);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: const Text("Perfil de Agente Toku"),
        backgroundColor: cardBg,
        foregroundColor: neonGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- HEADER DE PERFIL ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: neonGreen.withOpacity(0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: neonGreen.withOpacity(0.08),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: neonGreen, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: neonGreen.withOpacity(0.3),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: darkBg,
                        child: Icon(Icons.person, size: 50, color: neonGreen),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: neonCyan,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.verified, size: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _nameController.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.userEmail,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: neonCyan.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: neonCyan.withOpacity(0.5)),
                    ),
                    child: const Text(
                      "ESTATUS: AGENTE Nivel 1",
                      style: TextStyle(
                        color: neonCyan,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- PANEL DE ESTADÍSTICAS ---
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: "PEDIDOS",
                    value: "${globalOrders.length}",
                    icon: Icons.receipt_long_rounded,
                    color: neonCyan,
                    cardBg: cardBg,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: "CARRITO",
                    value: "${globalCart.length}",
                    icon: Icons.shopping_cart_outlined,
                    color: neonGreen,
                    cardBg: cardBg,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: "ALERTAS",
                    value: "${globalNotifications.length}",
                    icon: Icons.notifications_none_rounded,
                    color: Colors.orangeAccent,
                    cardBg: cardBg,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- CONFIGURACIÓN DE CUENTA ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "AJUSTES DE CUENTA",
                    style: TextStyle(
                      color: neonGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.edit_outlined, color: neonCyan),
                    title: const Text("Nombre de Usuario", style: TextStyle(color: Colors.white, fontSize: 14)),
                    subtitle: Text(_nameController.text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
                    onTap: () => _showEditNameDialog(context, cardBg, neonGreen),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- PREFERENCIAS DE LA APLICACIÓN ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PREFERENCIAS",
                    style: TextStyle(
                      color: neonCyan,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: neonGreen,
                    title: const Text("Notificaciones Push", style: TextStyle(color: Colors.white, fontSize: 14)),
                    subtitle: const Text("Recibir alertas sobre compras y eventos", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    value: _notificationsEnabled,
                    onChanged: (val) {
                      setState(() {
                        _notificationsEnabled = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- BOTÓN DE CERRAR SESIÓN ---
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent, width: 1.5),
                  foregroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.exit_to_app_rounded),
                label: const Text(
                  "CERRAR SESIÓN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color cardBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showEditNameDialog(BuildContext context, Color cardBg, Color neonGreen) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardBg,
          title: const Text("Editar Nombre de Usuario", style: TextStyle(color: Colors.white, fontSize: 16)),
          content: TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00FF66))),
              hintText: "Escribe tu nuevo nombre",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCELAR", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nombre de usuario actualizado')),
                );
              },
              child: Text("GUARDAR", style: TextStyle(color: neonGreen, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}