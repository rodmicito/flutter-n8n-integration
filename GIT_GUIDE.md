# Git Configuration for Flutter n8n Integration Project

## Comandos útiles para el desarrollo

### Ver estado del proyecto
```bash
git status
git log --oneline --graph
git tag --list
```

### Crear nueva rama para features
```bash
git checkout -b feature/nueva-funcionalidad
git checkout -b fix/correccion-bug
```

### Commits siguiendo convención
```bash
git commit -m "feat: nueva funcionalidad"
git commit -m "fix: corregir bug"
git commit -m "docs: actualizar documentación"
git commit -m "style: cambios de formato"
git commit -m "refactor: refactorizar código"
git commit -m "test: añadir tests"
```

### Crear nuevas versiones
```bash
git tag -a v1.1.0 -m "Version 1.1.0: descripción"
git tag -a v1.0.1 -m "Version 1.0.1: bug fixes"
```

### Branches recomendadas
- `master/main` - Código de producción
- `develop` - Desarrollo activo
- `feature/*` - Nuevas funcionalidades
- `fix/*` - Corrección de bugs
- `hotfix/*` - Correcciones urgentes

### Ignorar archivos adicionales
Si necesitas ignorar más archivos, edita `.gitignore`

### Backup del proyecto
```bash
git bundle create mi_app_flutter_backup.bundle --all
```
