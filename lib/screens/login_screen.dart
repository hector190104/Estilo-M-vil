import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'catalog_screen.dart';
import 'app_colors.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'password_recovery_screen.dart';

// --- SEGURIDAD Y VALIDACIONES ---
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  int _failedAttempts = 0;
  DateTime? _lockoutUntil;
  static const int _maxAttempts = 5;
  static const Duration _lockoutDuration = Duration(minutes: 15);

  bool get _isLockedOut {
    if (_lockoutUntil == null) return false;
    if (DateTime.now().isBefore(_lockoutUntil!)) return true;
    _lockoutUntil = null;
    _failedAttempts = 0;
    return false;
  }

  void _handleFailedLogin() {
    setState(() {
      _failedAttempts++;
      if (_failedAttempts >= _maxAttempts) {
        _lockoutUntil = DateTime.now().add(_lockoutDuration);
      }
    });
  }

  void _handleSuccessfulLogin() {
    setState(() {
      _failedAttempts = 0;
      _lockoutUntil = null;
    });
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de teléfono es requerido';
    }
    String cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!RegExp(r'^[0-9]{10}$').hasMatch(cleanPhone)) {
      return 'Debe tener 10 dígitos numéricos';
    }
    if (RegExp(r'^(\d)\1{9}$').hasMatch(cleanPhone)) {
      return 'Número no válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 8) {
      return 'Mínimo 8 caracteres';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Debe incluir mayúscula';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Debe incluir minúscula';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Debe incluir número';
    }
    return null;
  }

  void _login() {
    if (_isLockedOut) return;
    if (_formKey.currentState?.validate() ?? false) {
      String phone = _phoneController.text.replaceAll(RegExp(r'[\s\-\(\)]'), '');
      String password = _passwordController.text;
      final appState = Provider.of<AppState>(context, listen: false);
      final success = appState.login(phone, password);
      if (success) {
        _handleSuccessfulLogin();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CatalogScreen()),
        );
      } else {
        _handleFailedLogin();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credenciales inválidas'), backgroundColor: AppColors.progressActive),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // btn de retroceso
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Header con logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Container(
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
                      radius: 45,
                      backgroundColor: AppColors.primary500,
                      child: Icon(
                        Icons.home,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Home Styles',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bienvenido de nuevo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Inicia sesión para continuar.',
                    style: TextStyle(fontSize: 14, color: AppColors.gray500),
                  ),
                ],
              ),
            ),
            // Formulario seguro
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      enabled: !_isLockedOut,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Número de teléfono',
                        hintText: 'Ingresa tu número de teléfono',
                        filled: true,
                        fillColor: AppColors.gray50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: _validatePhone,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      enabled: !_isLockedOut,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'Ingresa tu contraseña',
                        filled: true,
                        fillColor: AppColors.gray50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: _validatePassword,
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       '¿Olvidaste tu contraseña?',
                    //       style: TextStyle(
                    //         color: AppColors.secondary500,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    if (_failedAttempts > 0 && !_isLockedOut)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Intentos fallidos: $_failedAttempts/$_maxAttempts',
                          style: TextStyle(color: AppColors.progressActive, fontSize: 12),
                        ),
                      ),
                    if (_isLockedOut)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Demasiados intentos. Intenta más tarde.',
                          style: TextStyle(color: AppColors.progressActive, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.progressActive,
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _isLockedOut ? null : _login,
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿No tienes una cuenta? ',
                        style: TextStyle(color: AppColors.gray500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Regístrate',
                          style: TextStyle(
                            color: AppColors.secondary500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PasswordRecoveryScreen()),
                        );
                      },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: AppColors.secondary500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
