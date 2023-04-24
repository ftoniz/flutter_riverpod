import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {

  @JsonKey(name: 'API')
  final String? title;

  @JsonKey(name: 'Description')
  final String? description;

  @JsonKey(name: 'Auth')
  final String? auth;

  @JsonKey(name: 'HTTPS')
  final bool? https;

  @JsonKey(name: 'Cors')
  final String? cors;

  @JsonKey(name: 'Category')
  final String? category;

  @JsonKey(name: 'Link')
  final String? link;

  CategoryEntity({
    this.title,
    this.description,
    this.auth,
    this.https,
    this.cors,
    this.category,
    this.link,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);
}
