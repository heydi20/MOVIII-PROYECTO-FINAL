import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 
import 'package:proyecto_final/navigation/Drawer.dart';
import 'package:proyecto_final/screens/CategoriasScreen.dart';
import 'package:proyecto_final/screens/auth/LoginScreen.dart';
import 'package:proyecto_final/screens/auth/RegisterScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://smvgtvblaflvfbzcmngk.supabase.co',     
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNtdmd0dmJsYWZsdmZiemNtbmdrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk2NDQzOTgsImV4cCI6MjA2NTIyMDM5OH0.GQHAPqGZLKGel2ux8DzUiMRSW7W_atSoD46pwxNYEsU',                
  );

  runApp(const ProyectoF());
}

class ProyectoF extends StatelessWidget {
  const ProyectoF({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  final Color _backgroundColor = const Color(0xFF121212);
  final Color _primaryPurple = const Color(0xFF7B4EFF);
  final Color _buttonPurple = const Color(0xFF9A67EA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Bienvenida',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.3,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const MiDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _backgroundColor,
              _backgroundColor.withOpacity(0.85),
              _primaryPurple.withOpacity(0.25),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/logo.jpg',
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '¡Bienvenid@!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _primaryPurple,
                    shadows: [
                      Shadow(
                        color: _primaryPurple.withOpacity(0.7),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Explora una amplia colección de películas en distintos géneros, '
                  'desde clásicos inolvidables hasta los últimos estrenos.\n\n',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[300],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _purpleButton(
                  context,
                  icon: Icons.login,
                  label: 'Iniciar sesión',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Login()),
                    );
                  },
                  backgroundColor: _buttonPurple,
                ),
                const SizedBox(height: 20),
                _purpleButton(
                  context,
                  icon: Icons.app_registration,
                  label: 'Registrarse',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Registro()),
                    );
                  },
                  backgroundColor: _primaryPurple,
                ),
              
              
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _purpleButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed,
      required Color backgroundColor}) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white, size: 28),
      label: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: backgroundColor.withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        minimumSize: const Size(220, 55),
      ),
      onPressed: onPressed,
    );
  }
}
