import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatdoidraw/features/profile/services/profile_service.dart';
import 'package:whatdoidraw/shared/models/artwork_model.dart';
import 'package:whatdoidraw/shared/models/doodle_model.dart';
import 'package:whatdoidraw/shared/models/idea_model.dart';
import 'package:whatdoidraw/shared/models/user_model.dart';

// Mocks
class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

// A robust Fake that implements all filter and transform builders of Postgrest.
// It bypasses the mocktail Future/then hijacking by implementing Future cleanly.
class FakePostgrestBuilder<T> extends Fake
    implements PostgrestFilterBuilder<T> {
  final T result;
  FakePostgrestBuilder(this.result);

  @override
  PostgrestFilterBuilder<T> eq(String column, Object? value) => this;

  @override
  PostgrestFilterBuilder<T> ilike(String column, String value) => this;

  @override
  PostgrestFilterBuilder<T> order(
    String column, {
    bool ascending = true,
    bool nullsFirst = false,
    String? referencedTable,
  }) => this;

  @override
  PostgrestTransformBuilder<PostgrestMap> single() {
    if (result is List && (result as List).isNotEmpty) {
      return FakePostgrestBuilder<PostgrestMap>((result as List).first as PostgrestMap);
    }
    return FakePostgrestBuilder<PostgrestMap>(result as PostgrestMap);
  }

  @override
  PostgrestTransformBuilder<PostgrestList> select([String columns = '*']) {
    return FakePostgrestBuilder<PostgrestList>(result as PostgrestList);
  }

  @override
  Future<U> then<U>(FutureOr<U> Function(T) onValue, {Function? onError}) {
    return Future.value(result).then(onValue, onError: onError);
  }
}

void main() {
  late MockSupabaseClient mockSupabase;
  late MockSupabaseQueryBuilder mockQueryBuilder;
  late ProfileService profileService;

  const testUserId = 'test-user-id';

  setUp(() {
    mockSupabase = MockSupabaseClient();
    mockQueryBuilder = MockSupabaseQueryBuilder();
    profileService = ProfileService(mockSupabase);
  });

  group('ProfileService Tests', () {
    test('getUserProfile successfully returns UserModel', () async {
      final mockUserData = {
        'id': testUserId,
        'username': 'artist_test',
        'avatar_url': 'https://example.com/avatar.png',
        'is_artist': true,
        'portfolio_url': 'https://example.com',
        'short_message': 'Hello drawing world!',
        'created_at': '2026-05-21T12:00:00Z',
      };

      final fakeBuilder = FakePostgrestBuilder<PostgrestList>([mockUserData]);

      when(() => mockSupabase.from('users')).thenAnswer((_) => mockQueryBuilder);
      when(() => mockQueryBuilder.select()).thenAnswer((_) => fakeBuilder);

      final UserModel result = await profileService.getUserProfile(testUserId);

      expect(result.id, equals(testUserId));
      expect(result.username, equals('artist_test'));
      expect(result.isArtist, isTrue);
      expect(result.shortMessage, equals('Hello drawing world!'));
      
      verify(() => mockSupabase.from('users')).called(1);
      verify(() => mockQueryBuilder.select()).called(1);
    });

    test('getUserIdeas successfully returns List<IdeaModel>', () async {
      final mockIdeasData = [
        {
          'id': 'idea-1',
          'user_id': testUserId,
          'content': 'A cute space cat playing guitar',
          'tags': ['space', 'cat', 'guitar'],
          'is_active': true,
          'language': 'en',
          'created_at': '2026-05-21T10:00:00Z',
          'likes_count': 10,
          'authorName': 'artist_test',
        }
      ];

      final fakeBuilder = FakePostgrestBuilder<PostgrestList>(mockIdeasData);

      when(() => mockSupabase.from('ideas')).thenAnswer((_) => mockQueryBuilder);
      when(() => mockQueryBuilder.select()).thenAnswer((_) => fakeBuilder);

      final result = await profileService.getUserIdeas(testUserId);

      expect(result, isA<List<IdeaModel>>());
      expect(result.length, 1);
      expect(result.first.id, equals('idea-1'));
      expect(result.first.content, equals('A cute space cat playing guitar'));

      verify(() => mockSupabase.from('ideas')).called(1);
      verify(() => mockQueryBuilder.select()).called(1);
    });

    test('getUserDoodles successfully returns List<DoodleModel>', () async {
      final mockDoodlesData = [
        {
          'id': 'doodle-1',
          'user_id': testUserId,
          'idea_id': 'idea-1',
          'doodle_data': [],
          'tags': ['space'],
          'is_active': true,
          'created_at': '2026-05-21T11:00:00Z',
          'likes_count': 5,
          'authorName': 'artist_test',
        }
      ];

      final fakeBuilder = FakePostgrestBuilder<PostgrestList>(mockDoodlesData);

      when(() => mockSupabase.from('doodles')).thenAnswer((_) => mockQueryBuilder);
      when(() => mockQueryBuilder.select()).thenAnswer((_) => fakeBuilder);

      final result = await profileService.getUserDoodles(testUserId);

      expect(result, isA<List<DoodleModel>>());
      expect(result.length, 1);
      expect(result.first.id, equals('doodle-1'));

      verify(() => mockSupabase.from('doodles')).called(1);
      verify(() => mockQueryBuilder.select()).called(1);
    });

    test('getUserArtworks successfully returns List<ArtworkModel>', () async {
      final mockArtworksData = [
        {
          'id': 'artwork-1',
          'user_id': testUserId,
          'authorName': 'artist_test',
          'idea_id': 'idea-1',
          'doodle_id': 'doodle-1',
          'preview_url': 'https://example.com/artwork.jpg',
          'external_link': 'https://instagram.com/p/123',
          'tags': ['cat'],
          'is_active': true,
          'created_at': '2026-05-21T13:00:00Z',
          'likes_count': 15,
        }
      ];

      final fakeBuilder = FakePostgrestBuilder<PostgrestList>(mockArtworksData);

      when(() => mockSupabase.from('artworks')).thenAnswer((_) => mockQueryBuilder);
      when(() => mockQueryBuilder.select()).thenAnswer((_) => fakeBuilder);

      final result = await profileService.getUserArtworks(testUserId);

      expect(result, isA<List<ArtworkModel>>());
      expect(result.length, 1);
      expect(result.first.id, equals('artwork-1'));
      expect(result.first.externalLink, equals('https://instagram.com/p/123'));

      verify(() => mockSupabase.from('artworks')).called(1);
      verify(() => mockQueryBuilder.select()).called(1);
    });

    test('updateShortMessage successfully updates and returns updated UserModel', () async {
      const newBioMessage = 'New drawing bio!';
      final mockUpdatedUserData = {
        'id': testUserId,
        'username': 'artist_test',
        'avatar_url': 'https://example.com/avatar.png',
        'is_artist': true,
        'portfolio_url': 'https://example.com',
        'short_message': newBioMessage,
        'created_at': '2026-05-21T12:00:00Z',
      };

      final fakeBuilder = FakePostgrestBuilder<PostgrestList>([mockUpdatedUserData]);

      when(() => mockSupabase.from('users')).thenAnswer((_) => mockQueryBuilder);
      when(() => mockQueryBuilder.update({'short_message': newBioMessage})).thenAnswer((_) => fakeBuilder);

      final UserModel result = await profileService.updateShortMessage(testUserId, newBioMessage);

      expect(result.id, equals(testUserId));
      expect(result.shortMessage, equals(newBioMessage));

      verify(() => mockSupabase.from('users')).called(1);
      verify(() => mockQueryBuilder.update({'short_message': newBioMessage})).called(1);
    });

    test('getUserByUsername successfully returns UserModel when user exists', () async {
      final mockUserData = {
        'id': testUserId,
        'username': 'Artist_Test',
        'avatar_url': 'https://example.com/avatar.png',
        'is_artist': true,
        'portfolio_url': 'https://example.com',
        'short_message': 'Hey!',
        'created_at': '2026-05-21T12:00:00Z',
      };

      final fakeBuilder = FakePostgrestBuilder<PostgrestList>([mockUserData]);

      when(() => mockSupabase.from('users')).thenAnswer((_) => mockQueryBuilder);
      when(() => mockQueryBuilder.select()).thenAnswer((_) => fakeBuilder);

      final result = await profileService.getUserByUsername('artist_test');

      expect(result, isNotNull);
      expect(result!.id, equals(testUserId));
      expect(result.username, equals('Artist_Test'));

      verify(() => mockSupabase.from('users')).called(1);
      verify(() => mockQueryBuilder.select()).called(1);
    });

    test('getUserByUsername returns null when user does not exist', () async {
      final fakeBuilder = FakePostgrestBuilder<PostgrestList>([]);

      when(() => mockSupabase.from('users')).thenAnswer((_) => mockQueryBuilder);
      when(() => mockQueryBuilder.select()).thenAnswer((_) => fakeBuilder);

      final result = await profileService.getUserByUsername('nonexistent_user');

      expect(result, isNull);

      verify(() => mockSupabase.from('users')).called(1);
      verify(() => mockQueryBuilder.select()).called(1);
    });
  });
}
