import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_colors.dart'; // Importar la paleta de colores central
import 'string_extensions.dart'; // Importar la extensión para capitalizar
import 'payment_method_screen.dart'; // Importar la pantalla de método de pago

// Modelo simple para representar un horario y su disponibilidad
class TimeSlot {
  final String time;
  final bool isAvailable;

  TimeSlot(this.time, {this.isAvailable = true});
}

class TimeSelectionScreen extends StatefulWidget {
  // --- AÑADIDO: Recibe la fecha seleccionada ---
  final DateTime selectedDate;

  const TimeSelectionScreen({super.key, required this.selectedDate});
  // --- FIN AÑADIDO ---

  @override
  State<TimeSelectionScreen> createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  String? _selectedTime; // Guarda la hora seleccionada (ej: "8:00 AM")

  // --- Listas de horarios basadas en el HTML ---
  final List<TimeSlot> morningTimes = [
    TimeSlot("8:00 AM"), TimeSlot("8:30 AM"),
    TimeSlot("9:00 AM"), TimeSlot("9:30 AM"),
    TimeSlot("10:00 AM", isAvailable: false), // Ocupado
    TimeSlot("10:30 AM"), TimeSlot("11:00 AM"), TimeSlot("11:30 AM"),
  ];

  final List<TimeSlot> afternoonTimes = [
    TimeSlot("12:00 PM"), TimeSlot("12:30 PM"),
    TimeSlot("1:00 PM"), TimeSlot("1:30 PM", isAvailable: false), // Ocupado
    TimeSlot("2:00 PM"), TimeSlot("2:30 PM"),
    TimeSlot("3:00 PM"), // Hora seleccionada en el mockup
    TimeSlot("3:30 PM"), TimeSlot("4:00 PM"), TimeSlot("4:30 PM"),
    TimeSlot("5:00 PM"), TimeSlot("5:30 PM"),
  ];

  final List<TimeSlot> eveningTimes = [
    TimeSlot("6:00 PM"), TimeSlot("6:30 PM", isAvailable: false), // Ocupado
    TimeSlot("7:00 PM"), TimeSlot("7:30 PM"),
  ];
  // --- Fin Listas ---

  @override
  void initState() {
    super.initState();
    // Preseleccionar la hora del mockup si existe en la lista
    if (afternoonTimes.any(
      (slot) => slot.time == "3:00 PM" && slot.isAvailable,
    )) {
      _selectedTime = "3:00 PM";
    }
  }

  // --- WIDGETS DE CONSTRUCCIÓN ---

  @override
  Widget build(BuildContext context) {
    // Formatear la fecha recibida
    // Requiere 'intl' y locale 'es' inicializado en main.dart
    final String formattedDate = DateFormat(
      'EEEE, d \'de\' MMMM',
      'es',
    ).format(widget.selectedDate).capitalize();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(formattedDate), // Pasar fecha formateada
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // p-4
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimeSection("Mañana", morningTimes),
              const SizedBox(height: 24), // space-y-6
              _buildTimeSection("Tarde", afternoonTimes),
              const SizedBox(height: 24), // space-y-6
              _buildTimeSection("Noche", eveningTimes),
              const SizedBox(height: 32), // mt-8 (espacio antes del botón)
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildContinueButton(),
    );
  }

  // --- PARTES DEL BODY ---

  PreferredSizeWidget _buildAppBar(String formattedDate) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1, // shadow-sm
      shadowColor: Colors.black.withOpacity(0.1),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.gray700,
        ), // Era arrow_back_ios en HTML
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Selecciona la hora',
        style: TextStyle(
          color: AppColors.gray900,
          fontWeight: FontWeight.bold,
          fontSize: 20, // text-xl
        ),
      ),
      actions: const [
        SizedBox(width: 48), // Espacio para centrar (w-8)
      ],
      // Barra de progreso y fecha debajo del título
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Altura ajustada
        child: Column(
          children: [
            _buildProgressBar(), // Barra de progreso dentro del AppBar
            Container(
              width: double.infinity,
              color: AppColors.gray100, // bg-gray-100
              padding: const EdgeInsets.symmetric(vertical: 12), // py-3
              child: Text(
                formattedDate, // Mostrar fecha seleccionada
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18, // text-lg
                  fontWeight: FontWeight.w600, // font-semibold
                  color: AppColors.gray800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Barra de progreso (Paso 4)
  Widget _buildProgressBar() {
    const int currentStep = 4; // <-- ACTUALIZADO A PASO 4
    const int totalSteps = 5;

    List<Color> colors = [
      AppColors.progressStep, // Paso 1
      AppColors.progressStep, // Paso 2
      AppColors.progressStep, // Paso 3
      AppColors.progressActive, // Paso 4 (activo)
      AppColors.gray200, // Paso 5
    ];

    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 16,
      ), // px-6 pb-4
      child: Column(
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              return Expanded(
                // --- MODIFICACIÓN: Quitado w-1/5, ahora es automático ---
                child: Container(
                  height: 8, // h-2
                  margin: EdgeInsets.only(
                    right: index < totalSteps - 1 ? 4 : 0,
                  ), // space-x-1
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(100), // rounded-full
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8), // mt-2
          Text.rich(
            TextSpan(
              // --- MODIFICACIÓN: Texto Paso 4 ---
              text: 'Paso $currentStep de $totalSteps: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14, // text-sm
                color: AppColors.progressStep,
              ),
              children: const [
                TextSpan(
                  text: 'Selección de hora', // Texto actualizado
                  style: TextStyle(color: AppColors.progressActive),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Sección de horarios (Mañana, Tarde, Noche)
  Widget _buildTimeSection(String title, List<TimeSlot> times) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18, // text-lg
            fontWeight: FontWeight.w600, // font-semibold
            color: AppColors.gray700,
          ),
        ),
        const SizedBox(height: 12), // mb-3
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // grid-cols-2
            crossAxisSpacing: 12, // gap-3
            mainAxisSpacing: 12, // gap-3
            childAspectRatio: 2.8, // Ajustar para altura similar al p-3
          ),
          itemCount: times.length,
          itemBuilder: (context, index) {
            final slot = times[index];
            return _buildTimeSlotButton(slot);
          },
        ),
      ],
    );
  }

  // Botón individual para cada horario
  Widget _buildTimeSlotButton(TimeSlot slot) {
    bool isSelected = _selectedTime == slot.time;

    // Estilo base
    Color borderColor = AppColors.gray300;
    Color backgroundColor = Colors.transparent;
    Color textColor = AppColors.gray800;
    FontWeight fontWeight = FontWeight.normal;
    double borderWidth = 1.0;

    // Estilo si está seleccionado
    if (isSelected) {
      borderColor = AppColors.progressActive; // border-[var(--primary-color)]
      backgroundColor = AppColors.primary50; // bg-red-50
      textColor = AppColors.progressActive; // text-[var(--primary-color)]
      fontWeight = FontWeight.w600; // font-semibold
      borderWidth = 2.0; // border-2
    }
    // Estilo si no está disponible
    else if (!slot.isAvailable) {
      borderColor = AppColors.gray200;
      backgroundColor = AppColors.gray100;
      textColor = AppColors.gray400;
    }

    return OutlinedButton(
      onPressed: slot.isAvailable
          ? () {
              setState(() {
                _selectedTime = slot.time;
              });
            }
          : null, // Deshabilitado si no está disponible
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor, // Color del texto y ripple
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12), // p-3 aproximado
        side: BorderSide(color: borderColor, width: borderWidth),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // rounded-lg
        ),
        textStyle: TextStyle(
          fontSize: 16, // text-base
          fontWeight: fontWeight,
          fontFamily: 'Manrope',
          // Añadir tachado si no está disponible
          decoration: !slot.isAvailable ? TextDecoration.lineThrough : null,
        ),
      ),
      child: Text(slot.time),
    );
  }

  // Botón Continuar (con sombra)
  Widget _buildContinueButton() {
    bool isEnabled = _selectedTime != null;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.progressActive.withOpacity(
                0.3,
              ), // shadow-red-500/30
              spreadRadius: 2, // Ajustado para parecerse más
              blurRadius: 10, // Ajustado para parecerse más
              offset: const Offset(0, 5), // Ajustado para parecerse más
            ),
          ],
          borderRadius: BorderRadius.circular(12), // rounded-xl
        ),
        child: ElevatedButton(
          // En time_selection_screen.dart -> _buildContinueButton -> onPressed:
          onPressed: isEnabled
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethodScreen(
                        selectedDate: widget.selectedDate,
                        selectedTime: _selectedTime!,
                        // --- PASAR ESTOS DATOS ---
                        serviceName:
                            "Corte de Cabello", // Ejemplo, debe venir de antes
                        employeeName:
                            "Carlos Mendoza", // Ejemplo, debe venir de antes
                        price: 35.0, // Ejemplo, debe venir de antes
                      ),
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.progressActive,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColors.gray300,
            minimumSize: const Size(
              double.infinity,
              60,
            ), // Ajustado para altura (py-4)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // rounded-xl
            ),
            elevation: 0, // La sombra está en el Container
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16, // text-base
              fontFamily: 'Manrope',
            ),
          ),
          child: const Text('Continuar'),
        ),
      ),
    );
  }
}
