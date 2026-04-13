# Arquitectura Clean Orientada a Features (Feature-Driven Clean Architecture)

Este documento detalla la estructura base del proyecto para facilitar la integración de nuevos desarrolladores al entorno visual e interno de `whatdoidraw?`.

## Concepto
La app utiliza una fusión entre la estructura modular por funcionalidades de Flutter (Feature-first) y el patrón clásico de **Clean Architecture** (Domain, Data, Presentation). El objetivo es desvincular un 100% la interfaz gráfica y los estados dinámicos del motor de bases de datos.

## Estructura de Directorios (Aislada por cada Feature)

Al entrar a `lib/features/[nombre]`, encontrarás esta división sagrada:

```text
lib/
└── features/
    └── [nombre_feature]/
        ├── domain/           # (EL CEREBRO) Puro Dart, desconoce a Flutter
        │   ├── entities/       # Objetos de negocio puros
        │   ├── repositories/   # Interfaces abstractas (Ej. abstract class IFeedRepository)
        │   └── usecases/       # Clases atómicas para orquestar reglas (Ej. GetFeedUseCase)
        ├── data/             # (EL MÚSCULO) API Rest, HTTP, Supabase, JSON
        │   ├── datasources/    # Consultas remotas reales (SupabaseClient.from(x)...)
        │   └── repositories/   # Implementaciones físicas de los contratos del dominio abstracto
        └── presentation/     # (LA CARA) UI, Material y Riverpod
            ├── screens/        # Vistas de Flutter
            ├── widgets/        # Componentes específicos de la vista
            └── providers/      # Inyección de dependencias e interfaces reactivas Riverpod
```

## Reglas de Oro para Colaboradores
1. **El Estado jamás habla con Supabase:** Un Riverpod Provider no debe importar el SDK de bases de datos de forma directa en ningún escenario de producción. Solo deben depender de `UseCases`.
2. **Principio de Responsabilidad Única (SRP):** Los UseCases solo hacen UNA cosa. Si necesitas enviar un dibujo, crea un `SubmitDoodleUseCase`. Si hay reglas que filtrar palabras prohibidas, sucederán dentro de este UseCase antes de despacharse a red. 
3. **Flujo Acíclico:** `UI` ➔ Pide al `Provider` ➔ Ejecuta el `UseCase` ➔ Delega a la interfaz `Repository` ➔ Resuelto por `RepositoryImpl` ➔ Llama internamente a `DataSource`.
