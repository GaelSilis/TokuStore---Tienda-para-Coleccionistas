import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'product_detail_screen.dart';
import 'event_detail_screen.dart';

class SearchScreenView extends StatefulWidget {
  final List<Product> products;
  final List<EventModel> events;

  const SearchScreenView({
    super.key,
    required this.products,
    required this.events,
  });

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0D0F14);
    const cardBg = Color(0xFF161922);
    const neonCyan = Color(0xFF00E5FF);
    const neonGreen = Color(0xFF00FF66);

    // Filtrar Productos
    final filteredProducts = widget.products.where((p) {
      return p.name.toLowerCase().contains(_query.toLowerCase()) ||
          p.tag.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    // Filtrar Eventos
    final filteredEvents = widget.events.where((e) {
      return e.title.toLowerCase().contains(_query.toLowerCase()) ||
          e.category.toLowerCase().contains(_query.toLowerCase()) ||
          e.location.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    // Filtrar Notificaciones
    final filteredNotifications = globalNotifications.where((n) {
      return n.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    bool hasResults = filteredProducts.isNotEmpty ||
        filteredEvents.isNotEmpty ||
        filteredNotifications.isNotEmpty;

    return Container(
      color: darkBg,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo de Búsqueda Estilizado
          Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: neonCyan.withOpacity(0.5), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: neonCyan.withOpacity(0.08),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Buscar productos, eventos, alertas...",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search_rounded, color: neonCyan),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _query = "";
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Resultados
          Expanded(
            child: _query.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.manage_search_rounded, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          "Escribe para buscar en TokuStore",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : !hasResults
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.search_off_rounded, size: 64, color: Colors.redAccent),
                            SizedBox(height: 12),
                            Text(
                              "No se encontraron coincidencias",
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        children: [
                          // Sección de Productos Coincidentes
                          if (filteredProducts.isNotEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "PRODUCTOS ENCONTRADOS",
                                style: TextStyle(color: neonGreen, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                              ),
                            ),
                            ...filteredProducts.map((product) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: neonGreen.withOpacity(0.3)),
                                  ),
                                  child: ListTile(
                                    leading: Icon(product.icon, color: neonGreen),
                                    title: Text(product.name, style: const TextStyle(color: Colors.white, fontSize: 14)),
                                    subtitle: Text("\$${product.price.toStringAsFixed(2)} MXN", style: const TextStyle(color: neonCyan, fontSize: 12)),
                                    trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 14),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailScreen(product: product),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                          ],

                          // Sección de Eventos Coincidentes
                          if (filteredEvents.isNotEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "EVENTOS Y PRÓXIMAS EXPOSICIONES",
                                style: TextStyle(color: neonCyan, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                              ),
                            ),
                            ...filteredEvents.map((event) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: neonCyan.withOpacity(0.3)),
                                  ),
                                  child: ListTile(
                                    leading: Icon(event.icon, color: neonCyan),
                                    title: Text(event.title, style: const TextStyle(color: Colors.white, fontSize: 14)),
                                    subtitle: Text(event.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 14),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EventDetailScreen(event: event),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                          ],

                          // Sección de Notificaciones Coincidentes
                          if (filteredNotifications.isNotEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "NOTIFICACIONES Y ALERTAS",
                                style: TextStyle(color: Colors.orangeAccent, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                              ),
                            ),
                            ...filteredNotifications.map((notif) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(Icons.notifications_active_outlined, color: Colors.orangeAccent),
                                    title: Text(notif, style: const TextStyle(color: Colors.white, fontSize: 13)),
                                    subtitle: const Text("Alerta de sistema", style: TextStyle(color: Colors.grey, fontSize: 11)),
                                  ),
                                )),
                          ],
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}