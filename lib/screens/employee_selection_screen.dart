import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'date_selection_screen.dart';
import 'app_colors.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
class Employee {
  final String name;
  final double rating;
  final String description;
  final String status;
  final String avatarUrl;
  final List<String> images;

  // Nuevos campos para coincidir con el diseño
  final IconData avatarStatusIcon;
  final Color avatarStatusColor;
  final IconData statusTextIcon;
  final Color statusTextColor;

  Employee({
    required this.name,
    required this.rating,
    required this.description,
    required this.status,
    required this.avatarUrl,
    required this.images,
    required this.avatarStatusIcon,
    required this.avatarStatusColor,
    required this.statusTextIcon,
    required this.statusTextColor,
  });
}
// --- FIN MODIFICACIÓN ---

enum SortOption { ratingDesc, ratingAsc, nameAsc, nameDesc }

enum FilterOption { all, available, busy }

class EmployeeSelectionScreen extends StatefulWidget {
  const EmployeeSelectionScreen({super.key});

  @override
  State<EmployeeSelectionScreen> createState() =>
      _EmployeeSelectionScreenState();
}

class _EmployeeSelectionScreenState extends State<EmployeeSelectionScreen> {
  int? selectedIndex;
  String searchText = '';
  SortOption? selectedSort;
  FilterOption selectedFilter = FilterOption.all;

  // --- MODIFICACIÓN: Lista de empleados actualizada con los nuevos campos ---
  final List<Employee> employees = [
    Employee(
      name: 'Sofía Ramírez',
      rating: 4.8,
      description:
          'Especialista en coloración y peinados modernos. Aporta creatividad y precisión a cada look.',
      status: 'Disponible',
      avatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuApDBuXUT7Gu1_GMMQuwP1JOGuTHlKn63p9yMlQ9QFrav8Q58jZ-Il-QHEmZpv9dr2ZOrx8g9UnOzsR0X_C_hFOOtTHrG5jc0_ROZooe582MuO18QjgVQC3YE58rZ7VdTd-VaJue8O5tj6esUi4d82RCUiKMcrVSF4a_l9sqtFHdflw0N8OfuMHVB2cwpQbchjA_BpFaCpHTj_EgD9ka4jsLJGWo6pkbVgEQCfLaUkl45nP-RJcv7ZVI4mTdnITblhpiOuPbcjP7d8',
      images: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
      ],
      avatarStatusIcon: Icons.check, // 'check'
      avatarStatusColor: AppColors.green500, // 'bg-green-500'
      statusTextIcon: Icons.check_circle, // 'check_circle'
      statusTextColor: AppColors.green700, // 'text-green-700'
    ),
    Employee(
      name: 'Carlos Mendoza',
      rating: 4.9,
      description:
          'Maestro barbero con experiencia en cortes clásicos y modernos. Perfeccionista y detallista.',
      status: 'Poca disponibilidad',
      avatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuANqIvjtXSPHBXsgDlAa0ZewSd73oey6RParTfBS0yOABB5oHjdxm9MHfMdKt-y0yZYdKtYGWI_ftG2bvrtDzfZgA09tdfaVeVbmqweFjaWn40fS8bNMdimDOQMf2JnVzBLcopfS-p1ajkyBvFFSIqR2EDDxfTSyzULtQK2CzepHuJOeft8QGvA7gRGzRTpYkrkkjsHeOAiTpGanEhtybckMyxS8JRpTgG6L1YTVNDpwJbG4Hup4axhf9EbRhDVSCIz5GE2ohzkEto',
      images: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
      ],
      avatarStatusIcon: Icons.schedule, // 'schedule'
      avatarStatusColor: AppColors.yellow500, // 'bg-yellow-500'
      statusTextIcon: Icons.history, // 'history'
      statusTextColor: AppColors.yellow700, // 'text-yellow-700'
    ),
    Employee(
      name: 'Isabel Torres',
      rating: 4.7,
      description:
          'Apasionada por las últimas tendencias. Ideal para quienes buscan un cambio de look atrevido.',
      status: 'No disponible',
      avatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCO3rnpH-NmlVcH8u9vRSg1uX8zNllpeoFwcgzHyCIV_o3HSa3CCA7hHTNhx6ZAGVfv_2PzoUSTK8FfGe8049lcU4eYVXBaRHoQhMWdgs1MVeP11eVKVynatI5cLPo2trs90L8oK5GVC-tE7kWSgc5J5WvvuPiTuV5aCt-TBiUaAmvvgI1MfoUL5tWsmq73h3T8KgqXAsqOieGM_rh77WvxyCx9oygfsO6Ri4bXpSt-grtRrVQzfgf9hA4qNnaQ0lgn0-QP7caYnXo',
      images: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD95-WUIsB2sRLHcrUIGv8YTa2v4paRoXPxGkK32GL5urQaI6Qei0vqess1_xxqOCOzbDcEpSQJUvy-cYIbrBsP7B92PWXwBl87sTZEeG-g8r11yhxGDxekw1k-Bf9gJd_ryOgX9OdZW_wpyCw9psmjy36VCLq4QxdhwfMaKIZL5k9nlaeT3L0rR7QNgHZnJ-XpM6hlOio2ZT40F9yhay4DeHZT2Tdp-5Sh4QUbB5Lyn9Rm6nlxfII-5UfKHOwh1N121lQ6k_eor78',
      ],
      avatarStatusIcon: Icons.close, // 'close'
      avatarStatusColor: AppColors.red500, // 'bg-red-500'
      statusTextIcon: Icons.cancel, // 'cancel'
      statusTextColor: AppColors.red700, // 'text-red-700'
    ),
  ];
  // --- FIN MODIFICACIÓN ---

  // La lógica de 'filteredEmployees' y 'showEmployeeDetails' no necesita cambios
  List<Employee> get filteredEmployees {
    List<Employee> list = employees.where((e) {
      final matchesSearch =
          e.name.toLowerCase().contains(searchText.toLowerCase()) ||
          e.description.toLowerCase().contains(searchText.toLowerCase());
      final matchesFilter =
          selectedFilter == FilterOption.all ||
          (selectedFilter == FilterOption.available &&
              e.status == 'Disponible') ||
          (selectedFilter == FilterOption.busy && e.status != 'Disponible');
      return matchesSearch && matchesFilter;
    }).toList();

    if (selectedSort != null) {
      switch (selectedSort!) {
        case SortOption.ratingDesc:
          list.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case SortOption.ratingAsc:
          list.sort((a, b) => a.rating.compareTo(b.rating));
          break;
        case SortOption.nameAsc:
          list.sort((a, b) => a.name.compareTo(b.name));
          break;
        case SortOption.nameDesc:
          list.sort((a, b) => b.name.compareTo(a.name));
          break;
      }
    }
    return list;
  }

  void showEmployeeDetails(Employee employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              employee.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RatingBarIndicator(
              rating: employee.rating,
              itemBuilder: (context, index) =>
                  const Icon(Icons.star, color: AppColors.yellowStar),
              itemCount: 5,
              itemSize: 24,
            ),
            const SizedBox(height: 12),
            Text(employee.description),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: employee.images
                    .map(
                      (url) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            url,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[300],
                                  width: 120,
                                  height: 120,
                                  child: const Icon(Icons.broken_image),
                                ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Tarjeta de empleado reconstruida ---
  Widget _employeeCard(Employee employee, int index) {
    bool isSelected = selectedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondary50 : Colors.white,
        borderRadius: BorderRadius.circular(8), // rounded-lg
        border: Border.all(
          color: isSelected ? AppColors.secondary500 : AppColors.gray200,
          width: isSelected ? 2.0 : 1.0, // ring-2
        ),
        // Sombra eliminada para coincidir con el mockup (solo la tarjeta "Any Stylist" tiene sombra)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          // Opcional: mostrar detalles al seleccionar
          // showEmployeeDetails(employee);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0), // p-4
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Fila Superior: Avatar, Info, Chevron/Check ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Avatar con Status ---
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28, // h-14 w-14 -> 56px / 2 = 28
                        backgroundColor: AppColors.gray200,
                        backgroundImage: NetworkImage(employee.avatarUrl),
                        onBackgroundImageError: (_, __) {},
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20, // size-5
                          height: 20, // size-5
                          decoration: BoxDecoration(
                            color:
                                employee.avatarStatusColor ??
                                AppColors
                                    .gray300, // <-- MODIFICACIÓN: Añadido valor por defecto
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            employee.avatarStatusIcon,
                            color: Colors.white,
                            size: 12, // style="font-size: 12px;"
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16), // gap-4
                  // --- Info (Nombre, Rating, Desc) y Status ---
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Fila: Nombre/Rating + Chevron ---
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // --- Columna: Nombre + Rating ---
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  employee.name,
                                  style: const TextStyle(
                                    color: AppColors.gray900,
                                    fontWeight:
                                        FontWeight.w600, // font-semibold
                                    fontSize:
                                        16, // Default, pero `font-semibold` le da peso
                                  ),
                                ),
                                const SizedBox(height: 2), // Ajuste visual
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: AppColors.yellowStar,
                                      size: 16, // style="font-size: 16px;"
                                    ),
                                    const SizedBox(width: 4), // gap-1
                                    Text(
                                      employee.rating.toString(),
                                      style: const TextStyle(
                                        color: AppColors.gray600,
                                        fontSize: 14, // text-sm
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // --- Icono de Estado (Chevron o Check) ---
                            Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.chevron_right,
                              color: isSelected
                                  ? AppColors.secondary500
                                  : AppColors.gray400,
                            ),
                          ],
                        ),
                        // --- Descripción ---
                        const SizedBox(height: 4), // mt-1
                        Text(
                          employee.description,
                          style: const TextStyle(
                            color: AppColors.gray500,
                            fontSize: 14, // text-sm
                          ),
                        ),
                        // --- Status (Texto) ---
                        const SizedBox(height: 8), // mt-2
                        Row(
                          children: [
                            Icon(
                              employee.statusTextIcon,
                              color:
                                  employee.statusTextColor ??
                                  AppColors
                                      .gray700, // <-- MODIFICACIÓN: Añadido valor por defecto
                              size: 18, // text-base
                            ),
                            const SizedBox(width: 4), // gap-1
                            Text(
                              employee.status,
                              style: TextStyle(
                                color:
                                    employee.statusTextColor ??
                                    AppColors
                                        .gray700, // <-- MODIFICACIÓN: Añadido valor por defecto
                                fontSize: 14, // text-sm
                                fontWeight: FontWeight.w500, // font-medium
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // gap-4 (de flex-col)
              // --- Fila Inferior: Galería de Imágenes ---
              SizedBox(
                height: 96, // h-24
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      employee.images.length + 1, // +1 para el botón "ver más"
                  itemBuilder: (context, imgIndex) {
                    // --- Botón "Ver Más" ---
                    if (imgIndex == employee.images.length) {
                      return InkWell(
                        onTap: () => showEmployeeDetails(employee),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 96, // w-24
                          height: 96, // h-24
                          margin: const EdgeInsets.only(right: 8), // gap-2
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : AppColors.gray100,
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // rounded-lg
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppColors.gray500,
                          ),
                        ),
                      );
                    }
                    // --- Imagen de la Galería ---
                    return Container(
                      margin: const EdgeInsets.only(right: 8), // gap-2
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8), // rounded-lg
                        child: Image.network(
                          employee.images[imgIndex],
                          width: 96, // w-24
                          height: 96, // h-24
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              width: 96,
                              height: 96,
                              color: AppColors.gray100,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 96,
                                height: 96,
                                color: AppColors.gray200,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: AppColors.gray400,
                                ),
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // --- FIN MODIFICACIÓN ---

  // --- Barra de progreso actualizada ---
  Widget _buildProgressBar() {
    const int currentStep = 2;
    const int totalSteps = 5;
    const String stepName = 'Selección de estilista';

    List<Color> colors = [
      AppColors.progressStep, // Paso 1 (completado)
      AppColors.progressActive, // Paso 2 (activo)
      AppColors.gray300, // Paso 3 (inactivo)
      AppColors.gray300, // Paso 4 (inactivo)
      AppColors.gray300, // Paso 5 (inactivo)
    ];

    return Column(
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            return Expanded(
              child: Container(
                height: 8, // h-2
                margin: EdgeInsets.only(
                  right: index < totalSteps - 1 ? 6 : 0,
                ), // gap-1.5
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(100), // rounded-full
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8), // space-y-2
        Text.rich(
          TextSpan(
            text: 'Paso $currentStep de $totalSteps: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold, // font-bold
              fontSize: 14, // text-sm
              color: AppColors.progressStep, // text-[#457B9D]
            ),
            children: const [
              TextSpan(
                text: stepName,
                style: TextStyle(
                  color: AppColors.progressActive, // text-[#E63946]
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Tarjeta "Cualquier estilista" actualizada ---
  Widget _buildAnyStylistCard() {
    bool isSelected = selectedIndex == -1;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary100 : AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary500,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = -1;
          });
        },
        borderRadius: BorderRadius.circular(10),
        splashColor: AppColors.primary200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary200,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.cut,
                  color: AppColors.primary500,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Cualquier estilista',
                      style: TextStyle(
                        color: AppColors.primary800,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Déjanos elegir al mejor para ti',
                      style: TextStyle(
                        color: AppColors.primary700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle : Icons.chevron_right,
                color: AppColors.primary500,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // --- FIN MODIFICACIÓN ---

  // --- Botones de Filtro/Orden ---
  Widget _buildFilterSortButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // justify-between
      children: [
        // --- Botón Filtrar ---
        TextButton.icon(
          onPressed: () async {
            // ... (lógica del showModalBottomSheet de filtro)
            final option = await showModalBottomSheet<FilterOption>(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Todos'),
                    onTap: () => Navigator.pop(context, FilterOption.all),
                  ),
                  ListTile(
                    title: const Text('Disponibles'),
                    onTap: () => Navigator.pop(context, FilterOption.available),
                  ),
                  ListTile(
                    title: const Text('No disponibles'),
                    onTap: () => Navigator.pop(context, FilterOption.busy),
                  ),
                ],
              ),
            );
            if (option != null) {
              setState(() {
                selectedFilter = option;
              });
            }
          },
          icon: const Icon(Icons.tune, size: 18), // 'tune', text-base
          label: const Text('Filtrar'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.gray700, // text-gray-700
            backgroundColor: Colors.transparent,
            shape: const StadiumBorder(), // rounded-full
            side: const BorderSide(
              color: AppColors.gray300,
            ), // border border-gray-300
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ), // px-3 py-1.5
            textStyle: const TextStyle(
              fontSize: 14, // text-sm
              fontWeight: FontWeight.w500, // font-medium
              fontFamily: 'Manrope', // Asegurarse de usar la fuente
            ),
          ),
        ),

        // --- Botón Ordenar por ---
        TextButton.icon(
          onPressed: () async {
            // ... (lógica del showModalBottomSheet de orden)
            final option = await showModalBottomSheet<SortOption>(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Rating descendente'),
                    onTap: () => Navigator.pop(context, SortOption.ratingDesc),
                  ),
                  ListTile(
                    title: const Text('Rating ascendente'),
                    onTap: () => Navigator.pop(context, SortOption.ratingAsc),
                  ),
                  ListTile(
                    title: const Text('Nombre A-Z'),
                    onTap: () => Navigator.pop(context, SortOption.nameAsc),
                  ),
                  ListTile(
                    title: const Text('Nombre Z-A'),
                    onTap: () => Navigator.pop(context, SortOption.nameDesc),
                  ),
                ],
              ),
            );
            if (option != null) {
              setState(() {
                selectedSort = option;
              });
            }
          },
          icon: const Icon(Icons.sort, size: 18), // 'sort', text-base
          label: const Text('Ordenar por'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.gray700,
            backgroundColor: Colors.transparent,
            shape: const StadiumBorder(),
            side: const BorderSide(color: AppColors.gray300),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Manrope',
            ),
          ),
        ),
      ],
    );
  }
  // --- FIN MODIFICACIÓN ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // bg-white
      // --- AppBar actualizada ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Selecciona un estilista',
          style: TextStyle(
            color: AppColors.gray900, // text-gray-900
            fontWeight: FontWeight.bold, // font-bold
            fontSize: 18, // text-lg
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new, // 'arrow_back_ios_new'
            color: Colors.black, // text-gray-800 (usamos negro sólido)
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          // Truco para centrar el título: un espacio en blanco
          // que coincida con el ancho del 'leading' IconButton.
          SizedBox(width: 48.0), // Reemplaza el 'w-8' del HTML
        ],
      ),
      // --- FIN MODIFICACIÓN ---
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0), // px-4 py-6
        child: Column(
          children: [
            _buildProgressBar(),
            const SizedBox(height: 24), // space-y-6
            TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar estilista o habilidad',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppColors.gray300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppColors.gray300),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            const SizedBox(height: 24), // space-y-6
            // --- MODIFICACIÓN: Orden de widgets ---
            _buildAnyStylistCard(),
            const SizedBox(height: 24), // space-y-6
            _buildFilterSortButtons(),
            const SizedBox(height: 16), // space-y-4 (para la lista)

            // --- FIN MODIFICACIÓN ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  bottom: 100,
                ), // Espacio para el footer
                itemCount: filteredEmployees.length,
                itemBuilder: (context, index) =>
                    _employeeCard(filteredEmployees[index], index),
              ),
            ),
          ],
        ),
      ),
      // --- MODIFICACIÓN: BottomNavBar actualizado al estilo de SeleccionServicioScreen ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: selectedIndex != null ? () {
              final appState = Provider.of<AppState>(context, listen: false);
              if (selectedIndex == -1) {
                appState.setTempEmployee('Cualquier estilista', '');
              } else if (selectedIndex! >= 0 && selectedIndex! < employees.length) {
                final selectedEmployee = employees[selectedIndex!];
                appState.setTempEmployee(selectedEmployee.name, selectedEmployee.avatarUrl);
              } else {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DateSelectionScreen(),
                ),
              );
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.progressActive,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.gray300,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Manrope',
              ),
            ),
            child: const Text('Continuar'),
          ),
        ),
      ),
      // --- FIN MODIFICACIÓN ---
    );
  }
}
