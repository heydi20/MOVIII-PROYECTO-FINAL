import 'package:flutter/material.dart';
import 'package:proyecto_final/navigation/Drawer.dart';
import 'package:proyecto_final/screens/LoginScreen.dart';
import 'package:proyecto_final/screens/RegisterScreen.dart';

void main() {
  runApp(const ProyectoF());
}

class ProyectoF extends StatelessWidget {
  const ProyectoF({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Cuerpo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Bienvenida'),
          backgroundColor: const Color.fromARGB(255, 170, 181, 240),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: const MiDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/logo.jpg',
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '¡Bienvenido a nuestra aplicación!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            const Text(
              'Explora una amplia colección de películas en distintos géneros, desde clásicos inolvidables '
              'hasta los últimos estrenos.\n\n',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('Iniciar sesión'),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
              icon: const Icon(Icons.app_registration),
              label: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
