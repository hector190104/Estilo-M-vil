import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_colors.dart';
import 'string_extensions.dart';

class ConfirmationScreen extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String serviceName;
  final String employeeName;
  final double price;

  static const String _employeeImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBe5XoKhLs5fPu99T01f-JuK6yv94Q1SbpwXhh2Z88wl8_P9D9MY0FB5sU470msyTLtIF881s5-Gpi2g77GHVdWUIf_lMScXx6nWOr0SN5-cIYh440j77pqTReDJd1k1e4Jbx8Za66AfNymxUreNTpCGXvS28d3OLQe7XAx_GStyccZ5bAP7O7HaHCwqdJORteALZZn2ZWwqhjL8TwFuNvu-JsOrZBmSeI1RQkFjiZoSa0KanyDHpheuwx_Ys7WWHOedZrcibPeOUI';

  const ConfirmationScreen({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.serviceName,
    required this.employeeName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    // Esta es la estructura que te funcionó
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProgressBar(),
                  const SizedBox(height: 24),
                  _buildConfirmationHeader(),
                  const SizedBox(height: 24),
                  _buildDetailsCard(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0.3,
      leading: IconButton(
        icon: const Icon(Icons.close, color: AppColors.foregroundColor),
        // Modificado para volver a la pantalla anterior (payment)
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Confirmación de Cita',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.foregroundColor,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProgressBar() {
    const int currentStep = 5;
    const int totalSteps = 5;

    return Column(
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            return Expanded(
              child: Container(
                height: 8,
                margin: EdgeInsets.only(right: index < totalSteps - 1 ? 4 : 0),
                decoration: BoxDecoration(
                  color: index < currentStep - 1
                      ? AppColors.progressStep
                      : AppColors.progressActive,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text: 'Paso $currentStep de $totalSteps: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.progressStep,
            ),
            children: const [
              TextSpan(
                text: 'Confirmación',
                style: TextStyle(color: AppColors.progressActive),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.progressActive,
            shape: BoxShape.circle,
          ),
          child: const Center(
            // --- Icono de Tijeras (Aproximación del SVG) ---
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(-45 / 360),
              child: Icon(
                Icons.content_cut,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '¡Casi listo!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.foregroundColor,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Confirma los detalles de tu cita.',
          style: TextStyle(
            color: AppColors.gray500,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    final String formattedDate =
        DateFormat('d \'de\' MMMM', 'es').format(selectedDate).capitalize();
    final String formattedPrice =
        NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(price);

    // Corregir el color con opacidad
    final Color cardColor = Color.fromRGBO(
      AppColors.gray100.red,
      AppColors.gray100.green,
      AppColors.gray100.blue,
      0.5, // 50% opacidad
    );

    return Card(
      color: cardColor,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildDetailRow(
              icon: Icons.content_cut,
              label: 'Servicio',
              value: serviceName,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: 'Fecha y Hora',
              value: "$formattedDate - $selectedTime",
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              imageUrl: _employeeImageUrl,
              label: 'Estilista',
              value: employeeName,
            ),
            const Divider(height: 32, color: AppColors.gray200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Costo estimado',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.foregroundColor,
                  ),
                ),
                Text(
                  formattedPrice,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.progressActive,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    IconData? icon,
    String? imageUrl,
    required String label,
    required String value,
  }) {
    Widget iconWidget;
    if (imageUrl != null) {
      iconWidget = ClipOval(
        child: Image.network(
          imageUrl,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.person, color: AppColors.gray500),
        ),
      );
    } else {
      iconWidget = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.progressStep,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        iconWidget,
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.gray500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.foregroundColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ElevatedButton(
            // --- MODIFICACIÓN: Llamar al diálogo ---
            onPressed: () {
              // Ya no usamos SnackBar, llamamos a nuestra función de diálogo
              _showConfirmationDialog(context);
            },
            // --- FIN MODIFICACIÓN ---
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.progressActive,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Manrope',
              ),
            ),
            child: const Text('Confirmar cita'),
          ),
        ),
      ),
    );
  }

  // --- WIDGET NUEVO: Diálogo de Confirmación ---
  void _showConfirmationDialog(BuildContext context) {
    // Formatear los datos para el diálogo
    final String formattedDate =
        DateFormat('EEEE, d \'de\' MMMM', 'es').format(selectedDate).capitalize();
    final String formattedPrice =
        NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(price);

    showDialog(
      context: context,
      // El fondo oscuro semitransparente (bg-gray-900/50)
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext dialogContext) {
        // Usamos Dialog para la ventana emergente
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 8.0, // shadow-lg
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // rounded-xl
          ),
          // Quitar el padding por defecto del Dialog
          insetPadding: const EdgeInsets.all(24), 
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 384), // max-w-sm
            child: Column(
              mainAxisSize: MainAxisSize.min, // Para que se ajuste al contenido
              children: [
                // --- Contenido Principal del Diálogo ---
                Padding(
                  padding: const EdgeInsets.all(16.0), // p-4
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // items-start
                    children: [
                      // Icono
                      Container(
                        width: 48, // h-12 w-12
                        height: 48,
                        decoration: const BoxDecoration(
                          color: AppColors.dialogIconBg, // bg-[#E0F2FE]
                          shape: BoxShape.circle, // rounded-full
                        ),
                        child: const Icon(
                          Icons.event_available,
                          color: AppColors.progressStep, // text-[#457B9D]
                          size: 28, // text-3xl (aprox)
                        ),
                      ),
                      const SizedBox(width: 16), // ml-4
                      // Contenido de texto
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Fila "Home Styles" y "ahora"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Home Styles',
                                  style: TextStyle(
                                    fontSize: 14, // text-sm
                                    fontWeight: FontWeight.w600, // font-semibold
                                    color: AppColors.gray900,
                                  ),
                                ),
                                Text(
                                  'ahora',
                                  style: TextStyle(
                                    fontSize: 12, // text-xs
                                    color: AppColors.gray500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4), // mt-1
                            const Text(
                              '¡Tu cita esta confirmada!',
                              style: TextStyle(
                                fontSize: 18, // text-lg
                                fontWeight: FontWeight.bold,
                                color: AppColors.gray900,
                              ),
                            ),
                            const SizedBox(height: 4), // mt-1
                            // Párrafo con estilos mixtos
                            Text.rich(
                              TextSpan(
                                text: 'Prepárate para tu ',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray600,
                                  height: 1.5, // Interlineado
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: serviceName, // Dato dinámico
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.progressActive,
                                    ),
                                  ),
                                  const TextSpan(text: ' con '),
                                  TextSpan(
                                    text: employeeName, // Dato dinámico
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.progressActive,
                                    ),
                                  ),
                                  const TextSpan(text: ' el '),
                                  TextSpan(
                                    text: formattedDate, // Dato dinámico
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.progressActive,
                                    ),
                                  ),
                                  const TextSpan(text: ' a las '),
                                  TextSpan(
                                    text: selectedTime, // Dato dinámico
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.progressActive,
                                    ),
                                  ),
                                  const TextSpan(text: '. Total estimado: '),
                                  TextSpan(
                                    text: formattedPrice, // Dato dinámico
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.progressActive,
                                    ),
                                  ),
                                  const TextSpan(text: '.'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8), // mt-2
                            const Text(
                              '¡Nos vemos pronto!',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Botón Cerrar (X)
                      InkWell(
                        onTap: () {
                           // Cierra solo el diálogo
                           Navigator.of(dialogContext).pop();
                           // Y luego navega al inicio
                           Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0), // Un poco de padding táctil
                          child: Icon(Icons.close, color: AppColors.gray400, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- Botones Inferiores del Diálogo ---
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.gray200, width: 1.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.progressStep, // text-[#457B9D]
                            padding: const EdgeInsets.symmetric(vertical: 16), // py-3
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Manrope',
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            // TODO: Navegar a "Mis Citas" o una pantalla de detalle
                            Navigator.of(dialogContext).pop();
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          child: const Text('Ver detalles'),
                        ),
                      ),
                      // Divisor vertical
                      Container(
                        width: 1,
                        height: 48, // Altura aproximada del botón
                        color: AppColors.gray200,
                      ),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.progressActive, // text-[#E63946]
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Manrope',
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            // TODO: Implementar lógica de cancelación
                            Navigator.of(dialogContext).pop();
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          child: const Text('Cancelar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} // Fin ConfirmationScreen

