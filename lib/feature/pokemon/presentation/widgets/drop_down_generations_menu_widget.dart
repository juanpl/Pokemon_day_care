import 'package:flutter/material.dart';
import 'package:pokemon_day_care/core/constant/pokemon_generations_enum.dart';

class DropDownGenerationsMenuWidget extends StatelessWidget {
  final PokemonGenerationsEnum selectedGeneration;
  final ValueChanged<PokemonGenerationsEnum> onGenerationChanged;

  const DropDownGenerationsMenuWidget({
    super.key,
    required this.selectedGeneration,
    required this.onGenerationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<PokemonGenerationsEnum>(
      value: selectedGeneration,
      items: PokemonGenerationsEnum.values.map((generation) {
        return DropdownMenuItem(
          value: generation,
          child: Text(generation.label),
        );
      }).toList(),
      onChanged: (generation) {
        if (generation != null) {
          onGenerationChanged(generation);
        }
      },
    );
  }
}
