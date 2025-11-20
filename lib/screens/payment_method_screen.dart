import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'app_colors.dart'; // Importar la paleta de colores central
import 'string_extensions.dart'; // Importar extensión capitalize
import 'confirmation_screen.dart'; // Importar la pantalla de confirmación final
import '../app_state.dart';

// Enum para representar los métodos de pago
enum PaymentMethod { online, inPerson }

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  DateTime? selectedDate;
  String? selectedTime;
  String? serviceName;
  String? employeeName;
  double? price;
  // Estado para guardar el método de pago seleccionado
  PaymentMethod _selectedPaymentMethod = PaymentMethod.online; // Online por defecto

  // --- WIDGETS DE CONSTRUCCIÓN ---

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    selectedDate = appState.tempSelectedDate;
    selectedTime = appState.tempSelectedTime;
    serviceName = appState.tempServiceName;
    employeeName = appState.tempEmployeeName;
    price = appState.tempPrice;

    // Guard: Si falta algún dato, redirige al usuario a la pantalla de inicio o muestra un error
    if (selectedDate == null || selectedTime == null || serviceName == null || employeeName == null || price == null) {
      // Puedes cambiar la ruta a donde quieras redirigir
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Completa todos los pasos antes de seleccionar el método de pago.')),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    // Ya validado, podemos usar !
    return Scaffold(
      backgroundColor: Colors.white, // var(--background-color)
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0), // px-4 py-6
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(),
              const SizedBox(height: 24), // mb-6
              const Text(
                'Selecciona tu método de pago',
                style: TextStyle(
                  fontSize: 20, // text-xl
                  fontWeight: FontWeight.bold, // font-bold
                  color: AppColors.foregroundColor,
                ),
              ),
              const SizedBox(height: 24), // mb-6
              _buildPaymentOptions(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  // --- PARTES DEL UI ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.8), // bg-white/80
      elevation: 0, // No tiene sombra directa, usa backdrop-blur
      scrolledUnderElevation: 1.0, // Ligera sombra al hacer scroll debajo
      shadowColor: Colors.black.withOpacity(0.05),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.foregroundColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Método de Pago',
        style: TextStyle(
          fontSize: 18, // text-lg
          fontWeight: FontWeight.bold,
          color: AppColors.foregroundColor,
        ),
      ),
      centerTitle: true,
      // No 'actions' explícito, el centrado se maneja con flex-1 en HTML,
      // centerTitle: true lo hace en Flutter.
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Altura para la barra de progreso
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 16), // Ajustado px-2 y mt-4
          child: _buildProgressBar(),
        ),
      ),
    );
  }

  // Barra de progreso (Paso 5)
  Widget _buildProgressBar() {
    const int currentStep = 5; // <-- ACTUALIZADO A PASO 5
    const int totalSteps = 5;

    List<Color> colors = [
      AppColors.progressStep, // Paso 1
      AppColors.progressStep, // Paso 2
      AppColors.progressStep, // Paso 3
      AppColors.progressStep, // Paso 4
      AppColors.progressActive, // Paso 5 (activo)
    ];

    return Column(
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            return Expanded(
              child: Container(
                height: 8, // h-2
                margin: EdgeInsets.only(
                  right: index < totalSteps - 1 ? 6 : 0, // gap-1.5
                ),
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(100), // rounded-full
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8), // mb-2
        Text.rich(
          TextSpan(
            text: 'Paso $currentStep de $totalSteps: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14, // text-sm
              color: AppColors.progressStep, // var(--secondary-color)
            ),
            children: const [
              TextSpan(
                text: 'Método de pago', // Texto actualizado
                style: TextStyle(
                  color: AppColors.progressActive, // var(--primary-color)
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Tarjeta de Resumen de Cita
  Widget _buildSummaryCard() {
    // Formatear fecha y precio
    final String formattedDate =
      DateFormat('EEEE, d \'de\' MMMM', 'es').format(selectedDate!).capitalize();
    final String formattedPrice = NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(price); // Asume MXN

    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: AppColors.gray50, // bg-gray-50
        borderRadius: BorderRadius.circular(12), // rounded-xl
        border: Border.all(color: AppColors.gray200), // border border-gray-200
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumen de tu cita',
            style: TextStyle(
              fontSize: 16, // text-base
              fontWeight: FontWeight.w600, // font-semibold
              color: AppColors.progressStep, // var(--secondary-color)
            ),
          ),
          const SizedBox(height: 12), // mb-3
          _buildSummaryRow("Servicio:", serviceName!),
          const SizedBox(height: 8), // space-y-2
          _buildSummaryRow("Estilista:", employeeName!), // Añadido
          const SizedBox(height: 8), // space-y-2
          _buildSummaryRow("Fecha:", formattedDate),
          const SizedBox(height: 8), // space-y-2
          _buildSummaryRow("Hora:", selectedTime!),
          const SizedBox(height: 12), // mt-3
          const Divider(color: AppColors.gray200, thickness: 1), // border-t
          const SizedBox(height: 12), // pt-3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Costo Total:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // text-base
                  color: AppColors.foregroundColor,
                ),
              ),
              Text(
                formattedPrice,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // text-base
                  color: AppColors.progressActive, // var(--primary-color)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper para las filas del resumen
  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14, // text-sm
            fontWeight: FontWeight.w500, // font-medium
            color: AppColors.gray500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14, // text-sm
            fontWeight: FontWeight.w600, // font-semibold
            color: AppColors.gray700,
          ),
        ),
      ],
    );
  }

  // Opciones de Método de Pago
  Widget _buildPaymentOptions() {
    return Column(
      children: [
        _buildPaymentOption(
          method: PaymentMethod.online,
          icon: Icons.credit_card,
          title: 'Pago en línea',
          subtitle: 'Usa tu tarjeta de crédito o débito.',
        ),
        const SizedBox(height: 16), // space-y-4
        _buildPaymentOption(
          method: PaymentMethod.inPerson,
          icon: Icons.payments, // Icono de 'payments'
          title: 'Pago al Estilista',
          subtitle: 'Paga en efectivo o con tarjeta al finalizar.',
        ),
      ],
    );
  }

  // Widget individual para cada opción de pago
  Widget _buildPaymentOption({
    required PaymentMethod method,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    bool isSelected = _selectedPaymentMethod == method;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      borderRadius: BorderRadius.circular(12), // rounded-xl
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16), // p-4
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary50 : Colors.transparent, // has-[:checked]:bg-red-50
          borderRadius: BorderRadius.circular(12), // rounded-xl
          border: Border.all(
            color: isSelected ? AppColors.progressActive : AppColors.gray200, // has-[:checked]:border-[var(--primary-color)]
            width: isSelected ? 2.0 : 1.0, // has-[:checked]:ring-2 (simulado con borde más grueso)
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 36, color: AppColors.progressStep), // text-4xl, var(--secondary-color)
            const SizedBox(width: 16), // gap-4
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16, // text-base
                      fontWeight: FontWeight.w600, // font-semibold
                      color: AppColors.foregroundColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14, // text-sm
                      color: AppColors.mutedForeground, // var(--muted-foreground)
                    ),
                  ),
                ],
              ),
            ),
            // Usamos un Radio visualmente similar
            Radio<PaymentMethod>(
              value: method,
              groupValue: _selectedPaymentMethod,
              onChanged: (PaymentMethod? value) {
                if (value != null) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                }
              },
              activeColor: AppColors.progressActive, // accent-[var(--primary-color)]
              visualDensity: VisualDensity.compact, // Para que no ocupe tanto espacio
            ),
          ],
        ),
      ),
    );
  }

  // Botón Confirmar y Pagar
  Widget _buildConfirmButton() {
     // El botón siempre está habilitado en esta pantalla,
     // la lógica de pago real se manejaría en onPressed
    bool isEnabled = true;

    return Container(
       // Añadido para simular el sticky bottom y borde superior
      decoration: const BoxDecoration(
        color: Colors.white,
         border: Border(top: BorderSide(color: AppColors.gray100, width: 1.0)),
      ),
      padding: const EdgeInsets.all(16), // p-4
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.progressActive.withOpacity(0.2), // shadow-red-500/20
              // Ajustar spreadRadius, blurRadius y offset para que coincida con shadow-lg
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(12), // rounded-xl
        ),
        child: ElevatedButton(
          onPressed: isEnabled ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmationScreen(),
              ),
            );
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.progressActive, // bg-[var(--primary-color)]
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 60), // h-12
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // rounded-xl
            ),
            elevation: 0, // La sombra está en el Container
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18, // text-base
              letterSpacing: 0.5, // tracking-wide (aproximado)
              fontFamily: 'Manrope',
            ),
          ),
          child: const Text('Confirmar y Pagar'), // Texto del botón
        ),
      ),
    );
  }
} 
