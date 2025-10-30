import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_colors.dart'; // Importar la paleta de colores central
import 'string_extensions.dart'; // Importar extensión capitalize

class ConfirmationScreen extends StatelessWidget {
  // Datos necesarios para el resumen final
  final DateTime selectedDate;
  final String selectedTime;
  final String serviceName;
  final String employeeName;
  final double price;

  // URL de imagen (debería pasarse como parámetro en una app real)
  static const String _employeeImageUrl = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBe5XoKhLs5fPu99T01f-JuK6yv94Q1SbpwXhh2Z88wl8_P9D9MY0FB5sU470msyTLtIF881s5-Gpi2g77GHVdWUIf_lMScXx6nWOr0SN5-cIYh440j77pqTReDJd1k1e4Jbx8Za66AfNymxUreNTpCGXvS28d3OLQe7XAx_GStyccZ5bAP7O7HaHCwqdJORteALZZn2ZWwqhjL8TwFuNvu-JsOrZBmSeI1RQkFjiZoSa0KanyDHpheuwx_Ys7WWHOedZrcibPeOUI';

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
    // Usar debugPrint en lugar de print
    debugPrint("--- Building ConfirmationScreen (Corrected CustomScrollView Version) ---");
    return Scaffold(
      backgroundColor: Colors.white, // --c-white
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0, bottom: 24.0), // pt-8, px-4, pb-6 (ajustado)
            sliver: SliverToBoxAdapter(
              child: Align( // mx-auto
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500), // max-w-md
                  child: Column(
                     mainAxisSize: MainAxisSize.min, // Importante!
                     children: [
                      _buildProgressBar(),
                      const SizedBox(height: 24), // space-y-6
                      _buildConfirmationHeader(),
                      const SizedBox(height: 24), // space-y-6
                      _buildDetailsCard(),
                      // Espacio al final DENTRO de la columna
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Puedes añadir más slivers aquí si tuvieras más contenido desplazable
        ],
      ),
      bottomNavigationBar: _buildConfirmButton(context),
    );
  }

  // --- Widgets Internos (AppBar, ProgressBar, Header, Card, DetailRow, Button) ---
  // (Con correcciones para 'withOpacity' usando Color.alphaBlend y Color.fromRGBO)

 PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Usar alphaBlend para simular opacidad sobre el fondo del tema
    Color appBarColor = Color.alphaBlend(
        // Calcula el valor alfa (0.8 * 255 = 204)
        Colors.white.withAlpha(204),
        // Color de fondo base sobre el que se mezcla (puede ser el scaffoldBackgroundColor)
        Theme.of(context).scaffoldBackgroundColor
    );

    return AppBar(
      backgroundColor: appBarColor, // bg-[var(--c-white)]/80 backdrop-blur-sm
      elevation: 0,
      scrolledUnderElevation: 1.0, // Efecto sutil al hacer scroll
      shadowColor: Colors.black.withOpacity(0.05), // Sombra suave
      leading: IconButton(
        icon: const Icon(Icons.close, color: AppColors.foregroundColor), // --c-black
        onPressed: () {
          // Vuelve a la primera pantalla de la pila
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      title: const Text(
        'Confirmación de Cita',
        style: TextStyle(
          fontSize: 18, // text-lg
          fontWeight: FontWeight.bold,
          color: AppColors.foregroundColor, // --c-black
        ),
      ),
      centerTitle: true,
      actions: const [
        SizedBox(width: 48), // Espacio invisible para centrar título (w-8)
      ],
    );
  }

  Widget _buildProgressBar() {
   const int currentStep = 5;
    const int totalSteps = 5;

    List<Color> colors = [
      AppColors.progressStep,   // --c-blue
      AppColors.progressStep,   // --c-blue
      AppColors.progressStep,   // --c-blue
      AppColors.progressStep,   // --c-blue
      AppColors.progressActive, // --c-red
    ];

    return Padding(
      padding: EdgeInsets.zero, // El padding exterior lo maneja SliverPadding
      child: Column(
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              return Expanded( // flex-1
                child: Container(
                  height: 8, // h-2
                  margin: EdgeInsets.only(
                    right: index < totalSteps - 1 ? 4 : 0, // gap-1
                  ),
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
              text: 'Paso $currentStep de $totalSteps: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14, // text-sm (implícito)
                color: AppColors.progressStep, // --c-blue
              ),
              children: const [
                TextSpan(
                  text: 'Confirmación',
                  style: TextStyle(
                    color: AppColors.progressActive, // --c-red
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationHeader() {
    return Column( // space-y-1
      children: [
        Container( // inline-flex h-20 w-20 ...
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.progressActive, // --c-red
            shape: BoxShape.circle, // rounded-full
          ),
          child: const Center(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(-45 / 360), // transform -rotate-45
              child: Icon(
                Icons.content_cut, // SVG aproximado
                color: Colors.white, // text-white
                size: 40, // height="40px" width="40px"
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '¡Casi listo!',
          style: TextStyle(
            fontSize: 24, // text-2xl
            fontWeight: FontWeight.bold,
            color: AppColors.foregroundColor, // --c-black
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        const Text(
          'Confirma los detalles de tu cita.',
          style: TextStyle(
            color: AppColors.gray500, // --c-gray-500
            fontSize: 16, // text-base (implícito)
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    // Formatear fecha/hora y precio
    final String formattedDate = DateFormat('d \'de\' MMMM', 'es').format(selectedDate).capitalize();
    final String formattedDateTime = "$formattedDate - $selectedTime";
    // Corrección para usar currencySymbol si es necesario o locale
    final String formattedPrice = NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(price);

    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        // CORRECCIÓN: Usar Color.fromRGBO para opacidad
        color: Color.fromRGBO(
            // Acceder a los componentes RGB del color base
             (AppColors.gray100.value >> 16) & 0xFF, // Red
             (AppColors.gray100.value >> 8) & 0xFF,  // Green
             AppColors.gray100.value & 0xFF,         // Blue
            0.5 // 50% opacidad
        ),
        borderRadius: BorderRadius.circular(12), // rounded-xl
        border: Border.all(color: AppColors.gray200), // border border-[var(--c-gray-200)]
      ),
      child: Column( // Contenedor principal de la tarjeta
        children: [
          // Contenedor para las filas de detalles (space-y-4)
          Column(
             children: [
                _buildDetailRow(
                  icon: Icons.content_cut,
                  label: 'Servicio',
                  value: serviceName,
                ),
                const SizedBox(height: 16), // space-y-4
                _buildDetailRow(
                  icon: Icons.calendar_today,
                  label: 'Fecha y Hora',
                  value: formattedDateTime,
                ),
                const SizedBox(height: 16), // space-y-4
                _buildDetailRow(
                  imageUrl: _employeeImageUrl, // Usar imagen
                  label: 'Estilista',
                  value: employeeName,
                ),
             ],
          ),
          const Divider( // hr
            height: 32, // my-4 (16 arriba + 16 abajo)
            color: AppColors.gray200, // border-[var(--c-gray-200)]
            thickness: 1,
          ),
          Row( // Contenedor para el costo total
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // items-center justify-between
            children: [
              const Text(
                'Costo estimado',
                style: TextStyle(
                  fontSize: 18, // text-lg
                  fontWeight: FontWeight.bold,
                  color: AppColors.foregroundColor, // --c-black
                ),
              ),
              Text(
                formattedPrice,
                style: const TextStyle(
                  fontSize: 18, // text-lg
                  fontWeight: FontWeight.bold,
                  color: AppColors.progressActive, // --c-red
                ),
              ),
            ],
          ),
        ],
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
      iconWidget = SizedBox( // size-10 shrink-0
        width: 40,
        height: 40,
        child: ClipOval( // rounded-full
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            // Añadir un placeholder mientras carga
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                decoration: const BoxDecoration(
                    color: AppColors.gray200, shape: BoxShape.circle),
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(AppColors.gray400))),
              );
            },
            errorBuilder: (context, error, stackTrace) =>
              Container( // Fallback si hay error
                  decoration: const BoxDecoration(
                      color: AppColors.gray200,
                      shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.person, color: AppColors.gray500)
              ),
          ),
        ),
      );
    } else {
      iconWidget = Container( // flex size-10 items-center justify-center
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.progressStep, // --c-blue
          borderRadius: BorderRadius.circular(8), // rounded-lg
        ),
        child: Icon(icon, color: Colors.white), // --c-white
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // items-start
      children: [
        iconWidget,
        const SizedBox(width: 16), // gap-4
        Expanded( // Ocupa el espacio restante
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14, // text-sm
                  color: AppColors.gray500, // --c-gray-500
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600, // font-semibold
                  color: AppColors.foregroundColor, // --c-black
                  fontSize: 16, // text-base (implícito)
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

 Widget _buildConfirmButton(BuildContext context) {
    return Container( // footer sticky bottom...
      color: Colors.white, // bg-[var(--c-white)]
      // SafeArea para evitar que el botón quede debajo de elementos del sistema (notch, etc)
      child: SafeArea(
        top: false, // Solo aplicar padding inferior
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // px-4 py-3
          child: Align( // Para simular max-w-md mx-auto
            alignment: Alignment.center,
            child: Container(
                constraints: const BoxConstraints(maxWidth: 500), // max-w-md
                child: ElevatedButton(
                onPressed: () {
                  // --- Lógica Final de Confirmación ---
                  // CORRECCIÓN: Usar debugPrint
                  debugPrint('Cita confirmada!');
                  // TODO: Mostrar diálogo/animación de confirmación personalizada aquí

                  // Vuelve a la primera pantalla de la pila
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  // --- Fin Lógica Final ---
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.progressActive, // bg-[var(--c-red)]
                  foregroundColor: Colors.white, // text-[var(--c-white)]
                  minimumSize: const Size(double.infinity, 48), // h-12, w-full
                  padding: const EdgeInsets.symmetric(horizontal: 20), // px-5
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // rounded-xl
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, // font-bold
                    fontSize: 16, // text-base
                    letterSpacing: 0.2, // tracking-[0.015em] (aproximado)
                    fontFamily: 'Manrope', // Asegúrate que la fuente esté configurada
                  ),
                  splashFactory: InkRipple.splashFactory, // Simula active:scale-95
                ),
                child: const Text('Confirmar cita'),
               ),
            ),
          ),
        ),
      ),
    );
  }

} // Fin ConfirmationScreen

