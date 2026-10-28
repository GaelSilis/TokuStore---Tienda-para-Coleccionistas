import 'package:flutter/material.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    const neonGreen = Color(0xFF00FF66);
    const neonCyan = Color(0xFF00E5FF);
    const darkBg = Color(0xFF0D0F14);
    const cardBg = Color(0xFF161922);

    double total = globalCart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: const Text("Carrito de Compras"),
        backgroundColor: cardBg,
        foregroundColor: neonGreen,
      ),
      body: globalCart.isEmpty
          ? const Center(
              child: Text(
                "Tu carrito está vacío",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: globalCart.length,
                    itemBuilder: (context, index) {
                      final item = globalCart[index];
                      return Card(
                        color: cardBg,
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: Icon(item.icon, color: neonGreen),
                          title: Text(item.name, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                            "\$${item.price.toStringAsFixed(2)} MXN",
                            style: const TextStyle(color: neonCyan),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              setState(() {
                                globalCart.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: cardBg,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$${total.toStringAsFixed(2)} MXN",
                            style: const TextStyle(color: neonGreen, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: neonGreen,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: cardBg,
                                title: const Text("Confirmar Compra", style: TextStyle(color: neonGreen)),
                                content: Text(
                                  "¿Deseas confirmar tu pago por un total de \$${total.toStringAsFixed(2)} MXN?",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("CANCELAR", style: TextStyle(color: Colors.grey)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // 1. Guardar la lista de productos comprados en un nuevo pedido
                                      List<Product> purchasedItems = List.from(globalCart);
                                      globalOrders.add(OrderModel(
                                        items: purchasedItems,
                                        total: total,
                                        date: DateTime.now().toString().substring(0, 16),
                                      ));

                                      
                                      globalNotifications.add(
                                        "¡Compra exitosa! Total: \$${total.toStringAsFixed(2)} MXN. Revisa 'Mis Pedidos'."
                                      );

                                      
                                      globalCart.clear();
                                      
                                      Navigator.pop(context); 
                                      Navigator.pop(context); 
                                      setState(() {});
                                      
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('¡Compra confirmada con éxito!')),
                                      );
                                    },
                                    child: const Text(
                                      "CONFIRMAR",
                                      style: TextStyle(color: neonGreen, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            'CONFIRMAR COMPRA',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}