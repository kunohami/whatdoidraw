import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artwork_link_service.g.dart';

/// Modelo de datos genérico para la previsualización de obras externas.
class ArtworkPreview {
  final String title;
  final String authorName;
  final String thumbnailUrl;
  final String url;
  final String providerName;

  ArtworkPreview({
    required this.title,
    required this.authorName,
    required this.thumbnailUrl,
    required this.url,
    required this.providerName,
  });

  factory ArtworkPreview.fromDeviantArt(
    Map<String, dynamic> json,
    String originalUrl,
  ) {
    return ArtworkPreview(
      title: json['title'] ?? 'Artwork',
      authorName: json['author_name'] ?? 'Unknown Artist',
      thumbnailUrl: json['thumbnail_url'] ?? json['url'] ?? '',
      url: originalUrl,
      providerName: 'DeviantArt',
    );
  }

  factory ArtworkPreview.fromBluesky(
    Map<String, dynamic> json,
    String originalUrl,
  ) {
    return ArtworkPreview(
      title: json['title'] ?? 'Bluesky Post',
      authorName: json['author_name'] ?? 'Bluesky User',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      url: originalUrl,
      providerName: 'Bluesky',
    );
  }

  factory ArtworkPreview.fromGenericSocial(String url, String provider) {
    return ArtworkPreview(
      title: 'Artwork en $provider',
      authorName: 'Enlace externo',
      thumbnailUrl: '', // Sin miniatura
      url: url,
      providerName: provider,
    );
  }
}

@riverpod
class ArtworkLinkService extends _$ArtworkLinkService {
  @override
  void build() {}

  static const String deviantArtOEmbed =
      'https://backend.deviantart.com/oembed';
  static const String blueskyOEmbed = 'https://embed.bsky.app/oembed';

  static const Map<String, String> _supportedSocialDomains = {
    'instagram.com': 'Instagram',
    'twitter.com': 'Twitter/X',
    'x.com': 'Twitter/X',
    'artstation.com': 'ArtStation',
    'behance.net': 'Behance',
    'cara.app': 'Cara',
    'pixiv.net': 'Pixiv',
  };

  bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    final host = uri.host.toLowerCase();

    final isNativelySupported =
        host.contains('deviantart.com') || host.contains('bsky.app');
    final isGenericSocial = _supportedSocialDomains.keys.any(
      (domain) => host.endsWith(domain) || host.contains('.$domain'),
    );

    return isNativelySupported || isGenericSocial;
  }

  Future<ArtworkPreview?> getPreview(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final host = uri.host.toLowerCase();

    if (host.contains('deviantart.com')) {
      return _fetchOEmbed(
        deviantArtOEmbed,
        url,
        (json) => ArtworkPreview.fromDeviantArt(json, url),
      );
    } else if (host.contains('bsky.app')) {
      return _fetchOEmbed(
        blueskyOEmbed,
        url,
        (json) => ArtworkPreview.fromBluesky(json, url),
      );
    }

    // Comprobar redes genéricas
    for (final entry in _supportedSocialDomains.entries) {
      if (host.endsWith(entry.key) || host.contains('.${entry.key}')) {
        return ArtworkPreview.fromGenericSocial(url, entry.value);
      }
    }

    return null;
  }

  Future<ArtworkPreview?> _fetchOEmbed(
    String baseUrl,
    String targetUrl,
    ArtworkPreview Function(Map<String, dynamic>) factory,
  ) async {
    try {
      final requestUrl = Uri.parse(
        '$baseUrl?url=${Uri.encodeComponent(targetUrl)}',
      );
      final response = await http.get(
        requestUrl,
        headers: {'User-Agent': 'whatdoidraw-app/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return factory(data);
      }
    } catch (e) {
      // Log error if needed
    }
    return null;
  }
}
