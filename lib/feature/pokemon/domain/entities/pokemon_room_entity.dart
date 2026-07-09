import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';

class PokemonRoomEntity {
  final String roomName;
  final List<PokemonEntity> pokemons;
  final String description;

  PokemonRoomEntity({
    required this.roomName,
    required this.pokemons, 
    required this.description,
  });
}