

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}


class _AppointmentsScreenState extends State<AppointmentsScreen> {
  // Las citas ahora se obtienen de AppState

  // ...existing code...

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

  Widget _buildAppointmentCard(AppAppointment cita, int index, AppState appState) {
    final Color statusColor = cita.color;
    final Color statusBgColor = _getStatusBgColor(cita.status);
    final IconData statusIcon = _getStatusIcon(cita.status);
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
                  cita.employeeAvatarUrl != null && cita.employeeAvatarUrl!.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            cita.employeeAvatarUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              cita.icon,
                              color: statusColor,
                              size: 28,
                            ),
                          ),
                        )
                      : Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            cita.icon,
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
                          cita.service,
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
                          'con ${cita.employee}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.accentColor
                                : AppColors.gray500,
                          ),
                        ),
                        Text(
                          cita.date,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.accentColor
                                : AppColors.gray500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
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
                                    cita.status,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (cita.status != 'Cancelada')
                              TextButton(
                                onPressed: () {
                                  appState.cancelAppointment(index);
                                },
                                child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
                              ),
                          ],
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
    final appState = Provider.of<AppState>(context);
    if (appState.currentUser == null) {
      Future.microtask(() => Navigator.of(context).pushReplacementNamed('/login'));
      return const SizedBox.shrink();
    }
    final appointments = appState.appointments;
    return Scaffold(
      backgroundColor: isDark ? AppColors.gray800 : AppColors.gray100,
      extendBodyBehindAppBar: true,
      appBar: null,
      body: SafeArea(
        child: Column(
          children: [
            // Barra personalizada superior
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: isDark ? AppColors.gray50 : AppColors.gray900,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Mis Citas',
                    style: TextStyle(
                      color: isDark ? AppColors.gray50 : AppColors.gray900,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Manrope',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    color: isDark ? AppColors.gray50 : AppColors.gray900,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/notifications');
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: appointments.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
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
                                  // Aquí podrías navegar a la pantalla de agendar cita
                                  Navigator.of(context).pushNamed('/service_selection');
                                },
                                child: const Text('Agendar una Cita', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: appointments.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, i) => _buildAppointmentCard(appointments[i], i, appState),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}