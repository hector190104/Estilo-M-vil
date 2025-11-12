import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import './screens/home_screen.dart'; // Asumiendo que existe
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/verification_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/service_selection_screen.dart';
import 'screens/employee_selection_screen.dart';
import 'screens/date_selection_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/help_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Locale 'es' es suficiente, o 'es_MX' si necesitas formato específico mexicano
  await initializeDateFormatting('es', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estilo Móvil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Manrope', // Asegúrate que la fuente esté configurada
        primaryColor: const Color(0xFF457B9D), // progressStep
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE63946)), // progressActive como base
        scaffoldBackgroundColor: Colors.white, // Fondo general blanco
      ),
      // --- MODIFICACIÓN: Iniciar directamente en ConfirmationScreen ---
      initialRoute: '/home', // Comentado temporalmente
      routes: {
        '/home': (context) => HomeScreen(), // Mantenemos las rutas originales
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/verification': (context) => VerificationScreen(),
        '/catalog': (context) => CatalogScreen(),
        '/service_selection': (context) => SeleccionServicioScreen(),
        '/employee_selection': (context) => const EmployeeSelectionScreen(),
        '/date_selection': (context) => const DateSelectionScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/help': (context) => const HelpScreen(),
      },
    );
  }
}
