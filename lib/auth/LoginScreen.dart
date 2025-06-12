import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/CategoriasScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatelessWidget {
  const Login({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 39, 38, 38), 
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 39, 38, 38), 
      iconTheme: const IconThemeData(
        color: Colors.white, 
      ),
    ),
    body: formularioLogin(context),
  );
}
}

Widget formularioLogin(BuildContext context) {
  TextEditingController _correo = TextEditingController();
  TextEditingController _contrasenia = TextEditingController();

  return Center(
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1B24),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurpleAccent.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "INICIA SESIÓN",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurpleAccent,
                letterSpacing: 3,
                shadows: [
                  Shadow(
                    color: Colors.deepPurpleAccent,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _correo,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF2A2735),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                labelText: "Correo",
                labelStyle: TextStyle(color: Colors.deepPurpleAccent.shade100),
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.deepPurpleAccent),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _contrasenia,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF2A2735),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                labelText: "Contraseña",
                labelStyle: TextStyle(color: Colors.deepPurpleAccent.shade100),
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.deepPurpleAccent),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                  shadowColor: Colors.deepPurpleAccent.shade200,
                ),
                onPressed: () => login(_correo.text, _contrasenia.text, context),
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(0, 1),
                        blurRadius: 3,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "¿No tienes cuenta? Regístrate ahora",
              style: TextStyle(
                color: Colors.deepPurpleAccent.shade200,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//SUPABASE
Future<void> login(String correo, String contrasenia, BuildContext context) async {
  if (correo.isEmpty || contrasenia.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor completa todos los campos')),
    );
    return;
  }

  final supabase = Supabase.instance.client;

  try {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: correo,
      password: contrasenia,
    );

    final User? user = res.user;

    if (user != null) {
     
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CategoriasScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No se pudo iniciar sesión')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al iniciar sesión: $e')),
    );
  }
}
