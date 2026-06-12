import 'package:pokemon_day_care/feature/pokemon/data/model/pokemon_model.dart';

class PokemonEntity {
  final String name;
  final int id;
  final List<String> types;
  final String sprite;

  PokemonEntity({
    required this.name,
    required this.id,
    required this.types,
    required this.sprite,
  });

  factory PokemonEntity.fromModel(PokemonModel model) {
    return PokemonEntity(
      name: model.name,
      id: model.id,
      types: model.types,
      sprite: model.sprite,
    );
  }
}
