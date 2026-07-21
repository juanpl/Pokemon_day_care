import 'package:pokemon_day_care/core/error/custom_exception.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_room_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/detect_pokemons_on_honor_roll_use_case.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/get_honor_roll_pokemons_use_case.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/get_pokemon_list_use_case.dart';

class CreatePokemonRoomsUseCase {
  final GetPokemonListUseCase _getPokemonListUseCase;
  final GetHonorRollPokemonsUseCase _getHonorRollPokemonsUseCase;
  final DetectPokemonsOnHonorRollUseCase _detectPokemonsOnHonorRollUseCase;

  CreatePokemonRoomsUseCase(
    this._getPokemonListUseCase,
    this._getHonorRollPokemonsUseCase,
    this._detectPokemonsOnHonorRollUseCase,
  );

  Future<List<PokemonRoomEntity>> call({required String generation}) async {
    try {
      List<PokemonEntity> pokemonRemoteList = await _getPokemonListUseCase.call(
        generation: generation,
      );
      List<PokemonEntity> honorRollPokemons = await _getHonorRollPokemonsUseCase
          .call();
      List<PokemonEntity> pokemonList = _detectPokemonsOnHonorRollUseCase.call(
        pokemonRemoteList,
        honorRollPokemons,
      );

      List<PokemonEntity> firePokemons = pokemonList
          .where((pokemon) => pokemon.types[0] == 'fire')
          .toList();
      List<PokemonEntity> waterPokemons = pokemonList
          .where((pokemon) => pokemon.types[0] == 'water')
          .toList();
      List<PokemonEntity> grassPokemons = pokemonList
          .where((pokemon) => pokemon.types[0] == 'grass')
          .toList();
      List<PokemonEntity> othersPokemons = pokemonList
          .where(
            (pokemon) =>
                !firePokemons.contains(pokemon) &&
                !waterPokemons.contains(pokemon) &&
                !grassPokemons.contains(pokemon),
          )
          .toList();

      List<PokemonRoomEntity> pokemonRooms = [];
      final aRoom = PokemonRoomEntity(
        roomName: 'A room',
        pokemons: firePokemons,
        description: 'Fire pokemons room',
      );
      final bRoom = PokemonRoomEntity(
        roomName: 'B room',
        pokemons: waterPokemons,
        description: 'Water pokemons room',
      );
      final cRoom = PokemonRoomEntity(
        roomName: 'C room',
        pokemons: grassPokemons,
        description: 'Grass pokemons room',
      );
      final dRoom = PokemonRoomEntity(
        roomName: 'D room',
        pokemons: othersPokemons,
        description: 'Others pokemons room',
      );
      final honorRollPokemonsRoom = PokemonRoomEntity(
        roomName: 'Honor Roll',
        pokemons: honorRollPokemons,
        description: 'Honor Roll room',
      );

      pokemonRooms.add(aRoom);
      pokemonRooms.add(bRoom);
      pokemonRooms.add(cRoom);
      pokemonRooms.add(dRoom);
      pokemonRooms.add(honorRollPokemonsRoom);
      return pokemonRooms;
    } catch (e, s) {
      throw CustomException(
        error: e,
        errorCode: '01-3UC',
        stackTrace: s,
        errorMessage: 'Tuvimos problemas creando los salones',
      );
    }
  }
}
