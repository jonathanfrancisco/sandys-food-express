import 'package:json_annotation/json_annotation.dart';

part 'Food.g.dart';

@JsonSerializable()
class Food {
  final int id;
  final String name;
  final String picture;
  final String price;

  @JsonKey(name: 'owner_id')
  final int ownerId;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Food({
    required this.id,
    required this.name,
    required this.picture,
    required this.price,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
