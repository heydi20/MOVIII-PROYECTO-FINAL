import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:proyecto_final/screens/ReproduccionScreen.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> 
    with TickerProviderStateMixin {
  late YoutubePlayerController _controller;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> peliculasDestacadas = const [
    {
      'titulo': 'Avengers: Endgame',
      'imagen': 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
      'descripcion': 'Los Vengadores se reúnen para revertir el Snap de Thanos',
      'categoria': 'Acción',
      'trailerId': 'TcMBFSGVi1c',
      'peliculaId': 'PLl99DlL6b4'
    },
    {
      'titulo': 'Dune',
      'imagen': 'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
      'descripcion': 'Un joven heredero viaja al planeta más peligroso del universo',
      'categoria': 'Ciencia Ficción',
      'trailerId': 'n9xhJrPXop4',
      'peliculaId': 'uPIEn0M8su0'
    },
    {
      'titulo': 'Spider-Man: No Way Home',
      'imagen': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'descripcion': 'Peter Parker desata un multiverso al pedir ayuda a Doctor Strange',
      'categoria': 'Superhéroes',
      'trailerId': 'JfVOs4VSpmA',
      'peliculaId': 'x8-7mHT9edI'
    },
    {
      'titulo': 'The Batman',
      'imagen': 'https://image.tmdb.org/t/p/w500/seyWFgGInaLqW7nOZvu0ZC95rtx.jpg',
      'descripcion': 'Batman investiga la corrupción en Gotham cuando aparece el Acertijo',
      'categoria': 'Superhéroes',
      'trailerId': 'mqqft2x_Aa4',
      'peliculaId': 'aS_d0Ayjw4o'
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'oyRxxpD3yNw',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 38, 38),
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
          ).createShader(bounds),
          child: const Text(
            'FLIXLY',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 3,
              shadows: [
                Shadow(
                  color: Colors.deepPurpleAccent,
                  blurRadius: 10,
                  offset: Offset(0, 0),
            )],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 39, 38, 38),
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurpleAccent.withOpacity(0.5),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
            )],
            ),
            child: IconButton(
              icon: const Icon(Icons.play_circle_fill, color: Colors.white),
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
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Carrusel de películas destacadas
            SizedBox(
              height: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                    child: Text(
                      'PELÍCULAS DESTACADAS',
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: peliculasDestacadas.length,
                      itemBuilder: (context, index) {
                        var pelicula = peliculasDestacadas[index];
                        return GestureDetector(
                          onTap: () {
                            _showMovieOptionsDialog(context, pelicula, [Colors.deepPurpleAccent, Colors.purpleAccent]);
                          },
                          child: Container(
                            width: 180,
                            margin: EdgeInsets.only(
                              left: index == 0 ? 20 : 12,
                              right: index == peliculasDestacadas.length - 1 ? 20 : 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.deepPurpleAccent.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        pelicula['imagen'],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          color: Colors.grey[800],
                                          child: const Center(
                                            child: Icon(Icons.broken_image, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  pelicula['titulo'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  pelicula['categoria'],
                                  style: TextStyle(
                                    color: Colors.deepPurpleAccent[200],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Lista de categorías
            Expanded(
              child: Peliculas(
                parentController: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMovieOptionsDialog(BuildContext context, Map<String, dynamic> pelicula, List<Color> gradientColors) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1B24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            pelicula['titulo'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  pelicula['imagen'],
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                pelicula['descripcion'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '¿QUÉ DESEAS HACER?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          actions: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: Colors.orange.shade200,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _controller.load(pelicula['trailerId']);
                    },
                    child: const Text(
                      "VER TRAILER",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: Colors.deepPurpleAccent.shade200,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _controller.load(pelicula['peliculaId']);
                    },
                    child: const Text(
                      "VER PELÍCULA",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "CANCELAR",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent.shade200,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class Peliculas extends StatefulWidget {
  final YoutubePlayerController parentController;
  
  const Peliculas({super.key, required this.parentController});

  @override
  State<Peliculas> createState() => _PeliculasState();
}

class _PeliculasState extends State<Peliculas> with TickerProviderStateMixin {
  late AnimationController _slideController;

  final List<Map<String, dynamic>> peliculas = const [
    {
      'titulo': 'The Shawshank Redemption',
      'imagen': 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
      'descripcion': 'La historia de esperanza y amistad en una prisión',
      'categoria': 'Drama',
      'trailerId': '6hB3S9bIaco',
      'peliculaId': 'PLl99DlL6b4'
    },
    {
      'titulo': 'Forrest Gump',
      'imagen': 'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
      'descripcion': 'La extraordinaria vida de un hombre con buen corazón',
      'categoria': 'Drama',
      'trailerId': 'bLvqoHBptjg',
      'peliculaId': 'uPIEn0M8su0'
    },
    {
      'titulo': 'The Pursuit of Happyness',
      'imagen': 'https://image.tmdb.org/t/p/w500/6dXA5F7YgOpYGiSrL6PIdVPbdPH.jpg',
      'descripcion': 'Un padre lucha por construir un mejor futuro para su hijo',
      'categoria': 'Drama',
      'trailerId': 'DMOBlEcRuw8',
      'peliculaId': 'x8-7mHT9edI'
    },
    {
      'titulo': 'A Beautiful Mind',
      'imagen': 'https://image.tmdb.org/t/p/w500/zwzWCmH72OSC9NA0ipoqw5Zjya8.jpg',
      'descripcion': 'Un genio matemático lucha contra la esquizofrenia',
      'categoria': 'Drama',
      'trailerId': 'YWwAOutgWBQ',
      'peliculaId': 'aS_d0Ayjw4o'
    },
    {
      'titulo': 'Green Book',
      'imagen': 'https://image.tmdb.org/t/p/w500/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg',
      'descripcion': 'Una amistad improbable durante un viaje por el sur',
      'categoria': 'Drama',
      'trailerId': 'QkZxoko_HC0',
      'peliculaId': 'R9m5e8gBsws'
    },
    {
      'titulo': 'Good Will Hunting',
      'imagen': 'https://image.tmdb.org/t/p/w500/bABCBKYBK7A5G1x0FzoeoNfuj2.jpg',
      'descripcion': 'Un joven genio debe encontrar su camino en la vida',
      'categoria': 'Drama',
      'trailerId': 'PaZVjZEFkRs',
      'peliculaId': 'gdkKKlJtT8o'
    },
    {
      'titulo': 'The Hangover',
      'imagen': 'https://image.tmdb.org/t/p/w500/uluhlXqQpCAMess8S6CwuZbhoCU.jpg',
      'descripcion': 'Cuatro amigos intentan recordar su loca noche en Las Vegas',
      'categoria': 'Comedia',
      'trailerId': 'tcdUhdOlz9M',
      'peliculaId': 'UjJcWWMOhAI'
    },
    {
      'titulo': 'Superbad',
      'imagen': 'https://image.tmdb.org/t/p/w500/ek8e8txUyUwd2BNqj6lFEerJfbq.jpg',
      'descripcion': 'Dos mejores amigos en una aventura épica por alcohol',
      'categoria': 'Comedia',
      'trailerId': '4eaZ_48ZYog',
      'peliculaId': 'MNpoTxeydiY'
    },
    {
      'titulo': 'Anchorman',
      'imagen': 'https://image.tmdb.org/t/p/w500/zJPLiJ7ASDaLXkUBGGjCN55XDWY.jpg',
      'descripcion': 'Un presentador machista se enfrenta a una reportera',
      'categoria': 'Comedia',
      'trailerId': 'NJQ4qEWm9lU',
      'peliculaId': '8BBF3bLfhjs'
    },
    {
      'titulo': 'Step Brothers',
      'imagen': 'https://image.tmdb.org/t/p/w500/wJYfuoUTRj4yNlSbNWAGKhBL9z7.jpg',
      'descripcion': 'Dos hermanastros adultos causan caos en casa',
      'categoria': 'Comedia',
      'trailerId': 'LbH4Xx8VBfg',
      'peliculaId': 'PcDXTCz9bKI'
    },
    {
      'titulo': 'Dumb and Dumber',
      'imagen': 'https://image.tmdb.org/t/p/w500/m8gPPKThRMKqLjCjvl3nP4Y8BqI.jpg',
      'descripcion': 'Dos amigos idiotas emprenden un viaje desastroso',
      'categoria': 'Comedia',
      'trailerId': 'l13yPhimE3o',
      'peliculaId': 'LBfJrm0VQ4Q'
    },
    {
      'titulo': 'Zoolander',
      'imagen': 'https://image.tmdb.org/t/p/w500/qdrbStAuvVqs2gBpvvHNtBZ8wGz.jpg',
      'descripcion': 'Un modelo masculino debe salvar al mundo de la moda',
      'categoria': 'Comedia',
      'trailerId': 'E6egGKDsQyU',
      'peliculaId': 'BkdBmZP7Rlw'
    },
    {
      'titulo': 'The Conjuring',
      'imagen': 'https://image.tmdb.org/t/p/w500/wVYREutTvI2tmxr6ujrHT704wGF.jpg',
      'descripcion': 'Investigadores paranormales ayudan a una familia aterrorizada',
      'categoria': 'Terror',
      'trailerId': 'k10ETZ41q5o',
      'peliculaId': 'ejMMn0t58Lc'
    },
    {
      'titulo': 'Hereditary',
      'imagen': 'https://image.tmdb.org/t/p/w500/lHV8HHlhwNup2VbpiACtlKzaGIQ.jpg',
      'descripcion': 'Una familia devastada descubre secretos aterradores',
      'categoria': 'Terror',
      'trailerId': 'V6wWKNij_1M',
      'peliculaId': 'YHxcDbai7aU'
    },
    {
      'titulo': 'A Quiet Place',
      'imagen': 'https://image.tmdb.org/t/p/w500/nAU74GmpUk7t5iklEp3bufwDq4n.jpg',
      'descripcion': 'Una familia vive en silencio para evitar criaturas mortales',
      'categoria': 'Terror',
      'trailerId': 'WR7cc5t7tv8',
      'peliculaId': 'XEMwSdne6UE'
    },
    {
      'titulo': 'Get Out',
      'imagen': 'https://image.tmdb.org/t/p/w500/tFXcEccSQMf3lfhfXKSU9iRBpa3.jpg',
      'descripcion': 'Un joven descubre secretos perturbadores en casa de su novia',
      'categoria': 'Terror',
      'trailerId': 'DzfpyUB60YY',
      'peliculaId': 'sRfnevzM9kQ'
    },
    {
      'titulo': 'It',
      'imagen': 'https://image.tmdb.org/t/p/w500/9E2y5Q7WlCVNEhP5GiVTjhEhx1o.jpg',
      'descripcion': 'Un grupo de niños enfrenta a un payaso demoníaco',
      'categoria': 'Terror',
      'trailerId': 'FnCdOQsX5kc',
      'peliculaId': 'hEH1bRF62MM'
    },
    {
      'titulo': 'The Babadook',
      'imagen': 'https://image.tmdb.org/t/p/w500/lWANJ2tTCDIbJbdMAICrw1WTY9l.jpg',
      'descripcion': 'Una madre soltera lucha contra una presencia siniestra',
      'categoria': 'Terror',
      'trailerId': 'k5WQZzDRVtw',
      'peliculaId': 'sz9GqLhHE7M'
    },
  ];

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedBuilder(
        animation: _slideController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - _slideController.value)),
            child: Opacity(
              opacity: _slideController.value,
              child: Column(
                children: [
                  _buildSeccionPeliculas(context, 'Drama'),
                  _buildSeccionPeliculas(context, 'Comedia'),
                  _buildSeccionPeliculas(context, 'Terror'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeccionPeliculas(BuildContext context, String categoria) {
    var peliculasFiltradas = peliculas.where((p) => p['categoria'] == categoria).toList();

    List<Color> gradientColors;
    
    switch (categoria) {
      case 'Drama':
        gradientColors = [Colors.blue.shade600, Colors.blue.shade400];
        break;
      case 'Comedia':
        gradientColors = [Colors.orange.shade600, Colors.orange.shade400];
        break;
      case 'Terror':
        gradientColors = [Colors.red.shade600, Colors.red.shade400];
        break;
      default:
        gradientColors = [Colors.deepPurpleAccent, Colors.purpleAccent];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
          child: Text(
            categoria.toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
              letterSpacing: 2,
            ),
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
                  _showMovieOptionsDialog(context, pelicula, gradientColors);
                },
                child: Container(
                  width: 140,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 20 : 12,
                    right: index == peliculasFiltradas.length - 1 ? 20 : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurpleAccent.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            pelicula['imagen'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[800],
                              child: const Center(
                                child: Icon(Icons.broken_image, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pelicula['titulo'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  void _showMovieOptionsDialog(BuildContext context, Map<String, dynamic> pelicula, List<Color> gradientColors) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1B24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            pelicula['titulo'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  pelicula['imagen'],
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                pelicula['descripcion'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '¿QUÉ DESEAS HACER?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          actions: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: Colors.orange.shade200,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.parentController.load(pelicula['trailerId']);
                    },
                    child: const Text(
                      "VER TRAILER",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: Colors.deepPurpleAccent.shade200,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.parentController.load(pelicula['peliculaId']);
                    },
                    child: const Text(
                      "VER PELÍCULA",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "CANCELAR",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent.shade200,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}