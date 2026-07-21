import 'package:pokemon_day_care/feature/pokemon/data/model/pokemon_model.dart';

class PokemonEntity {
  final String name;
  final int id;
  final List<String> types;
  final String sprite;
  final bool isOnHonorRoll;

  PokemonEntity({
    required this.name,
    required this.id,
    required this.types,
    required this.sprite,
    this.isOnHonorRoll = false,
  });

  factory PokemonEntity.fromModel(PokemonModel model) {
    return PokemonEntity(
      name: model.name,
      id: model.id,
      types: model.types,
      sprite: model.sprite,
      isOnHonorRoll: model.isOnHonorRoll,
    );
  }

  PokemonEntity copyWith({
    String? name,
    int? id,
    List<String>? types,
    String? sprite,
    bool? isOnHonorRoll,
  }) {
    return PokemonEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      types: types ?? this.types,
      sprite: sprite ?? this.sprite,
      isOnHonorRoll: isOnHonorRoll ?? this.isOnHonorRoll,
    );
  }
}
