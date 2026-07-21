import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';

class PokemonModel {
  final String name;
  final int id;
  final List<String> types;
  final String sprite;
  final bool isOnHonorRoll;

  PokemonModel({
    required this.name,
    required this.id,
    required this.types,
    required this.sprite,
    required this.isOnHonorRoll,
  });

  factory PokemonModel.fromRemoteDataSourceJson(Map<String, dynamic> json) {
    final pokemon =
        (json['pokemon_v2_pokemons'] as List).first as Map<String, dynamic>;

    final types = (pokemon['pokemon_v2_pokemontypes'] as List)
        .map(
          (type) =>
              (type as Map<String, dynamic>)['pokemon_v2_type']['name']
                  as String,
        )
        .toList();

    final sprites =
        ((pokemon['pokemon_v2_pokemonsprites'] as List).first
                as Map<String, dynamic>)['sprites']
            as Map<String, dynamic>;
    final sprite =
        sprites['other']['official-artwork']['front_default'] as String;

    final isOnHonorRoll = false;

    return PokemonModel(
      name: json['name'],
      id: json['id'],
      types: types,
      sprite: sprite,
      isOnHonorRoll: isOnHonorRoll,
    );
  }

  factory PokemonModel.fromLocalDataSourceJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      id: json['id'],
      types: (json['types'] as List).cast<String>(),
      sprite: json['sprite'],
      isOnHonorRoll: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'types': types,
      'sprite': sprite,
      'isOnHonorRoll': isOnHonorRoll,
    };
  }

  factory PokemonModel.fromEntity(PokemonEntity pokemon) {
    return PokemonModel(
      name: pokemon.name,
      id: pokemon.id,
      types: pokemon.types,
      sprite: pokemon.sprite,
      isOnHonorRoll: pokemon.isOnHonorRoll,
    );
  }
}
