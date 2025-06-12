import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> with SingleTickerProviderStateMixin {
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasenia = TextEditingController();
  bool _isLoading = false;

  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  final Color _primaryColor = const Color(0xFF7B4EFF); 

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.9,
      upperBound: 1.0,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _correo.dispose();
    _contrasenia.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> registrarse() async {
    final correo = _correo.text.trim();
    final contrasenia = _contrasenia.text;

    if (correo.isEmpty || contrasenia.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final supabase = Supabase.instance.client;

    try {
      final res = await supabase.auth.signUp(
        email: correo,
        password: contrasenia,
      );

      final user = res.user;

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro exitoso para ${user.email}')),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: No se pudo registrar')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

@override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 39, 38, 38),
      iconTheme: const IconThemeData(
        color: Colors.white, 
      ),
    ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.grey[900]?.withOpacity(0.85),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withOpacity(0.6),
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Registrate",
                  style: TextStyle(
                    fontSize: 36,
                    color: _primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                    shadows: [
                      Shadow(
                        color: _primaryColor.withOpacity(0.7),
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                _styledTextField(
                  controller: _correo,
                  label: "Correo electrónico",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  color: _primaryColor,
                ),
                const SizedBox(height: 22),
                _styledTextField(
                  controller: _contrasenia,
                  label: "Contraseña",
                  icon: Icons.lock_outline,
                  obscureText: true,
                  color: _primaryColor,
                ),
                const SizedBox(height: 38),

                ScaleTransition(
                  scale: _scaleAnimation,
                  child: SizedBox(
                    width: size.width,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              await _animController.forward();
                              await _animController.reverse();
                              registrarse();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        shadowColor: _primaryColor.withOpacity(0.7),
                        elevation: 14,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Registrarse",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.4,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "¿Ya tienes cuenta? Inicia sesión",
                    style: TextStyle(
                      color: _primaryColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: _primaryColor.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _styledTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        cursorColor: color,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          prefixIcon: Icon(icon, color: color.withOpacity(0.9)),
          labelText: label,
          labelStyle: TextStyle(color: color.withOpacity(0.8)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
