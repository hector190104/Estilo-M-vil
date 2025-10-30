import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_colors.dart'; // Importar la paleta de colores central
import 'time_selection_screen.dart';
import 'string_extensions.dart';

// Enum para manejar los estados de disponibilidad del calendario
enum DayAvailability { available, limited, unavailable, none }

class DateSelectionScreen extends StatefulWidget {
  const DateSelectionScreen({super.key});

  @override
  State<DateSelectionScreen> createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  // --- MODIFICACIÓN: Estados de fecha ---
  late final DateTime _today;
  late DateTime _currentMonth;
  int? _selectedDay; // Día seleccionado (empieza nulo)
  // --- FIN MODIFICACIÓN ---

  // Datos de disponibilidad hardcodeados del mockup
  // En un app real, esto vendría de una API al cambiar de mes
  final Map<int, DayAvailability> _availability = {
    2: DayAvailability.available,
    3: DayAvailability.available,
    4: DayAvailability.limited,
    5: DayAvailability.available,
    6: DayAvailability.unavailable,
    7: DayAvailability.unavailable,
    8: DayAvailability.available,
    9: DayAvailability.available,
    10: DayAvailability.available,
    11: DayAvailability.limited,
    12: DayAvailability.available,
    13: DayAvailability.unavailable,
    14: DayAvailability.unavailable,
    15: DayAvailability.available,
    16: DayAvailability.available,
    17: DayAvailability.available,
    18: DayAvailability.limited,
    19: DayAvailability.available,
    20: DayAvailability.unavailable,
    21: DayAvailability.unavailable,
    22: DayAvailability.available,
    23: DayAvailability.available,
    24: DayAvailability.limited,
    25: DayAvailability.available,
    26: DayAvailability.available,
    27: DayAvailability.unavailable,
    28: DayAvailability.unavailable,
    29: DayAvailability.available,
    30: DayAvailability.available,
  };

  // --- MODIFICACIÓN: Añadir initState ---
  @override
  void initState() {
    super.initState();
    // Obtiene la fecha actual (sin horas/minutos)
    final now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
    // Inicializa el mes actual
    _currentMonth = DateTime(_today.year, _today.month);
  }
  // --- FIN MODIFICACIÓN ---

  // --- WIDGETS DE CONSTRUCCIÓN ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildProgressBar(),
              const SizedBox(height: 16),
              _buildStylistCard(),
              const SizedBox(height: 16),
              _buildMonthSelector(),
              const SizedBox(height: 16),
              _buildCalendarGrid(),
              const SizedBox(height: 24),
              _buildLegend(),
              const SizedBox(height: 24), // Espacio antes del final
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildContinueButton(),
    );
  }

  // --- PARTES DEL BODY ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.gray800),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Selecciona la fecha',
        style: TextStyle(
          color: AppColors.gray900,
          fontWeight: FontWeight.bold,
          fontSize: 20, // text-xl
        ),
      ),
      actions: const [
        SizedBox(width: 48), // Espacio para centrar el título (w-10)
      ],
    );
  }

  Widget _buildProgressBar() {
    const int currentStep = 3;
    const int totalSteps = 5;

    List<Color> colors = [
      AppColors.progressStep, // Paso 1
      AppColors.progressStep, // Paso 2
      AppColors.progressActive, // Paso 3 (activo)
      AppColors.gray200, // Paso 4
      AppColors.gray200, // Paso 5
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              return Expanded(
                child: Container(
                  height: 8, // h-2
                  margin:
                      EdgeInsets.only(right: index < totalSteps - 1 ? 4 : 0), // space-x-1
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(100), // rounded-full
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12), // mt-3
          Text.rich(
            TextSpan(
              text: 'Paso $currentStep de $totalSteps: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.progressStep,
              ),
              children: const [
                TextSpan(
                  text: 'Selección de fecha',
                  style: TextStyle(
                    color: AppColors.progressActive,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStylistCard() {
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: AppColors.gray50, // bg-gray-50
        borderRadius: BorderRadius.circular(8), // rounded-lg
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32, // w-16 h-16
            backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDtyiP3o7JyDSo2qyYo4lY3BHmyLuzDg1J2yBqopO7hJ61hq6UJA7t3ytCntU_EQ2nv_QxKSH6uJmhLewx7gnWpLB4g74m_cBuIMDVIF5DhwHrp4mR9JWjI3Uvbhc4kTM9-25q4EHU3z_spaR3JXYoIywXhye4UvAZr_pvp17vlQh-gfpuT9EBh2YdqbdJMeqB1a9BUnv6sN6_Y--2lrilJOHGfrTYgJcT-9qTeDemjpaemdAOoQqds5YqheKKX4gSI2oSOnDi6q3k'),
          ),
          const SizedBox(width: 16), // ml-4
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Carlos Mendoza',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray800,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Barbero Profesional',
                  style: TextStyle(
                    fontSize: 14, // text-sm
                    color: AppColors.gray600,
                  ),
                ),
                const SizedBox(height: 4), // mt-1
                Row(
                  children: const [
                    Icon(Icons.star, color: AppColors.yellowStar, size: 16),
                    SizedBox(width: 4), // ml-1
                    Text(
                      '4.9 (120 reseñas)',
                      style: TextStyle(
                        fontSize: 14, // text-sm
                        color: AppColors.gray600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    // Formatear el mes y año. Requiere 'intl' y 'es' locale.
    String monthName =
        DateFormat('MMMM yyyy', 'es').format(_currentMonth).capitalize();

    // --- MODIFICACIÓN: Deshabilitar botón de mes anterior ---
    final bool isCurrentMonth =
        _currentMonth.year == _today.year && _currentMonth.month == _today.month;
    // --- FIN MODIFICACIÓN ---

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          // --- MODIFICACIÓN: Lógica de deshabilitado ---
          icon: Icon(Icons.chevron_left,
              color: isCurrentMonth ? AppColors.gray300 : AppColors.gray600),
          onPressed: isCurrentMonth
              ? null // Deshabilitado si es el mes actual
              : () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month - 1);
                  });
                },
          // --- FIN MODIFICACIÓN ---
        ),
        // Esto simula el <select>
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              monthName,
              style: const TextStyle(
                fontSize: 18, // text-lg
                fontWeight: FontWeight.w600, // font-semibold
                color: AppColors.gray800,
              ),
            ),
            const Icon(Icons.expand_more, color: AppColors.gray600),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: AppColors.gray600),
          onPressed: () {
            setState(() {
              _currentMonth =
                  DateTime(_currentMonth.year, _currentMonth.month + 1);
            });
          },
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final List<String> daysOfWeek = ['D', 'L', 'M', 'M', 'J', 'V', 'S'];
    
    // --- MODIFICACIÓN: Cálculo dinámico de días y offset ---
    // (Domingo = 0, Lunes = 1, ... Sábado = 6)
    final int firstDayOffset =
        DateTime(_currentMonth.year, _currentMonth.month, 1).weekday % 7;
    final int daysInMonth =
        DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    // --- FIN MODIFICACIÓN ---

    // Crear las celdas de los días de la semana
    List<Widget> weekDayCells = daysOfWeek
        .map((day) => Center(
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 14, // text-sm
                  fontWeight: FontWeight.w500, // font-medium
                  color: AppColors.gray500,
                ),
              ),
            ))
        .toList();

    // Crear celdas vacías para el offset
    List<Widget> emptyCells =
        List.generate(firstDayOffset, (index) => Container());

    // Crear las celdas de los días
    List<Widget> dayCells = List.generate(daysInMonth, (index) {
      int day = index + 1;
      
      // --- MODIFICACIÓN: Lógica de validación ---
      final DateTime currentDate =
          DateTime(_currentMonth.year, _currentMonth.month, day);
      final bool isPastDay = currentDate.isBefore(_today);
      bool isSelected = _selectedDay == day;
      DayAvailability availability =
          _availability[day] ?? DayAvailability.none;
      Color textColor = AppColors.gray800;
      Color dotColor = Colors.transparent;
      bool isClickable = true;

      if (isPastDay) {
        textColor = AppColors.gray300; // Días pasados en gris claro
        isClickable = false;
      } else if (isSelected) {
        textColor = Colors.white;
      } else if (availability == DayAvailability.unavailable) {
        textColor = AppColors.gray500;
        dotColor = AppColors.dotUnavailable;
        isClickable = false;
      } else if (availability == DayAvailability.limited) {
        textColor = AppColors.gray800;
        dotColor = AppColors.dotLimited;
      } else if (availability == DayAvailability.available) {
        textColor = AppColors.gray800;
        dotColor = AppColors.dotAvailable;
      }
      // --- FIN MODIFICACIÓN ---

      // --- MODIFICACIÓN: Cambiado a InkWell para efecto ripple ---
      return InkWell(
        onTap: isClickable
            ? () {
                setState(() {
                  _selectedDay = day;
                });
              }
            : null,
        customBorder: const CircleBorder(),
        splashColor: AppColors.primary100.withOpacity(0.5), // Simula el hover:bg-red-100
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.red500 : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 14, // text-sm
                    color: textColor,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (dotColor != Colors.transparent && !isSelected)
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
      // --- FIN MODIFICACIÓN ---
    });

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2, // Ajustar para que no sea tan alto
      children: [
        ...weekDayCells,
        ...emptyCells,
        ...dayCells,
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem('Disponible', AppColors.legendAvailable),
        _buildLegendItem('Pocos turnos', AppColors.legendLimited),
        _buildLegendItem('No disponible', AppColors.legendUnavailable),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12, // w-3
          height: 12, // h-3
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8), // mr-2
        Text(
          text,
          style: const TextStyle(
            fontSize: 14, // text-sm
            color: AppColors.gray600,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    bool isEnabled = _selectedDay != null;

    // --- MODIFICACIÓN: Aplicar estilo con sombra y tamaño ---
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          // Sombra extraída de la pantalla de referencia
          boxShadow: [
            BoxShadow(
              // Usamos el color del botón con opacidad para la sombra
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          // El borderRadius es para que la sombra coincida con el botón
          borderRadius: BorderRadius.circular(12), // rounded-xl (era 12 en el HTML del footer)
        ),
        child: ElevatedButton(
          onPressed: isEnabled ? () {
            // Lógica al presionar Continuar
            // Por ejemplo, navegar a la siguiente pantalla
            if (_selectedDay != null) {
              final selectedDate = DateTime(
                _currentMonth.year,
                _currentMonth.month,
                _selectedDay!,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimeSelectionScreen(
                    selectedDate: selectedDate,
                  ),
                ),
              );
            }
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.progressActive, // bg-[#E63946]
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColors.gray300,
            minimumSize: const Size(double.infinity, 60), // <-- Altura de 60px
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // rounded-xl (era 12 en el HTML del footer)
            ),
            elevation: 0, // La sombra la maneja el Container exterior
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18, // <-- Tamaño de fuente 18
              fontFamily: 'Manrope', // Mantener la fuente
            ),
          ),
          child: const Text('Continuar'),
        ),
      ),
    );
    // --- FIN MODIFICACIÓN ---
  }
}