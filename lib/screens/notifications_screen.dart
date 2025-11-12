import 'package:flutter/material.dart';
import 'app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Cita confirmada',
        'body': 'Tu cita para Corte de cabello está confirmada para el 15/11/2025 a las 16:00.',
        'date': 'Hoy',
        'type': 'success',
      },
      {
        'title': 'Recordatorio',
        'body': 'Recuerda tu cita de Barba mañana a las 12:00.',
        'date': 'Ayer',
        'type': 'info',
      },
      {
        'title': 'Cita cancelada',
        'body': 'Tu cita de Tinte fue cancelada por el barbero.',
        'date': 'Hace 2 días',
        'type': 'error',
      },
    ];

    Color _getTypeColor(String type) {
      switch (type) {
        case 'success':
          return AppColors.green400;
        case 'error':
          return AppColors.red400;
        case 'info':
        default:
          return AppColors.secondary500;
      }
    }

    IconData _getTypeIcon(String type) {
      switch (type) {
        case 'success':
          return Icons.check_circle_outline;
        case 'error':
          return Icons.error_outline;
        case 'info':
        default:
          return Icons.info_outline;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.gray100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text('Notificaciones', style: TextStyle(color: AppColors.foregroundColor)),
        iconTheme: const IconThemeData(color: AppColors.foregroundColor),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text('No tienes notificaciones.', style: TextStyle(color: AppColors.gray500)),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final n = notifications[i];
                return Card(
                  color: AppColors.gray50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getTypeColor(n['type']),
                      child: Icon(_getTypeIcon(n['type']), color: Colors.white),
                    ),
                    title: Text(n['title'], style: const TextStyle(color: AppColors.foregroundColor, fontWeight: FontWeight.bold)),
                    subtitle: Text(n['body'], style: const TextStyle(color: AppColors.gray500)),
                    trailing: Text(n['date'], style: const TextStyle(color: AppColors.gray400, fontSize: 12)),
                  ),
                );
              },
            ),
    );
  }
}
