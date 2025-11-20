import 'package:flutter/material.dart';
import 'employee_selection_screen.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class SeleccionServicioScreen extends StatefulWidget {
  const SeleccionServicioScreen({super.key});

  @override
  State<SeleccionServicioScreen> createState() => _SeleccionServicioScreenState();
}

class _SeleccionServicioScreenState extends State<SeleccionServicioScreen> {
  int? selectedServiceIndex;
  final List<Map<String, dynamic>> services = [
    {
      'title': 'Corte de cabello',
      'description': 'Corte de cabello personalizado con estilo moderno.',
       'price': 25,
      'label': 'Popular',
      'labelColor': Colors.redAccent,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAns2FGaXuO08xqVaHxoLGvq_RrX2CznfCr4f06dx98JgBNvD2OQU3ZmNyuiZ5vyZ3wpmy0WjbCOwarPapqIo85wAMMXMl_N8J8ypsX7TiOq4CHVGY54-wde0kY-6vg6T-cPhOi2Tpdtvhpxsu6HuZVYFdMvDyiXSo9MfatZvCr5GbSB_4oXEH7til5Ts0uWdD5n3ZbfdRmonqGaZU_ozofJXa_1MhGWJMjv2aSGU20D6Un1PFRFw1YHm6upUFC8FJYrJpv02C8rc8',
    },
    {
      'title': 'Afeitado',
      'description': 'Afeitado clásico con toallas calientes y productos premium.',
       'price': 20,
      'label': null,
      'labelColor': null,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBUov4KFg4uw8ubOQVxfYYTHItBvAGMOqw2N7h6y3zCMAec4XRf2Gf7a0EY3Bx1vcQSDxRRhw_t3DXM4HuS4meOs-Cl1MguzKa6hC7WsVx2kwnlR4fqsSW7fKKf4thrbuwCASx2B7pP2lfjMXPK3rs-Fd8Cu5W9ED2X-lYB-6EjvsQpLFs-ljdn6kocwYhQIZGlA_Phb81aVC_hOXliF5b83LCFd1YpElJuJ1KcTuLGFYvT703g5UO8izNRT9WGV7mgwnRr23KMwz4',
    },
    {
      'title': 'Corte y afeitado',
      'description': 'Corte y afeitado combinados para un look completo.',
       'price': 40,
      'label': 'Recomendado',
      'labelColor': Colors.blueAccent,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBB-FUixrRyvEpa8UPaXnJMAD-GwgOZxMsOoCS3CLUZNkTXacWSM0fIKIgGPDYrQoxA65Lxo1N_7180BuNwtfs23IRHCXsWNtPmJv8_QVL7uGI74iOABHAkO0JsXFfVYUQmcH1BhVYVAFWuM3KPJeE5dqZ6x0SRDJ8RD_dzjYF1xRpURoLwiyCjrKUyNGZbQ1QNWKtFPHBm07TcJCaFLYGEKqBG2nNIUaIy9sKgZkMqo8mGEcxMen7aQydB8ifrF5HhfVsNQQGSfmU',
    },
    {
      'title': 'Tratamiento facial',
      'description': 'Tratamiento facial relajante con productos naturales.',
       'price': 30,
      'label': null,
      'labelColor': null,
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBkvMuAZt485ykrynDbFQ4T7I2kRMCmTic4eKHZfb_NedICuK5MqWFGfhDjipjlOz5AVA_bcuC8U2evy8Eyd25bdofAVyooEvswOMSHGbp-1Nz64UioWwvj-KcuF7qFVP0CMnN1VymUuTycQUvIX15oxGQEb9IzfB8bryL-MQXxY1euGi5Dz4Xo7iaKwi120dParT703CZcEUMqD2Nl5MDd0fGDyX9oVlbHHvRCRjf0t0sIljNpxPS1KgDDGgQYL6ymj5i1SQpRADw',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Selecciona un servicio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _progressIndicator(),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar servicios...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _filterChip('Todos', true),
                  _filterChip('Cortes', false),
                  _filterChip('Barbería', false),
                  _filterChip('Faciales', false),
                  _filterChip('Populares', false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Lista de servicios (tipo radio)
            ...List.generate(services.length, (index) {
              final s = services[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedServiceIndex = index;
                  });
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      s['imageUrl'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (s['label'] != null)
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: (s['labelColor'] as Color?)?.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          s['label'],
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      s['title'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      s['description'],
                                      style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.3),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                        '\$${s['price']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Radio<int>(
                          value: index,
                          groupValue: selectedServiceIndex,
                          onChanged: (val) {
                            setState(() {
                              selectedServiceIndex = val;
                            });
                          },
                          activeColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: selectedServiceIndex != null ? () {
              final s = services[selectedServiceIndex!];
              final appState = Provider.of<AppState>(context, listen: false);
              final priceValue = double.tryParse(s['price'].toString()) ?? 0.0;
              appState.setTempService(s['title'], priceValue);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmployeeSelectionScreen(),
                ),
              );
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              minimumSize: const Size(double.infinity, 60),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              shadowColor: Colors.redAccent.withOpacity(0.3),
            ),
            child: const Text(
              'Continuar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Indicador de progreso
  Widget _progressIndicator() {
    return Column(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Expanded(
              child: Container(
                height: 6,
                margin: EdgeInsets.only(right: index < 4 ? 4 : 0),
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.redAccent : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        const Text.rich(
          TextSpan(
            text: 'Paso 1 de 5: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: 'Selección de Servicio',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Chips de filtro
  Widget _filterChip(String label, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {},
        backgroundColor: Colors.grey[100],
        selectedColor: Colors.redAccent,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.grey[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Tarjeta de servicio con botón a la derecha y centrado
  Widget _serviceCard({
    required String title,
    required String description,
    required String price,
    required String imageUrl,
    String? label,
    Color? labelColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen y descripción
            Expanded(
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (label != null)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: labelColor?.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              label,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 13, height: 1.3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          price,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Botón "+"
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    // Guardar selección en AppState
                    final appState = Provider.of<AppState>(context, listen: false);
                    final priceValue = double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
                    appState.setTempService(title, priceValue);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmployeeSelectionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
