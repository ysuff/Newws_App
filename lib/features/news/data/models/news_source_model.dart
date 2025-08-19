import '../../domain/entities/source_entity.dart';

class SourceModel extends SourceEntity {
  const SourceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.url,
    required super.category,
    required super.language,
    required super.country,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] as String? ?? 'Unknown',
      name: json['name'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? 'No Description',
      url: json['url'] as String? ?? '',
      category: json['category'] as String? ?? '',
      language: json['language'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'category': category,
      'language': language,
      'country': country,
    };
  }
}
