const String pokemonListQuery = r'''
  query samplePokeAPIquery($generation: String!) {
    gen3_species: pokemon_v2_pokemonspecies(
      where: {pokemon_v2_generation: {name: {_eq: $generation}}}
      order_by: {id: asc}
      limit: 40
    ) {
      name
      id
      pokemon_v2_pokemons {
        pokemon_v2_pokemontypes {
          pokemon_v2_type {
            name
          }
        }
        pokemon_v2_pokemonsprites {
          sprites
        }
      }
    }
  }
''';
