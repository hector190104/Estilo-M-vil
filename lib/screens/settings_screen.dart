import 'package:flutter/material.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool promoEnabled = true;
  bool newsEnabled = false;
  bool darkMode = false;
  String language = 'es';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text('Configuración', style: TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.bold)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF212121)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          // Sección Cuenta
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F6F6),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0,1))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
                  child: Text('Cuenta', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
                _settingsTile(icon: Icons.person, label: 'Datos Personales'),
                _settingsTile(icon: Icons.lock, label: 'Cambiar Contraseña'),
                _settingsTile(icon: Icons.credit_card, label: 'Métodos de Pago'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Sección Preferencias
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F6F6),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0,1))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
                  child: Text('Preferencias de la Aplicación', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
                _settingsTile(
                  icon: Icons.language,
                  label: 'Idioma',
                  trailing: DropdownButton<String>(
                    value: language,
                    underline: Container(),
                    items: const [
                      DropdownMenuItem(value: 'es', child: Text('Español')),
                      DropdownMenuItem(value: 'en', child: Text('Inglés')),
                    ],
                    onChanged: (val) {
                      setState(() { language = val ?? 'es'; });
                    },
                  ),
                ),
                _settingsSwitchTile(
                  icon: Icons.dark_mode,
                  label: 'Activar modo oscuro',
                  value: darkMode,
                  onChanged: (val) => setState(() => darkMode = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Sección Notificaciones
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F6F6),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0,1))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
                  child: Text('Notificaciones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
                _settingsSwitchTile(
                  icon: Icons.notifications,
                  label: 'Recordatorios de Cita',
                  value: notificationsEnabled,
                  onChanged: (val) => setState(() => notificationsEnabled = val),
                ),
                _settingsSwitchTile(
                  icon: Icons.sell,
                  label: 'Promociones y Ofertas',
                  value: promoEnabled,
                  onChanged: (val) => setState(() => promoEnabled = val),
                ),
                _settingsSwitchTile(
                  icon: Icons.newspaper,
                  label: 'Noticias de la App',
                  value: newsEnabled,
                  onChanged: (val) => setState(() => newsEnabled = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Sección Soporte y Legal
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F6F6),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0,1))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
                  child: Text('Soporte y Legal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Color(0xFF212121)),
                  title: const Text('Ayuda y Soporte', style: TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pushNamed(context, '/help');
                  },
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFB0B0B0)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                ),
                _settingsTile(icon: Icons.gavel, label: 'Términos y Condiciones'),
                _settingsTile(icon: Icons.policy, label: 'Política de Privacidad'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Botón cerrar sesión
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEA2A2A).withOpacity(0.1),
              foregroundColor: const Color(0xFFEA2A2A),
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar Sesión'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _settingsTile({required IconData icon, required String label, Widget? trailing}) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2563EB).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 40,
        height: 40,
        child: Icon(icon, color: const Color(0xFF2563EB)),
      ),
      title: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Color(0xFF6B7280)),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      minVerticalPadding: 0,
    );
  }

  Widget _settingsSwitchTile({required IconData icon, required String label, required bool value, required ValueChanged<bool> onChanged}) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2563EB).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 40,
        height: 40,
        child: Icon(icon, color: const Color(0xFF2563EB)),
      ),
      title: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF2563EB),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      minVerticalPadding: 0,
    );
  }
}
