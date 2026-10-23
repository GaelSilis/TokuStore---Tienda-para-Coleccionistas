import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';
import 'event_detail_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart'; // Importación de la pantalla de perfil

// Modelos de datos globales
class Product {
  final String name;
  final double price;
  final IconData icon;
  final String tag;

  Product({
    required this.name,
    required this.price,
    required this.icon,
    this.tag = "OFICIAL",
  });
}

class OrderModel {
  final List<Product> items;
  final double total;
  final String date;

  OrderModel({required this.items, required this.total, required this.date});
}

class EventModel {
  final String title;
  final String category;
  final String date;
  final String location;
  final String description;
  final IconData icon;

  EventModel({
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.description,
    required this.icon,
  });
}

// Listas globales compartidas
List<Product> globalCart = [];
List<OrderModel> globalOrders = [];
List<String> globalNotifications = [];

// Catálogo compartido de Productos
final List<Product> globalProductsList = [
  Product(name: 'Figura Kamen Rider Zeztz', price: 899.00, icon: Icons.smart_toy, tag: 'NUEVO'),
  Product(name: 'Manga Kamen Rider Vol. 1', price: 249.00, icon: Icons.menu_book, tag: 'MANGA'),
  Product(name: 'DVD Box Set Serie Completa', price: 899.00, icon: Icons.disc_full, tag: 'EDICIÓN ESPECIAL'),
  Product(name: 'Cómic Edición Especial', price: 199.00, icon: Icons.auto_stories, tag: 'POPULAR'),
  Product(name: 'Cinturón Henshin Driver', price: 2499.00, icon: Icons.bolt, tag: 'TOP VENDEDOR'),
  Product(name: 'Figura Kamen Rider Geats', price: 1199.00, icon: Icons.sports_martial_arts, tag: 'LIMITADO'),
  Product(name: 'Casco Réplica Standard', price: 3500.00, icon: Icons.security, tag: 'COLECCIONABLE'),
  Product(name: 'Artbook Oficial Tokusatsu', price: 650.00, icon: Icons.photo_library, tag: 'ARTBOOK'),
  Product(name: 'Sound Track Original CD', price: 450.00, icon: Icons.audiotrack, tag: 'MÚSICA'),
  Product(name: 'Guanteletes Coleccionables', price: 799.00, icon: Icons.handshake, tag: 'ACCESORIO'),
  Product(name: 'Figura Kamen Rider Kuuga', price: 1399.00, icon: Icons.flash_on, tag: 'CLÁSICO'),
  Product(name: 'Manga Kamen Rider W Vol. 1', price: 269.00, icon: Icons.menu_book, tag: 'MANGA'),
  Product(name: 'Set Medallas OOO', price: 950.00, icon: Icons.radio_button_checked, tag: 'RARO'),
  Product(name: 'Llavero Logo Heroico', price: 120.00, icon: Icons.key, tag: 'EXTRAS'),
  Product(name: 'Póster Edición Limitada', price: 300.00, icon: Icons.image, tag: 'PÓSTER'),
  Product(name: 'Camiseta Oficial TokuStore', price: 399.00, icon: Icons.checkroom, tag: 'ROPA'),
];

// Lista compartida de Eventos
final List<EventModel> globalEventsList = [
  EventModel(
    title: 'Kamen Rider World Expo 2026',
    category: 'CONVENCIÓN',
    date: '15 de Noviembre, 2026',
    location: 'Centro de Convenciones Toku, CDMX',
    description: 'La convención más grande dedicada a Kamen Rider. Concursos de Cosplay, venta exclusiva de mercancía de Bandai Japón y firmas de autógrafos con actores invitados de las series.',
    icon: Icons.stars_rounded,
  ),
  EventModel(
    title: 'Comic-Con Tokusatsu Edition',
    category: 'COMIC-CON',
    date: '02 de Diciembre, 2026',
    location: 'Expo Santa Fe, México',
    description: 'Pabellón interactivo especial dedicado al universo Tokusatsu. Paneles de ilustración de manga, zonas de fotos con trajes a escala real y torneos de videojuegos de peleas.',
    icon: Icons.style,
  ),
  EventModel(
    title: 'Museo de Exhibición: Armaduras Heroicas',
    category: 'MUSEO EXPOSICIÓN',
    date: 'Del 10 al 20 de Enero, 2027',
    location: 'Galería de Arte Moderno y Cultura Pop',
    description: 'Muestra oficial de armaduras, props y cascos utilizados en las producciones originales de Kamen Rider Kuuga, Build y W. Una experiencia inmersiva con efectos de luces neón.',
    icon: Icons.museum_rounded,
  ),
  EventModel(
    title: 'Noche de Estreno: Kamen Rider Zeztz Special Movie',
    category: 'CINE Y ESTRENO',
    date: '28 de Febrero, 2027',
    location: 'CinePolis VIP Zona Toku',
    description: 'Proyección exclusiva en pantalla Imax de la nueva película especial de Kamen Rider Zeztz. Incluye combo coleccionable con palomitero temático y tarjeta conmemorativa.',
    icon: Icons.movie_filter_rounded,
  ),
];

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({super.key, required this.userEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CatalogView(),
    const EventsView(),
    const NotificationsView(),
    SearchScreenView(
      products: globalProductsList,
      events: globalEventsList,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const neonGreen = Color(0xFF00FF66);
    const neonCyan = Color(0xFF00E5FF);
    const darkBg = Color(0xFF0D0F14);
    const cardBg = Color(0xFF161922);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: const Text("TokuStore - Kamen Rider Zeztz"),
        backgroundColor: cardBg,
        foregroundColor: neonGreen,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  ).then((_) => setState(() {}));
                },
              ),
              if (globalCart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${globalCart.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: cardBg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Agente TokuStore", style: TextStyle(color: Colors.white)),
              accountEmail: Text(widget.userEmail, style: const TextStyle(color: Colors.white70)),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: darkBg,
                child: Icon(Icons.person, size: 40, color: neonGreen),
              ),
              decoration: const BoxDecoration(color: darkBg),
            ),
            // OPCIÓN DE PERFIL AÑADIDA ARRIBA DE MIS PEDIDOS
            ListTile(
              leading: const Icon(Icons.person_outline_rounded, color: neonGreen),
              title: const Text('Mi Perfil', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(userEmail: widget.userEmail),
                  ),
                ).then((_) => setState(() {}));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long, color: neonCyan),
              title: const Text('Mis Pedidos', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrdersView()),
                ).then((_) => setState(() {}));
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
              title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.redAccent)),
              onTap: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: cardBg,
        selectedItemColor: neonGreen,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Catálogo'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventos'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notificaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Búsqueda'),
        ],
      ),
    );
  }
}

// --- VISTA DE CATÁLOGO ---
class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  @override
  Widget build(BuildContext context) {
    const neonGreen = Color(0xFF00FF66);
    const neonCyan = Color(0xFF00E5FF);
    const cardBg = Color(0xFF161922);
    const darkBg = Color(0xFF0D0F14);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cardBg, neonGreen.withOpacity(0.08)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: neonGreen.withOpacity(0.4), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: neonGreen.withOpacity(0.1),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: darkBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: neonGreen, width: 1.5),
                  ),
                  child: const Icon(Icons.grid_view_rounded, color: neonGreen, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "CATÁLOGO GENERAL",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: const [
                          Icon(Icons.stars_rounded, color: neonCyan, size: 13),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "Figuras, Mangas, Cómics y Coleccionables",
                              style: TextStyle(
                                color: neonCyan,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: globalProductsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = globalProductsList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: neonGreen.withOpacity(0.25), width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: neonGreen.withOpacity(0.04),
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(product: product),
                                ),
                              ).then((_) => setState(() {}));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: darkBg,
                                  child: Center(
                                    child: Icon(
                                      product.icon,
                                      size: 52,
                                      color: neonGreen,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: cardBg.withOpacity(0.85),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: neonCyan.withOpacity(0.6), width: 0.8),
                                    ),
                                    child: Text(
                                      product.tag,
                                      style: const TextStyle(
                                        color: neonCyan,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(product: product),
                                    ),
                                  ).then((_) => setState(() {}));
                                },
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "PRECIO",
                                        style: TextStyle(color: Colors.grey, fontSize: 8, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\$${product.price.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          color: neonCyan,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        globalCart.add(product);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${product.name} agregado al carrito'),
                                          duration: const Duration(milliseconds: 600),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: neonGreen.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: neonGreen, width: 1.2),
                                      ),
                                      child: const Icon(
                                        Icons.add_shopping_cart_rounded,
                                        size: 18,
                                        color: neonGreen,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- VISTA DE EVENTOS ---
class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFF161922);
    const darkBg = Color(0xFF0D0F14);
    const neonCyan = Color(0xFF00E5FF);
    const neonGreen = Color(0xFF00FF66);

    return Container(
      color: darkBg,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.event_available, color: neonCyan, size: 22),
              SizedBox(width: 8),
              Text(
                "Próximos Eventos & Exposiciones",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.8),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              itemCount: globalEventsList.length,
              itemBuilder: (context, index) {
                final event = globalEventsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailScreen(event: event),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: neonCyan.withOpacity(0.35), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: neonCyan.withOpacity(0.06),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: neonCyan.withOpacity(0.12),
                              shape: BoxShape.circle,
                              border: Border.all(color: neonCyan.withOpacity(0.5)),
                            ),
                            child: Icon(event.icon, color: neonCyan, size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: darkBg,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: neonGreen.withOpacity(0.6), width: 0.8),
                                  ),
                                  child: Text(
                                    event.category,
                                    style: const TextStyle(color: neonGreen, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.6),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  event.title,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month_outlined, size: 12, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(event.date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, size: 12, color: neonCyan),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        event.location,
                                        style: const TextStyle(color: Colors.white60, fontSize: 11),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 14),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- VISTA DE NOTIFICACIONES ---
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFF161922);
    const darkBg = Color(0xFF0D0F14);
    const neonGreen = Color(0xFF00FF66);

    return Container(
      color: darkBg,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.notifications_active_outlined, color: neonGreen, size: 22),
              SizedBox(width: 8),
              Text(
                "Centro de Alertas",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Expanded(
            child: globalNotifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_rounded, size: 64, color: Colors.grey[800]),
                        const SizedBox(height: 12),
                        const Text("No hay notificaciones recientes", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: globalNotifications.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: neonGreen.withOpacity(0.4), width: 1.2),
                          boxShadow: [
                            BoxShadow(
                              color: neonGreen.withOpacity(0.06),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: neonGreen.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: neonGreen.withOpacity(0.5)),
                                ),
                                child: const Icon(Icons.bolt, color: neonGreen, size: 20),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "ESTADO DE COMPRA",
                                      style: TextStyle(color: neonGreen, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      globalNotifications[index],
                                      style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Icon(Icons.access_time_rounded, size: 12, color: Colors.grey),
                                        SizedBox(width: 4),
                                        Text("Transacción Segura ZEZTZ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// --- VISTA DE MIS PEDIDOS ---
class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0D0F14);
    const cardBg = Color(0xFF161922);
    const neonCyan = Color(0xFF00E5FF);
    const neonGreen = Color(0xFF00FF66);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: const Text("Mis Pedidos Registrados"),
        backgroundColor: cardBg,
        foregroundColor: neonCyan,
      ),
      body: globalOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_rounded, size: 64, color: Colors.grey[800]),
                  const SizedBox(height: 12),
                  const Text("Aún no cuentas con pedidos activos", style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: globalOrders.length,
              itemBuilder: (context, index) {
                final order = globalOrders[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: neonCyan.withOpacity(0.4), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: neonCyan.withOpacity(0.08),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: neonCyan.withOpacity(0.06),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          border: Border(bottom: BorderSide(color: neonCyan.withOpacity(0.2))),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.confirmation_number_outlined, color: neonCyan, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  "PEDIDO #0${index + 1}",
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: neonGreen.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: neonGreen.withOpacity(0.5)),
                              ),
                              child: const Text(
                                "PROCESADO",
                                style: TextStyle(color: neonGreen, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                                const SizedBox(width: 6),
                                Text("Fecha: ${order.date}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...order.items.map((item) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Icon(item.icon, size: 16, color: neonGreen),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        "\$${item.price.toStringAsFixed(2)}",
                                        style: const TextStyle(color: Colors.white60, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                )),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Divider(color: Colors.white12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("TOTAL PAGADO", style: TextStyle(color: Colors.grey, fontSize: 9, letterSpacing: 1)),
                                    const SizedBox(height: 2),
                                    Text(
                                      "\$${order.total.toStringAsFixed(2)} MXN",
                                      style: const TextStyle(color: neonCyan, fontWeight: FontWeight.w900, fontSize: 16),
                                    ),
                                  ],
                                ),
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.redAccent, width: 1.2),
                                    foregroundColor: Colors.redAccent,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  icon: const Icon(Icons.cancel_outlined, size: 16),
                                  label: const Text("Cancelar", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    setState(() {
                                      globalOrders.removeAt(index);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Pedido cancelado correctamente')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}