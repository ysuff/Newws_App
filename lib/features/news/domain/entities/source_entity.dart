import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  const SourceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    url,
    category,
    language,
    country,
  ];
}
