import 'package:flutter/material.dart';
import 'service_selection_screen.dart';
import 'profile_screen.dart';
import 'appointments_screen.dart';
import 'app_colors.dart';
import 'notifications_screen.dart';
// ...existing code...
import 'settings_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _selectedIndex = 1;


  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const AppointmentsScreen();
      case 1:
        return const CatalogBody();
      case 2:
        return const ProfileScreen();
      default:
        return const CatalogBody();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Solo mostrar el AppBar en la pestaña de Catálogo (índice 1)
    PreferredSizeWidget? appBar;
    if (_selectedIndex == 1) {
      appBar = AppBar(
        automaticallyImplyLeading: true,
        elevation: 3,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_horizontal.png',
              height: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.gray700),
            tooltip: 'Notificaciones',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.gray700),
            tooltip: 'Configuración',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      );
    }
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: appBar,
      body: Center(
        child: _getScreen(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.progressActive,
        unselectedItemColor: AppColors.progressStep,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cut),
            label: 'Servicios'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CatalogBody extends StatelessWidget {
  const CatalogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar servicios...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Ofertas y Destacados',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                OfertaCard(
                  titulo: 'Paquete Completo',
                  descripcion: 'Corte + Afeitado + Manicura (20% OFF)',
                  imagenUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDNGbUOzJdmumnOgDV1S2wnOQczvUwogUDQ2kkZ7YUaPKjNojD2hGi6bmW8-S8iY8n_ILG4YLyuYImKgzZY3gDfvcZM4tB-g3x_DFdgA5yKdnQhhgg5Iy4Td9dqYfPtBd0lwUz7QhzPtJYLnd-pFuwWhqlAphV5uvd6w2hK2fbLa86GnSDvqbHGJR39xdt05SCdk6hw873nwVqBtF0hCVXU39PPawVJmxr6hsMQ2HX0btxZwCERkV1Zphtq8sJYrTfCW9WD_J5_TKw',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Catálogo de Servicios',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 4,
            children: const [
              ServicioCard(
                titulo: 'Corte de cabello',
                precio: '\$25',
                imagenUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAEiDfplfvVytMfZ5YJEdgRE9BlwQCRMzE6p-ooPxcYLlojqP52caHgLmXYnI6rWXUkzs1m6in2ioxn9wrOASFOaF3vGQxMCnot5_wah72n2OK959bw4SHV5rxMeWzg4roKb_qCtYsou-_HM6lvQiKkhg-9-DMcFm3F5MwW1KeoJ28QSrvrYX5r5bF_6Wr6G3_mY4_AVURqvJrdWa7doEi8uZiv_BETMhu7DXnIR3DvY5hmeEUlXUqJs57rMYqzalY34JLtRiy01FE',
              ),
              ServicioCard(
                titulo: 'Afeitado',
                precio: '\$15',
                imagenUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuApUuZArdcvR4Yt7Y4vfTxvmNupeZAZtVTBUUxNTc13yqWjk4_0R445uca9OZmdNAjK16aPc83N-nsfihmAuVh6S1qVammbtpCEbtmcgnVOKQ1BaLQjC_rjt-wXbe28_7RzeFpMx5ePwvjq8_nsVz_7a_5KN-wlepcSVEPnyHtIk2h10_qE7l74KRhngwcrHw9WULZOEdYAvph0bf4xBkfi2pFx54VKGNVSRAhDwP9XZHr46octEK4PPdtBGW-qbIRRuRIDb3JQCQ4',
              ),
              ServicioCard(
                titulo: 'Manicura',
                precio: '\$30',
                imagenUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCv9xuVzD0nxWmKOj0UmfybKbDWiNnQKNHfy67_e9ip5090dCpAsS-NZ9ihKSwwRslcGQWzP5tcdE5qQKvrXSgYWz6bh9mQhb6FAm9GWrzSvjHhyssUODVc_Az-DCndSx1YLM8Nv3t8PNf5fkxxIykcegnvwr719WrWaDq03Y-6kJ4guuPmIUYbJbBe1f04tSzo3cKgE0f-2yv9R3hMP--YbnierElp7x7qQk0NmTJ5zRyHKJw3fhQIBeoOrp1cXyeir0elz2111ow',
              ),
              ServicioCard(
                titulo: 'Maquillaje',
                precio: '\$40',
                imagenUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuApcNIweVr9rG2zwknjp5y3ovSAgdJV6QqoxtZ_3NwETg_3cx_26KFH2SODJrPuNsqWBaHDymnCI9ZOS3s2Lp0YAgXItemXm1DLvETbSLqi5OOQAtC7AgmMw0imOTvAH3Htf2H0MCJpsCK7rQEaOKQZVE1gspr-8ldjq-We-ejVjV9m9aFv0s9JdWLxt9UKZC_ytdF8wygQNwswfJLI6lxZVjPVqBO7N6yGtDaZ4s4rUWu03OzoYtsMwXgQ4M4dU5HdNwyVEd-pGtw',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OfertaCard extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final String imagenUrl;

  const OfertaCard({
    Key? key,
    required this.titulo,
    required this.descripcion,
    required this.imagenUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imagenUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.4),
        ),
        padding: const EdgeInsets.all(12),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              descripcion,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicioCard extends StatelessWidget {
  final String titulo;
  final String precio;
  final String imagenUrl;

  const ServicioCard({
    Key? key,
    required this.titulo,
    required this.precio,
    required this.imagenUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SeleccionServicioScreen()),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imagenUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    precio,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}