import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deviantart_service.g.dart';

/// Modelo de datos para la previsualización de DeviantArt.
class DeviantArtPreview {
  final String title;
  final String authorName;
  final String thumbnailUrl;
  final String url;

  DeviantArtPreview({
    required this.title,
    required this.authorName,
    required this.thumbnailUrl,
    required this.url,
  });

  factory DeviantArtPreview.fromJson(Map<String, dynamic> json) {
    return DeviantArtPreview(
      title: json['title'] ?? 'Artwork',
      authorName: json['author_name'] ?? 'Unknown Artist',
      thumbnailUrl: json['thumbnail_url'] ?? json['url'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

/// Servicio encargado de validar y obtener datos de DeviantArt.
class DeviantArtService {
  static const String oEmbedBaseUrl = 'https://backend.deviantart.com/oembed';

  /// Valida si una URL es de DeviantArt (formato básico).
  bool isValidDeviantArtUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    
    final host = uri.host.toLowerCase();
    return host.contains('deviantart.com');
  }

  /// Obtiene los metadatos y la imagen de previsualización desde la URL.
  Future<DeviantArtPreview?> getPreview(String url) async {
    if (!isValidDeviantArtUrl(url)) {
      throw ArgumentError('La URL no es de DeviantArt.');
    }

    try {
      final requestUrl = Uri.parse('$oEmbedBaseUrl?url=${Uri.encodeComponent(url)}');
      
      final response = await http.get(
        requestUrl,
        headers: {
          'User-Agent': 'whatdoidraw-app/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DeviantArtPreview.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      // Ignorar errores de red y retornar null.
      return null;
    }
  }
}

@riverpod
DeviantArtService deviantArtService(Ref ref) {
  return DeviantArtService();
}
