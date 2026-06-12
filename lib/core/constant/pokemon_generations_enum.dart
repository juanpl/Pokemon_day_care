enum PokemonGenerationsEnum {
  firstGeneration,
  secondGeneration,
  thirdGeneration,
}

extension PokemonGenerationsEnumExtension on PokemonGenerationsEnum {
  String get value {
    switch (this) {
      case PokemonGenerationsEnum.firstGeneration:
        return 'generation-i';
      case PokemonGenerationsEnum.secondGeneration:
        return 'generation-ii';
      case PokemonGenerationsEnum.thirdGeneration:
        return 'generation-iii';
    }
  }
}
