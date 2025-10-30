import 'package:flutter/material.dart';

// Paleta de colores centralizada basada en los mockups
class AppColors {
  // Paleta Primaria (Rojos)
  static const Color primary50 = Color(0xFFFEF2F2);
  static const Color primary100 = Color(0xFFFEE2E2);
  static const Color primary200 = Color(0xFFFECACA);
  static const Color primary500 = Color(0xFFEF4444); // Usado como --primary-color en algunos HTML
  static const Color primary700 = Color(0xFFB91C1C);
  static const Color primary800 = Color(0xFF991B1B);

  // Paleta Secundaria (Azules)
  static const Color secondary50 = Color(0xFFEFF6FF);
  static const Color secondary500 = Color(0xFF3B82F6);
  // Color usado como --secondary-color en HTML de pago y progreso
  static const Color progressStep = Color(0xFF457B9D);

  // Color Principal/Activo (Rojo específico del HTML)
  static const Color progressActive = Color(0xFFE63946); // Usado como --primary-color en HTML y botones

  // Paleta Neutrales (Grises)
  static const Color gray50 = Color(0xFFF9FAFB); // Añadido desde HTML pago (bg-gray-50)
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937); // Actualizado desde HTML pago
  static const Color gray900 = Color(0xFF11182C);

  // Paleta Semántica (Status y Leyenda Calendario)
  static const Color green400 = Color(0xFF34D399); // bg-green-400 (disponible leyenda)
  static const Color green500 = Color(0xFF22C55E);
  static const Color green700 = Color(0xFF059669);
  static const Color yellowStar = Color(0xFFFBBF24); // text-yellow-400 (estrella), bg-amber-400 (limitado leyenda)
  static const Color yellow500 = Color(0xFFEAB308);
  static const Color yellow700 = Color(0xFFB45309);
  static const Color red400 = Color(0xFFF87171); // bg-red-400 (no disponible leyenda)
  static const Color red500 = Color(0xFFEF4444);
  static const Color red700 = Color(0xFFB91C1C);

  // Colores específicos de la leyenda del calendario
  static const Color legendAvailable = green400; // bg-green-400
  static const Color legendLimited = yellowStar; // bg-amber-400
  static const Color legendUnavailable = red400; // bg-red-400

  // Colores de los puntos en el calendario
  static const Color dotAvailable = green400; // #34D399
  static const Color dotLimited = yellowStar; // #FBBF24
  static const Color dotUnavailable = red400; // #F87171

  // Colores específicos de la pantalla de pago
  static const Color accentColor = Color(0xFFA8DADC); // --accent-color
  static const Color mutedForeground = Color(0xFF6B7280); // --muted-foreground (es gray500)
  static const Color foregroundColor = Color(0xFF121212); // --foreground-color (casi negro)

}