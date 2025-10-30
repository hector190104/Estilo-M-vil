import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/verification_screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header con botón de retroceso y título
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Crear cuenta',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 48), // espacio igual al botón de back
                ],
              ),
            ),

            // Logo circular con ícono
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0xFFEA2A2A), // rojo
                  child: Icon(
                    Icons.person, // ícono dentro del círculo
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Text(
              'Regístrate para empezar.',
              style: TextStyle(color: Colors.grey[500]),
            ),

            SizedBox(height: 20),

            // Formulario
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    // Nombre completo
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Nombre completo',
                        filled: true,
                        fillColor: Color(0xFFF0F0F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Número de teléfono
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_iphone),
                        hintText: 'Número de teléfono móvil',
                        filled: true,
                        fillColor: Color(0xFFF0F0F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Contraseña
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Contraseña',
                        filled: true,
                        fillColor: Color(0xFFF0F0F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                    ),
                    SizedBox(height: 6),

                    // Indicador de fuerza de contraseña (simple)
                    Row(
                      children: [
                        Expanded(
                          child: Container(height: 4, color: Colors.red),
                        ),
                        Expanded(
                          child: Container(height: 4, color: Colors.grey[300]),
                        ),
                        Expanded(
                          child: Container(height: 4, color: Colors.grey[300]),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Débil',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Confirmar contraseña
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Confirmar contraseña',
                        filled: true,
                        fillColor: Color(0xFFF0F0F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Checkbox de términos
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(value: false, onChanged: (val) {}),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'Acepto los ',
                              style: TextStyle(color: Colors.grey[600]),
                              children: [
                                TextSpan(
                                  text: 'Términos de Servicio',
                                  style: TextStyle(
                                    color: Color(0xFF2A52EA),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: ' y la '),
                                TextSpan(
                                  text: 'Política de Privacidad.',
                                  style: TextStyle(
                                    color: Color(0xFF2A52EA),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Botón Crear cuenta
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEA2A2A),
                        minimumSize: const Size(double.infinity, 65),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationScreen(),
                            ),
                        );
                      },
                      child: const Text(
                        'Crear cuenta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
