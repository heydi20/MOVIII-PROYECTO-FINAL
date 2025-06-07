import 'package:flutter/material.dart';

class ReproduccionScreen extends StatelessWidget {
  const ReproduccionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:  Text('Reproducción de Película'),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Container(
            margin:  EdgeInsets.all(16),
            height: 220,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child:  Center(
              child: Icon(Icons.play_circle_fill, size: 64, color: Colors.white70),
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                Icon(Icons.fast_rewind, color: Colors.white, size: 32),
                Icon(Icons.pause_circle_filled, color: Colors.white, size: 48),
                Icon(Icons.fast_forward, color: Colors.white, size: 32),
              ],
            ),
          ),

          // Volumen
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                 Icon(Icons.volume_up, color: Colors.white),
                Expanded(
                  child: Slider(
                    value: 0.5,
                    onChanged: (_) {},
                    activeColor: Colors.tealAccent,
                    inactiveColor: Colors.white24,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  style: const TextStyle(color: Colors.white),
                  value: 'HD',
                  items: const [
                    DropdownMenuItem(value: 'SD', child: Text('Calidad: SD')),
                    DropdownMenuItem(value: 'HD', child: Text('Calidad: HD')),
                    DropdownMenuItem(value: 'FHD', child: Text('Calidad: FHD')),
                  ],
                  onChanged: (_) {},
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  style:  TextStyle(color: Colors.white),
                  value: 'Español',
                  items:  [
                    DropdownMenuItem(value: 'Español', child: Text('Sub: Español')),
                    DropdownMenuItem(value: 'Inglés', child: Text('Sub: Inglés')),
                  ],
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
