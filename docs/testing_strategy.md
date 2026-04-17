# Estrategia de Pruebas (Testing Strategy)

Este documento define los estándares y procedimientos para garantizar la calidad del código en `whatdoidraw?`. Se prioriza un enfoque de pirámide de pruebas, centrando el esfuerzo en la lógica de negocio y la estabilidad de la interfaz.

- **Unit Testing**: Probar la lógica de ViewModels y Servicios de forma aislada.
- **Static Analysis (Linting)**: Asegurar que el código cumple con los estándares de estilo y profesionalización.

---

## 🔍 Análisis Estático (Linting)

El análisis estático es la primera línea de defensa. Detecta errores comunes, código muerto y malas prácticas antes de ejecutar la aplicación.

### Reglas de Oro
1. **Zero Warnings**: El proyecto debe estar siempre limpio. Si el linter marca algo, debe corregirse o justificarse (con `// ignore`).
2. **Package Imports**: No uses imports relativos (`../../`). Usa siempre `package:whatdoidraw/...`.
3. **Inmutabilidad**: Usa `final` para variables locales y propiedades siempre que sea posible.

### Comandos Útiles
```bash
# Analizar todo el proyecto
flutter analyze

# Comprobar dependencias (obsolete)
dart pub outdated
```

---

## 🔝 Pirámide de Pruebas

Se han definido tres niveles de pruebas para asegurar una cobertura equilibrada:

1.  **Tests Unitarios (Lógica)**: Validación de modelos y lógica de los ViewModels.
2.  **Tests de Widgets (Interfaz)**: Verificación de la renderización de componentes y pantallas en aislamiento.
3.  **Tests de Integración (Flujo Real)**: Simulación de uso real del usuario navegando entre pantallas.

---

## 🧪 Tests Unitarios: El Corazón del MVVM

Dado que la lógica reside en los **ViewModels** (Riverpod Notifiers), es crítico probar las transiciones de estado.

### Qué probar en un ViewModel:
- **Estado Inicial**: Verificar que al construir el ViewModel, el estado sea el esperado (ej: `isLoading: false`).
- **Cambios de Estado**: Verificar que al ejecutar una acción (ej: `startStroke`), el estado se actualiza correctamente de forma inmutable.
- **Flujos Asíncronos**: Validar que el estado pase por `isLoading: true` y que finalmente maneje el éxito o el error.

### Uso de Mocks
Para evitar depender de Supabase o servicios externos, se utiliza la librería `mocktail`. Se deben simular todos los servicios que el ViewModel consume.

```dart
// Ejemplo conceptual de Mock
class MockContentCreationService extends Mock implements ContentCreationService {}
```

---

## 🎨 Tests de Widgets

Se deben probar los widgets clave para asegurar que reaccionan al estado del ViewModel.

- **Renderizado condicional**: Verificar que si el estado tiene un error, se muestra el componente de error.
- **Interacción**: Simular clics en botones y verificar que se invoca el método correspondiente del ViewModel.

---

## 🛠️ Comandos Útiles

Para ejecutar las pruebas y mantener el proyecto saludable, se utilizan los siguientes comandos:

### Ejecutar todos los tests
```bash
flutter test
```

### Ejecutar tests de un archivo específico
```bash
flutter test test/features/content_creation/viewmodels/doodle_canvas_test.dart
```

### Generación de Cobertura
Para visualizar qué partes del código no están probadas:
```bash
flutter test --coverage
# Para ver el reporte (requiere lcov instalado):
genhtml coverage/lcov.info -o coverage/html
```

---

## 🚨 Reglas de Oro para el Testing

1.  **Independencia**: Cada test debe ser independiente. No debe depender del resultado de un test anterior.
2.  **Determinismo**: Los tests deben pasar siempre bajo las mismas condiciones. Nunca deben depender de una conexión activa a internet. (Usar Mocks).
3.  **Nombramiento Claro**: El nombre del test debe describir el comportamiento esperado (ej: `should update state with new stroke when startStroke is called`).
