import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const neonGreen = Color(0xFF00FF66);
    const neonCyan = Color(0xFF00E5FF);
    const darkBg = Color(0xFF0D0F14);
    const cardBg = Color(0xFF161922);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: cardBg,
        foregroundColor: neonGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display de Imagen / Icono de producto
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: neonGreen.withOpacity(0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: neonGreen.withOpacity(0.12),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(product.icon, size: 100, color: neonGreen),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: darkBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: neonCyan, width: 1),
                      ),
                      child: Text(
                        product.tag,
                        style: const TextStyle(
                          color: neonCyan,
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

            // Nombre y Precio
            Text(
              product.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  "PRECIO OFICIAL: ",
                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${product.price.toStringAsFixed(2)} MXN",
                  style: const TextStyle(
                    color: neonCyan,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Contenedor de Detalles
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "DETALLES DEL ARTÍCULO",
                    style: TextStyle(
                      color: neonGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Artículo oficial de colección edición limitada de la saga Tokusatsu / Kamen Rider. Incluye empaque especial de exhibición, certificado de autenticidad y acabados de alta calidad.",
                    style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                  ),
                  SizedBox(height: 12),
                  Divider(color: Colors.white10),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Disponibilidad: En Stock", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text("Envío: Inmediato", style: TextStyle(color: neonGreen, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Botón de Agregar al Carrito
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonGreen,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 8,
                  shadowColor: neonGreen.withOpacity(0.4),
                ),
                icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
                label: const Text(
                  'AGREGAR AL CARRITO',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 1),
                ),
                onPressed: () {
                  globalCart.add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} agregado al carrito'),
                      duration: const Duration(milliseconds: 800),
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