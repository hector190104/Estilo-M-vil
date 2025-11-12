import 'package:flutter/material.dart';
import 'app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        'q': '¿Cómo reservo una cita?',
        'a': 'Desde el catálogo selecciona el servicio, elige fecha y hora, y confirma tu cita.'
      },
      {
        'q': '¿Puedo cancelar una cita?',
        'a': 'Sí, desde el historial de citas puedes cancelar si la cita aún no ha ocurrido.'
      },
      {
        'q': '¿Cómo cambio mi contraseña?',
        'a': 'En tu perfil, selecciona la opción de cambiar contraseña.'
      },
      {
        'q': '¿Cómo contacto al soporte?',
        'a': 'Puedes escribirnos a soporte@barberia.com o usar el botón de contacto abajo.'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.gray100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text('Ayuda y soporte', style: TextStyle(color: AppColors.foregroundColor)),
        iconTheme: const IconThemeData(color: AppColors.foregroundColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...faqs.map((faq) => Card(
                color: AppColors.gray50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ExpansionTile(
                  title: Text(faq['q']!, style: const TextStyle(color: AppColors.foregroundColor, fontWeight: FontWeight.bold)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(faq['a']!, style: const TextStyle(color: AppColors.gray500)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 32),
          Card(
            color: AppColors.gray50,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.email, color: AppColors.secondary500),
              title: const Text('¿Necesitas más ayuda?', style: TextStyle(color: AppColors.foregroundColor, fontWeight: FontWeight.bold)),
              subtitle: const Text('Contáctanos por correo electrónico', style: TextStyle(color: AppColors.gray500)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary500,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Aquí podrías abrir el correo o chat de soporte
                },
                child: const Text('Contactar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
