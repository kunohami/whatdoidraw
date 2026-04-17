import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/features/auth/auth_provider.dart';
import 'package:whatdoidraw/features/content_creation/services/content_creation_service.dart';
import 'package:whatdoidraw/features/content_creation/viewmodels/doodle_canvas_viewmodel.dart';

// Mocks necesarios para aislar el ViewModel
class MockContentCreationService extends Mock implements ContentCreationService {}
class MockUser extends Mock implements User {}

// Mock para el controlador de autenticación que hereda del tipo base de Riverpod
// pero implementa la interfaz de nuestro controlador generado.
class MockAuthController extends AsyncNotifier<User?> with Mock implements AuthController {
  final User? _user;
  MockAuthController(this._user);

  @override
  FutureOr<User?> build() => _user;
}

void main() {
  late MockContentCreationService mockService;
  late MockUser mockUser;
  late ProviderContainer container;

  setUp(() {
    mockService = MockContentCreationService();
    mockUser = MockUser();
    
    // Configuramos el contenedor de Riverpod
    container = ProviderContainer(
      overrides: [
        contentCreationServiceProvider.overrideWithValue(mockService),
        // Override con nuestra implementación controlada del mock
        authControllerProvider.overrideWith(() => MockAuthController(mockUser)),
      ],
    );

    // Registramos fallback para mocktail
    registerFallbackValue([]);
  });

  tearDown(() {
    container.dispose();
  });

  group('DoodleCanvas ViewModel Tests', () {
    test('Estado inicial debe ser vacío', () {
      final state = container.read(doodleCanvasProvider);
      
      expect(state.strokes, isEmpty);
      expect(state.isSubmitting, isFalse);
      expect(state.errorMessage, isNull);
    });

    test('startStroke debe añadir un nuevo trazo al estado', () {
      final notifier = container.read(doodleCanvasProvider.notifier);
      
      notifier.startStroke(100, 200);
      
      final state = container.read(doodleCanvasProvider);
      expect(state.strokes.length, 1);
      expect(state.strokes.first.points.length, 1);
      expect(state.strokes.first.points.first.x, 100);
      expect(state.strokes.first.points.first.y, 200);
    });

    test('clear debe vaciar todos los trazos', () {
      final notifier = container.read(doodleCanvasProvider.notifier);
      
      notifier.startStroke(0, 0);
      expect(container.read(doodleCanvasProvider).strokes, isNotEmpty);
      
      notifier.clear();
      expect(container.read(doodleCanvasProvider).strokes, isEmpty);
    });

    test('undo debe eliminar el último trazo', () {
      final notifier = container.read(doodleCanvasProvider.notifier);
      
      notifier.startStroke(1, 1);
      notifier.startStroke(2, 2);
      expect(container.read(doodleCanvasProvider).strokes.length, 2);
      
      notifier.undo();
      expect(container.read(doodleCanvasProvider).strokes.length, 1);
    });

    test('submitDoodle debe actualizar isSubmitting y llamar al servicio', () async {
      final notifier = container.read(doodleCanvasProvider.notifier);
      
      // Preparamos datos iniciales y el mock del usuario
      notifier.startStroke(0, 0);
      when(() => mockUser.id).thenReturn('test-user-id');
      when(() => mockService.insertDoodle(any(), any(), any()))
          .thenAnswer((_) async => {});

      // Ejecutamos la acción
      final future = notifier.submitDoodle(null);
      
      // Verificamos estado intermedio: Cargando
      expect(container.read(doodleCanvasProvider).isSubmitting, isTrue);
      
      await future;

      // Verificamos estado final: Éxito (limpio y no cargando)
      expect(container.read(doodleCanvasProvider).strokes, isEmpty);
      expect(container.read(doodleCanvasProvider).isSubmitting, isFalse);
      
      // Verificamos que se llamó al servicio con los parámetros correctos
      verify(() => mockService.insertDoodle(any(), 'test-user-id', null)).called(1);
    });

    test('submitDoodle debe capturar errores y guardarlos en el estado', () async {
      final notifier = container.read(doodleCanvasProvider.notifier);
      
      notifier.startStroke(0, 0);
      when(() => mockUser.id).thenReturn('test-user-id');
      when(() => mockService.insertDoodle(any(), any(), any()))
          .thenThrow(Exception('Error de red simulado'));

      await notifier.submitDoodle(null);

      final state = container.read(doodleCanvasProvider);
      expect(state.isSubmitting, isFalse);
      expect(state.errorMessage, contains('Error de red simulado'));
      // El lienzo NO se limpia si falla el envío
      expect(state.strokes, isNotEmpty);
    });
  });
}
