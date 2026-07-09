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
    final pokemon =
        (json['pokemon_v2_pokemons'] as List).first as Map<String, dynamic>;

    final types =
        (pokemon['pokemon_v2_pokemontypes'] as List)
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

    return PokemonModel(
      name: json['name'],
      id: json['id'],
      types: types,
      sprite: sprite,
    );
  }
}
