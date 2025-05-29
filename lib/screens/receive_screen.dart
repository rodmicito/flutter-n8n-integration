import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/n8n_service.dart';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  final N8NService _n8nService = N8NService();
  bool _isLoading = false;
  Map<String, dynamic>? _receivedData;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  // Método para recibir datos desde n8n
  Future<void> _fetchFromN8N() async {
    setState(() {
      _isLoading = true;
      _receivedData = null;
    });

    try {
      final result = await _n8nService.receiveData();
      
      if (result['statusCode'] == 200) {
        setState(() {
          _receivedData = result['data'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${result['error']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Método para reproducir audio
  Future<void> _playAudio(String url) async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
      return;
    }
    
    try {
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        _isPlaying = true;
      });
      
      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          _isPlaying = false;
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al reproducir audio: $e')),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recibir desde n8n',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Botón para recibir datos
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _fetchFromN8N,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('RECIBIR DE N8N', style: TextStyle(fontSize: 16)),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Mostrar datos recibidos
          Expanded(
            child: _receivedData == null
                ? const Center(
                    child: Text('No hay datos recibidos. Presiona el botón para recibir datos.'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mostrar texto recibido
                        if (_receivedData!.containsKey('text')) ...[
                          const Text(
                            'Mensaje de texto:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(_receivedData!['text']),
                          ),
                          const SizedBox(height: 30),
                        ],
                        
                        // Mostrar imagen recibida
                        if (_receivedData!.containsKey('imageUrl')) ...[
                          const Text(
                            'Imagen:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: _receivedData!['imageUrl'],
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) => const Center(
                                  child: Icon(Icons.error, size: 50, color: Colors.red),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                        
                        // Mostrar audio recibido
                        if (_receivedData!.containsKey('audioUrl')) ...[
                          const Text(
                            'Audio:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: InkWell(
                                onTap: () => _playAudio(_receivedData!['audioUrl']),
                                child: Icon(
                                  _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                                  size: 50,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              title: const Text('Archivo de audio'),
                              subtitle: Text(
                                _receivedData!['audioUrl'].split('/').last,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
