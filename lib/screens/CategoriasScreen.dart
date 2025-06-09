import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:proyecto_final/screens/ReproduccionScreen.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'oyRxxpD3yNw',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 170, 181, 240),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.play_circle_fill),
            tooltip: 'Ir a reproducción',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReproduccionScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              const Expanded(child: Peliculas()),
            ],
          );
        },
      ),
    );
  }
}



class Peliculas extends StatelessWidget {
    const Peliculas({super.key});

  final List<Map<String, dynamic>> peliculas = const [
    {
      'titulo': 'Avengers: Endgame',
      'imagen': 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
      'descripcion': 'Los Vengadores se unen para revertir el Snap de Thanos',
      'categoria': 'Populares'
    },
    {
      'titulo': 'Spider-Man: No Way Home',
      'imagen': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'descripcion': 'Spider-Man y el multiverso',
      'categoria': 'Populares'
    },
    {
      'titulo': 'The Dark Knight',
      'imagen': 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      'descripcion': 'Batman enfrenta al Joker en Gotham City',
      'categoria': 'Populares'
    },
    {
      'titulo': 'Inception',
      'imagen': 'https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
      'descripcion': 'Un ladrón roba secretos del subconsciente',
      'categoria': 'Populares'
    },
    {
      'titulo': 'The Batman',
      'imagen': 'https://image.tmdb.org/t/p/w500/seyWFgGInaLqW7nOZvu0ZC95rtx.jpg',
      'descripcion': 'Batman investiga la corrupción en Gotham City',
      'categoria': 'Tendencias'
    },
    {
      'titulo': 'John Wick 4',
      'imagen': 'https://m.media-amazon.com/images/I/81J1DaRKzUL._AC_UF894,1000_QL80_.jpg',
      'descripcion': 'John Wick lucha contra una organización global',
      'categoria': 'Tendencias'
    },
    {
      'titulo': 'Top Gun: Maverick',
      'imagen': 'https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg',
      'descripcion': 'El regreso de Maverick a la acción aérea',
      'categoria': 'Tendencias'
    },
    {
      'titulo': 'Fast X',
      'imagen': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdclSiC.jpg',
      'descripcion': 'La familia se enfrenta a su mayor amenaza',
      'categoria': 'Tendencias'
    },
    {
      'titulo': 'Dune',
      'imagen': 'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
      'descripcion': 'Adaptación de la novela de ciencia ficción',
      'categoria': 'Nuevas Llegadas'
    },
    {
      'titulo': 'The Marvels',
      'imagen': 'https://lumiere-a.akamaihd.net/v1/images/56245l11a_goat_philippines_apac_poster_1sht_e357e03a.jpeg?region=0%2C0%2C2592%2C3840',
      'descripcion': 'Carol Danvers se une a nuevos héroes',
      'categoria': 'Nuevas Llegadas'
    },
    {
      'titulo': 'Wish',
      'imagen': 'https://lumiere-a.akamaihd.net/v1/images/image_579e2622.jpeg?region=0,0,540,810',
      'descripcion': 'Una historia mágica sobre deseos y esperanza',
      'categoria': 'Nuevas Llegadas'
    },
    {
      'titulo': 'Wonka',
      'imagen': 'https://image.tmdb.org/t/p/w500/qhb1qOilapbapxWQn9jtRCMwXJF.jpg',
      'descripcion': 'Orígenes del famoso chocolatero',
      'categoria': 'Nuevas Llegadas'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSeccionPeliculas(context, 'Populares'),
          _buildSeccionPeliculas(context, 'Tendencias'),
          _buildSeccionPeliculas(context, 'Nuevas Llegadas'),
        ],
      ),
    );
  }

  Widget _buildSeccionPeliculas(BuildContext context, String categoria) {
    var peliculasFiltradas = peliculas.where((p) => p['categoria'] == categoria).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            categoria,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: peliculasFiltradas.length,
            itemBuilder: (context, index) {
              var pelicula = peliculasFiltradas[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(pelicula['titulo']),
                      content: Text(pelicula['descripcion']),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          pelicula['imagen'],
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 150,
                            width: 150,
                            color: Colors.grey,
                            child: const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pelicula['titulo'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        pelicula['descripcion'],
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
