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
            child: Icon(
              Icons.content_cut,
              color: Colors.white,
              size: 40,
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

    return Card(
      color: AppColors.gray100.withOpacity(0.5),
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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('¡Cita confirmada con éxito!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
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
}
