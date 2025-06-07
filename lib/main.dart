import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/ReproduccionScreen.dart';

void main() {
  runApp(const ProyectoF());
}

class ProyectoF extends StatelessWidget {
  const ProyectoF({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Cuerpo());
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla de Inicio')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReproduccionScreen(),
              ),
            );
          },
          child: const Text('Ir a Reproductor'),
        ),
      ),
    );
  }
}
