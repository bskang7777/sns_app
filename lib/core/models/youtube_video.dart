class YouTubeVideo {
  final String id;
  final String title;
  final String url;
  final String notes;
  final DateTime dateAdded;
  final String category;

  YouTubeVideo({
    required this.id,
    required this.title,
    required this.url,
    required this.notes,
    required this.dateAdded,
    required this.category,
  });

  // YouTube URL에서 비디오 ID 추출
  String get videoId {
    final uri = Uri.parse(url);
    if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
      if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.first;
      } else {
        return uri.queryParameters['v'] ?? '';
      }
    }
    return '';
  }

  // 썸네일 URL 생성
  String get thumbnailUrl {
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }

  // YouTube 동영상 URL 생성
  String get youtubeUrl {
    return 'https://www.youtube.com/watch?v=$videoId';
  }

  factory YouTubeVideo.fromMap(Map<String, dynamic> map) {
    return YouTubeVideo(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      notes: map['notes'] ?? '',
      dateAdded:
          DateTime.parse(map['dateAdded'] ?? DateTime.now().toIso8601String()),
      category: map['category'] ?? 'AI',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'notes': notes,
      'dateAdded': dateAdded.toIso8601String(),
      'category': category,
    };
  }
}
