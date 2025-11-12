

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}


class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final List<Map<String, dynamic>> appointments = [
    {
      'service': 'Corte de Cabello Clásico',
      'date': '25 de Octubre, 2024 - 15:30',
      'employee': 'Ana López',
      'status': 'Confirmada',
      'icon': Icons.content_cut,
      'color': AppColors.progressStep,
    },
    {
      'service': 'Diseño de Barba',
      'date': '28 de Octubre, 2024 - 11:00',
      'employee': 'Carlos Ruiz',
      'status': 'Pendiente',
  'icon': Icons.delivery_dining,
      'color': Colors.orange,
    },
    {
      'service': 'Tratamiento Facial',
      'date': '15 de Octubre, 2024 - 18:00',
      'employee': 'Sofía Gómez',
      'status': 'Cancelada',
      'icon': Icons.face,
      'color': AppColors.progressActive,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmada':
        return AppColors.progressStep;
      case 'Pendiente':
        return Colors.orange;
      case 'Cancelada':
        return AppColors.progressActive;
      default:
        return AppColors.gray500;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Confirmada':
        return Icons.check_circle;
      case 'Pendiente':
        return Icons.schedule;
      case 'Cancelada':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Confirmada':
        return AppColors.progressStep.withOpacity(0.1);
      case 'Pendiente':
        return Colors.orange.withOpacity(0.1);
      case 'Cancelada':
        return AppColors.progressActive.withOpacity(0.1);
      default:
        return AppColors.gray200;
    }
  }

  Widget _buildAppointmentCard(Map<String, dynamic> cita) {
    final Color statusColor = _getStatusColor(cita['status']);
    final Color statusBgColor = _getStatusBgColor(cita['status']);
    final IconData statusIcon = _getStatusIcon(cita['status']);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.gray800 : AppColors.gray50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 6,
            color: statusColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      cita['icon'],
                      color: statusColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cita['service'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.gray50
                                : AppColors.gray900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'con ${cita['employee']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.accentColor
                                : AppColors.gray500,
                          ),
                        ),
                        Text(
                          cita['date'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.accentColor
                                : AppColors.gray500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusBgColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcon, color: statusColor, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                cita['status'],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.gray800 : AppColors.gray100,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.gray800 : AppColors.gray50,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: isDark ? AppColors.gray50 : AppColors.gray900,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Mis Citas',
          style: TextStyle(
            color: isDark ? AppColors.gray50 : AppColors.gray900,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Manrope',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: isDark ? AppColors.gray50 : AppColors.gray900,
            onPressed: () {
              Navigator.of(context).pushNamed('/notifications');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: appointments.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Container(
                    height: 96,
                    width: 96,
                    decoration: BoxDecoration(
                      color: AppColors.progressStep.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: const Icon(Icons.calendar_month, color: AppColors.progressStep, size: 48),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Aún no tienes citas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.gray50 : AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '¡Agenda tu primer servicio y luce increíble!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDark ? AppColors.accentColor : AppColors.gray500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.progressStep,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: AppColors.progressStep.withOpacity(0.3),
                    ),
                    onPressed: () {
                      // Acción para agendar cita
                    },
                    child: const Text('Agendar una Cita', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            : ListView.separated(
                itemCount: appointments.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) => _buildAppointmentCard(appointments[i]),
              ),
      ),
    );
  }
}