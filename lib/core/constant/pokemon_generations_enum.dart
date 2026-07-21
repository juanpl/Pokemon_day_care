enum PokemonGenerationsEnum {
  firstGeneration,
  secondGeneration,
  thirdGeneration,
  honorRoll,
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
      case PokemonGenerationsEnum.honorRoll:
        return 'honor-roll';
    }
  }

  String get label {
    switch (this) {
      case PokemonGenerationsEnum.firstGeneration:
        return 'Primera generación';
      case PokemonGenerationsEnum.secondGeneration:
        return 'Segunda generación';
      case PokemonGenerationsEnum.thirdGeneration:
        return 'Tercera generación';
      case PokemonGenerationsEnum.honorRoll:
        return 'Cuadro de honor';
    }
  }
}
