import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/n8n_service.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final TextEditingController _textController = TextEditingController();
  final N8NService _n8nService = N8NService();
  final ImagePicker _picker = ImagePicker();
  
  File? _selectedImage;
  bool _isSending = false;
  String _responseMessage = '';

  // Método para seleccionar imagen desde la cámara o galería
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galería'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Cámara'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Método para enviar datos a n8n
  Future<void> _sendToN8N() async {
    if (_textController.text.isEmpty && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes escribir un mensaje o seleccionar una imagen')),
      );
      return;
    }

    setState(() {
      _isSending = true;
      _responseMessage = '';
    });

    try {      final Map<String, dynamic> result = await _n8nService.sendData(
        text: _textController.text.isNotEmpty ? _textController.text : null,
        image: _selectedImage,
        audio: null,
      );

      setState(() {
        _isSending = false;
        if (result['statusCode'] == 200) {
          _responseMessage = '✅ Enviado exitosamente: ${result['body']}';
          _textController.clear();
          _selectedImage = null;
        } else {
          _responseMessage = '❌ Error: ${result['body']}';
        }
      });
    } catch (e) {
      setState(() {
        _isSending = false;
        _responseMessage = '❌ Error de conexión: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enviar a n8n',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Campo de texto
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Mensaje',
                hintText: 'Escribe tu mensaje aquí',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            
            // Botón para seleccionar imagen
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text('Seleccionar Imagen'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Mostrar imagen seleccionada
            if (_selectedImage != null) ...[
              const Text(
                'Vista previa:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
            
            // Botón enviar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendToN8N,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isSending
                    ? const CircularProgressIndicator()
                    : const Text('ENVIAR A N8N', style: TextStyle(fontSize: 16)),
              ),
            ),
            
            // Mostrar respuesta
            if (_responseMessage.isNotEmpty) ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_responseMessage),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
