# Arquitectura MVVM (Model-View-ViewModel) Orientada a Features

Este documento detalla la estructura base del proyecto para facilitar la integración de nuevos desarrolladores al entorno visual e interno de `whatdoidraw?`.

## Concepto
La app utiliza una fusión entre la estructura modular por funcionalidades de Flutter (Feature-first) y el patrón **MVVM** (Model-View-ViewModel) combinado de forma nativa con **Riverpod** para la inyección de dependencias y el manejo de estados reactivos.

## Estructura de Directorios (Aislada por cada Feature)

Al entrar a `lib/features/[nombre]`, se encuentra esta división sagrada:

```text
lib/
└── features/
    └── [nombre_feature]/
        ├── services/       # Conectividad directa (SupabaseClient, APIs externas, HTTP)
        ├── viewmodels/     # Riverpod Notifiers (El "ViewModel", estado reactivo)
        └── views/          # (LA CARA) UI
            ├── screens/      # Vistas de Flutter completas
            └── widgets/      # Componentes de presentación (botones, cards, modales)
```

## Reglas para Colaboradores
1. **Aislamiento del Estado:** Las pantallas (`views`) no deben hablar directamente con un `Service`. Un botón llama al `ViewModel` a través de Riverpod (`ref.read(...)`), y es el ViewModel quien orquesta la lógica y se comunica con el Service.
2. **Uso Exclusivo de Modelos Compartidos:** Preferiblemente, cualquier entidad física de datos (ej., una clase `IdeaModel` o `DoodleModel`) debe residir en `lib/shared/models/` para unificar el casteo de JSON (`freezed` / `json_serializable`) en lugar de aislar un modelo por cada feature que impida reutilizar código.
3. **Flujo Acíclico de MVVM:** `View (UI)` ➔ Ejecuta un método en el `ViewModel` ➔ El ViewModel pide operaciones al `Service` ➔ El Service retorna data/Status ➔ El ViewModel actualiza su estado interno ➔ La View se reconstruye automáticamente escuchando esos cambios (usando `ref.watch()`).
