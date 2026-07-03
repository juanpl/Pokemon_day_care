class PokemonModel {
  final String name;
  final int id;
  final List<String> types;
  final String sprite;

  PokemonModel({
    required this.name,
    required this.id,
    required this.types,
    required this.sprite,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      id: json['id'],
      types: (json['pokemon_v2_pokemons']['pokemon_v2_pokemontypes'] as List)
          .map((sprite) => json['pokemon_v2_type']['name'] as String)
          .toList(),
      sprite: json['pokemon_v2_pokemonsprites']['pokemon_v2_pokemonsprites'],
    );
  }
}
