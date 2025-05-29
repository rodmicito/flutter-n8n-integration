# Flutter n8n Integration App

Una aplicación Flutter que permite enviar y recibir texto, imágenes y audio desde/hacia n8n.

## 📱 Características

- **Envío de datos a n8n:**
  - Envío de mensajes de texto
  - Selección de imágenes desde cámara o galería
  - Preparado para grabación de audio (próximamente)

- **Recepción de datos desde n8n:**
  - Recepción de texto
  - Visualización de imágenes desde URLs
  - Reproducción de audio desde URLs

## 🛠️ Tecnologías

- **Flutter SDK** - Framework principal
- **http** - Para comunicación con APIs
- **image_picker** - Selección de imágenes
- **audioplayers** - Reproducción de audio
- **cached_network_image** - Cache de imágenes de red

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── screens/
│   ├── home_screen.dart     # Pantalla principal con navegación
│   ├── send_screen.dart     # Pantalla para enviar datos
│   └── receive_screen.dart  # Pantalla para recibir datos
└── services/
    └── n8n_service.dart     # Servicio para comunicación con n8n
```

## 🔧 Configuración

### Endpoints n8n

El archivo `lib/services/n8n_service.dart` contiene las URLs de los webhooks:

```dart
final String sendEndpoint = 'https://rodmicito.app.n8n.cloud/webhook-test/esp32-supabase';
final String receiveEndpoint = 'https://rodmicito.app.n8n.cloud/webhook-test/esp32-supabase';
```

### Modo de Prueba

Para pruebas, cambia `isTestMode` a `true` en `n8n_service.dart`:

```dart
final bool isTestMode = false; // Cambiar a true para modo de prueba
```

## 🚀 Instalación y Uso

### Prerrequisitos

- Flutter SDK instalado
- Android Studio o VS Code con extensiones de Flutter
- Dispositivo Android con USB debugging habilitado

### Pasos

1. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

2. **Ejecutar en Chrome (para pruebas):**
   ```bash
   flutter run -d chrome
   ```

3. **Compilar para Android:**
   ```bash
   flutter build apk --debug
   ```

4. **Instalar en dispositivo:**
   ```bash
   flutter install
   ```

## 📱 Dispositivos Compatibles

- **Navegadores:** Chrome, Edge, Firefox
- **Android:** API nivel 21+ (Android 5.0+)
- **iOS:** iOS 12.0+
- **Escritorio:** Windows, macOS, Linux

## 🔒 Permisos

### Android (`android/app/src/main/AndroidManifest.xml`)
- `INTERNET` - Comunicación con n8n
- `CAMERA` - Acceso a la cámara
- `RECORD_AUDIO` - Grabación de audio
- `READ_EXTERNAL_STORAGE` - Lectura de archivos
- `WRITE_EXTERNAL_STORAGE` - Escritura de archivos

### iOS (`ios/Runner/Info.plist`)
- `NSCameraUsageDescription`
- `NSMicrophoneUsageDescription`
- `NSPhotoLibraryUsageDescription`

## 📋 Tareas Pendientes

- [ ] Implementar grabación de audio completa
- [ ] Mejorar manejo de errores
- [ ] Añadir tests unitarios
- [ ] Implementar modo offline
- [ ] Añadir notificaciones push

## 🐛 Problemas Conocidos

- Los paquetes `file_picker` y `record` están temporalmente deshabilitados debido a incompatibilidades
- Funcionalidad de audio limitada en la versión actual

## 📝 Historial de Versiones

### v1.0.0 (Initial Release)
- ✅ Estructura básica de la aplicación
- ✅ Pantallas de envío y recepción
- ✅ Integración con n8n webhooks
- ✅ Selección de imágenes
- ✅ Interfaz de usuario funcional
- ✅ Compilación exitosa para Android

## 🤝 Contribuciones

Para contribuir al proyecto:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -m 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la licencia MIT.

## 👨‍💻 Autor

Rod - rodmycespedesarze@gmail.com
