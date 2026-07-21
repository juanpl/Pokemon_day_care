import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_day_care/core/constant/pokemon_generations_enum.dart';

final selectedPokemonGenerationProvider =
    NotifierProvider<SelectPokemonGenerationController, PokemonGenerationsEnum>(
      SelectPokemonGenerationController.new,
    );

class SelectPokemonGenerationController
    extends Notifier<PokemonGenerationsEnum> {
  @override
  PokemonGenerationsEnum build() => PokemonGenerationsEnum.firstGeneration;

  void selectGeneration(PokemonGenerationsEnum generation) {
    state = generation;
  }
}
