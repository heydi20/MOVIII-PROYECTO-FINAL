import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId; // ID dinámico del video a reproducir

  const VideoPlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;
  double _playbackSpeed = 1.0;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        enableCaption: true,
        controlsVisibleAtStart: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void _toggleFullScreen() async {
    if (_isFullScreen) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  void _seek(int seconds) {
    final currentPosition = _controller.value.position;
    _controller.seekTo(currentPosition + Duration(seconds: seconds));
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.deepPurpleAccent.shade700,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Ajustes de Reproducción",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Velocidad", style: TextStyle(color: Colors.white)),
                    DropdownButton<double>(
                      dropdownColor: Colors.deepPurple,
                      value: _playbackSpeed,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _playbackSpeed = value;
                          });
                          _controller.setPlaybackRate(value);
                          Navigator.pop(context);
                        }
                      },
                      items: [0.5, 1.0, 1.5, 2.0].map((speed) {
                        return DropdownMenuItem(
                          value: speed,
                          child: Text(
                            "${speed}x",
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Calidad y subtítulos no disponibles por restricciones de YouTube.",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.deepPurpleAccent,
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(child: player),

              // Controles superpuestos
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Fila superior: botón salir, ajustes, pantalla completa
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                if (_isFullScreen) {
                                  _toggleFullScreen();
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.settings, color: Colors.white),
                              onPressed: _showSettingsModal,
                            ),
                            IconButton(
                              icon: Icon(
                                _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                                color: Colors.white,
                              ),
                              onPressed: _toggleFullScreen,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Fila central: retroceder, volumen, adelantar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.replay_10, size: 36, color: Colors.white),
                          onPressed: () => _seek(-10),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                            size: 36,
                          ),
                          onPressed: () {
                            setState(() {
                              _isMuted = !_isMuted;
                              if (_isMuted) {
                                _controller.mute();
                              } else {
                                _controller.unMute();
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.forward_10, size: 36, color: Colors.white),
                          onPressed: () => _seek(10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40), // Espacio inferior
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
