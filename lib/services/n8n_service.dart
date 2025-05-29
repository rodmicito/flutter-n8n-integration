import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:record/record.dart';  // Temporalmente comentado

class N8NService {
  // URL de tu webhook n8n para enviar datos
  // URL real del webhook n8n
  final String sendEndpoint = 'https://rodmicito.app.n8n.cloud/webhook-test/esp32-supabase';
  
  // URL para recibir datos desde n8n
  // URL real del endpoint para recibir datos
  final String receiveEndpoint = 'https://rodmicito.app.n8n.cloud/webhook-test/esp32-supabase';
  
  // Modo de simulación para pruebas
  final bool isTestMode = false;
  // Método para enviar datos a n8n
  Future<Map<String, dynamic>> sendData({
    String? text,
    File? image,
    File? audio,
  }) async {
    try {
      // Crear un objeto JSON para la carga útil
      Map<String, dynamic> payload = {};
      
      // Agregar texto si existe
      if (text != null && text.isNotEmpty) {
        payload['mensaje'] = text;
      }
      
      // Para datos binarios como imágenes y audio, enviamos una URL de referencia o base64
      // En un escenario real, primero subirías los archivos a un almacenamiento y luego enviarías las URLs
      if (image != null) {
        // Ejemplo: enviar información sobre la imagen
        payload['imagen'] = 'imagen_seleccionada';
      }
      
      if (audio != null) {
        // Ejemplo: enviar información sobre el audio
        payload['audio'] = 'audio_seleccionado';
      }
      
      // Crear encabezados para la solicitud
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      
      // Enviar la solicitud POST con un cuerpo JSON
      final response = await http.post(
        Uri.parse(sendEndpoint),
        headers: headers,
        body: json.encode(payload),
      );
      
      var responseData = response.body;
      
      return {
        'statusCode': response.statusCode,
        'data': responseData,
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'error': e.toString(),
      };
    }
  }  // Método para recibir datos desde n8n
  Future<Map<String, dynamic>> receiveData() async {
    // Si estamos en modo de prueba, devolvemos datos simulados
    if (isTestMode) {
      return {
        'statusCode': 200,
        'data': {
          'text': 'Este es un mensaje de texto de prueba desde n8n',
          'imageUrl': 'https://picsum.photos/800/600',
          'audioUrl': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        },
      };
    }
    
    try {
      // Para recibir datos, hacemos una solicitud GET con encabezados adecuados
      final Map<String, String> headers = {
        'Accept': 'application/json',
      };
      
      final response = await http.get(
        Uri.parse(receiveEndpoint),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        // Intentar analizar la respuesta como JSON
        try {
          final parsedData = json.decode(response.body);
          return {
            'statusCode': 200,
            'data': parsedData,
          };
        } catch (e) {
          // Si no se puede analizar como JSON, devolver el texto plano
          return {
            'statusCode': 200,
            'data': {
              'text': response.body,
            },
          };
        }
      } else {
        return {
          'statusCode': response.statusCode,
          'error': 'Error al obtener datos de n8n: ${response.reasonPhrase}',
        };
      }
    } catch (e) {
      return {
        'statusCode': 500,
        'error': e.toString(),
      };
    }
  }
}
