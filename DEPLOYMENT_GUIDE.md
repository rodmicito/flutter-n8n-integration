# 📱 Guía de Instalación en Dispositivo Móvil

## ✅ Estado del Proyecto

- **APK Compilado:** ✅ `app-debug.apk` (89MB) listo para instalación
- **Repositorio Git:** ✅ Configurado con control de versiones
- **Documentación:** ✅ README.md y guías incluidas
- **Dispositivo Detectado:** ✅ Tecno KG5j (ID: 077353722K003063)

## 🚀 Instalación en Tecno KG5j

### Opción 1: Instalación Manual (Recomendada)

1. **Copiar APK al dispositivo:**
   ```
   Archivo: C:\Users\Rod\fluttern8n\my_flutter_app\mi_app_flutter\build\app\outputs\flutter-apk\app-debug.apk
   ```

2. **En tu dispositivo Tecno KG5j:**
   - Conecta vía USB y copia el archivo APK a Downloads
   - Ve a Configuración > Seguridad > Fuentes desconocidas > Habilitar
   - Abre el administrador de archivos
   - Navega a Downloads y toca `app-debug.apk`
   - Toca "Instalar"

### Opción 2: Instalación vía Flutter (Si ADB funciona)

```powershell
# Navegar al proyecto
cd "C:\Users\Rod\fluttern8n\my_flutter_app\mi_app_flutter"

# Verificar dispositivos conectados
flutter devices

# Instalar directamente en el dispositivo
flutter install --debug

# O ejecutar la app directamente
flutter run -d 077353722K003063
```

## 🧪 Pruebas Recomendadas

### Funcionalidad Básica
1. **Navegación:** Verificar transición entre pantallas
2. **Envío de Texto:** Escribir mensaje y enviar a n8n
3. **Selección de Imágenes:** Probar cámara y galería
4. **Recepción de Datos:** Verificar descarga desde n8n

### Permisos a Verificar
- [ ] Acceso a cámara
- [ ] Acceso a galería
- [ ] Acceso a internet
- [ ] Almacenamiento

## 🔧 Configuración n8n

### URLs Actuales (en n8n_service.dart)
```dart
final String sendEndpoint = 'https://rodmicito.app.n8n.cloud/webhook-test/esp32-supabase';
final String receiveEndpoint = 'https://rodmicito.app.n8n.cloud/webhook-test/esp32-supabase';
```

### Para Cambiar a Modo de Prueba
Editar `lib/services/n8n_service.dart`:
```dart
final bool isTestMode = true; // Cambiar a true
```

## 📊 Información del Build

- **Tamaño APK:** 89.2 MB
- **Versión:** 1.0.0
- **Target SDK:** Android API 21+
- **Arquitecturas:** arm64-v8a, armeabi-v7a

## 🐛 Solución de Problemas

### Si la instalación falla:
1. Verificar espacio disponible (>100MB)
2. Desinstalar versiones anteriores
3. Reiniciar dispositivo
4. Verificar que "Fuentes desconocidas" esté habilitado

### Si la app no funciona:
1. Verificar conexión a internet
2. Comprobar permisos de la app
3. Revisar logs con: `flutter logs`

## 📋 Próximos Pasos

1. **Instalar y probar en móvil**
2. **Configurar endpoints reales de n8n**
3. **Implementar funcionalidad de audio**
4. **Añadir manejo de errores mejorado**
5. **Crear versión de producción con:** `flutter build apk --release`

## 📞 Soporte

Para problemas o mejoras:
- Email: rodmycespedesarze@gmail.com
- Revisar logs en: `flutter logs`
- Crear issues en Git para seguimiento
