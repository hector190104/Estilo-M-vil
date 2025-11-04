import 'package:flutter/material.dart';
import 'app_colors.dart'; // Asegúrate de tener tus colores aquí

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mapeo de colores del mockup a tu AppColors
    const Color textColor = AppColors.foregroundColor; // zinc-900
    const Color mutedColor = AppColors.gray500; // zinc-500
    const Color cardBgColor = AppColors.gray50; // zinc-50
    const Color borderColor = AppColors.gray200; // zinc-200
    const Color buttonColor = AppColors.progressActive; // #E63946

    return SingleChildScrollView(
      child: Column(
        children: [
          // --- Encabezado con botón de regreso y título ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // El HTML tiene un botón de regreso, pero como es una pestaña,
                // lo quitamos o lo dejamos sin acción.
                // Si prefieres que sea un "AppBar" falso, lo podemos agregar.
                // Por ahora, lo omito para que se alinee con el título.
                // const SizedBox(width: 40), // Espacio del botón de regreso
                const Expanded(
                  child: Text(
                    'Perfil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20, // text-xl
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                // const SizedBox(width: 40), // w-10 (espacio)
              ],
            ),
          ),

          // --- Info de Perfil (Avatar y Nombre) ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64, // h-32 w-32
                      backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBWG2r7A4YDp9_pkVCjZBuvWIy4G_-nlvDqKbe1MLNo9ycfAKZLcy5cKKcCVpWSXj74S6LMaXanFtH1_KZ-pbGDnviNw6rliSpYvthFSIrczjju5V_f59mrs4sRHfmeOD2QIFbJY6zae5_thJJ23e8aZtyN30oTLh8yf2bM_Tr-_akO7S-yUL-J8viR-aRFiQIDBNT2S-f1e0JuxOD3T_fSI-XoS3Qyovd9O69rsLSmJz6UOxu96zaNQaN-45yW0AlJ3Mb-e5CqMTY',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 32, // h-8 w-8
                        height: 32,
                        decoration: const BoxDecoration(
                          color: textColor, // bg-zinc-900
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit_outlined, // SVG aproximado
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // mt-4
                const Text(
                  'Sophia Clark',
                  style: TextStyle(
                    fontSize: 24, // text-2xl
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),

          // --- Secciones de Información ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Información Personal ---
                const Text(
                  'Información personal',
                  style: TextStyle(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16), // py-4 (dividido)
                _buildInfoRow(
                  label: 'Nombre',
                  value: 'Sophia Clark',
                  bgColor: cardBgColor,
                  borderColor: borderColor,
                  textColor: textColor,
                  mutedColor: mutedColor,
                ),
                const SizedBox(height: 8), // space-y-2
                _buildInfoRow(
                  label: 'Dirección',
                  value: '123 Main St, Anytown',
                  bgColor: cardBgColor,
                  borderColor: borderColor,
                  textColor: textColor,
                  mutedColor: mutedColor,
                ),
                const SizedBox(height: 8), // space-y-2
                _buildInfoRow(
                  label: 'Teléfono',
                  value: '+1 (555) 123-4567',
                  bgColor: cardBgColor,
                  borderColor: borderColor,
                  textColor: textColor,
                  mutedColor: mutedColor,
                ),
                const SizedBox(height: 24), // Espacio entre secciones

                // --- Historial ---
                const Text(
                  'Historial',
                  style: TextStyle(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16), // py-4 (dividido)
                _buildInfoRow(
                  value: 'Citas pasadas',
                  bgColor: cardBgColor,
                  borderColor: borderColor,
                  textColor: textColor,
                  mutedColor: mutedColor,
                ),
                const SizedBox(height: 8), // space-y-2
                _buildInfoRow(
                  value: 'Citas futuras',
                  bgColor: cardBgColor,
                  borderColor: borderColor,
                  textColor: textColor,
                  mutedColor: mutedColor,
                ),
                const SizedBox(height: 8), // space-y-2
                _buildInfoRow(
                  value: 'Calificaciones dadas',
                  bgColor: cardBgColor,
                  borderColor: borderColor,
                  textColor: textColor,
                  mutedColor: mutedColor,
                ),
                const SizedBox(height: 32), // mt-8

                // --- Botón Cerrar Sesión ---
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor, // bg-[#E63946]
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48), // w-full py-3
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // rounded-lg
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600, // font-semibold
                      fontFamily: 'Manrope',
                    ),
                  ),
                  onPressed: () {
                    // TODO: Implementar lógica de cerrar sesión
                  },
                  child: const Text('Cerrar sesión'),
                ),
                const SizedBox(height: 24), // Espacio al final
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper para las filas de información
  Widget _buildInfoRow({
    String? label,
    required String value,
    required Color bgColor,
    required Color borderColor,
    required Color textColor,
    required Color mutedColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8), // rounded-lg
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Si label es nulo, solo muestra el valor (como en "Historial")
          if (label != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14, // text-sm
                    fontWeight: FontWeight.w500, // font-medium
                    color: mutedColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600, // font-semibold
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          else
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600, // font-semibold
                color: textColor,
                fontSize: 16,
              ),
            ),
          Icon(
            Icons.chevron_right,
            color: mutedColor,
          ),
        ],
      ),
    );
  }
}

