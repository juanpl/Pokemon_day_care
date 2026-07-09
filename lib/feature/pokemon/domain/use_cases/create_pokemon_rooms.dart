import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_room_entity.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/get_pokemon_list_use_case.dart';

class CreatePokemonRooms {
  final GetPokemonListUseCase _getPokemonListUseCase;

  CreatePokemonRooms(this._getPokemonListUseCase);

  Future<List<PokemonRoomEntity>> call({required String generation}) async{
    List<PokemonEntity> pokemonList = await _getPokemonListUseCase.call(generation: generation);
    List<PokemonEntity> firePokemons = pokemonList.where((pokemon)=>pokemon.types[0] == 'fire').toList();
    List<PokemonEntity> waterPokemons = pokemonList.where((pokemon)=>pokemon.types[0] == 'water').toList();
    List<PokemonEntity> grassPokemons = pokemonList.where((pokemon)=>pokemon.types[0] == 'grass').toList();
    List<PokemonEntity> othersPokemons = pokemonList.where((pokemon)=> !firePokemons.contains(pokemon)&&!waterPokemons.contains(pokemon)&&!grassPokemons.contains(pokemon)).toList();

    List<PokemonRoomEntity> pokemonRooms =[];
    final aRoom = PokemonRoomEntity(roomName: 'A room', pokemons: firePokemons, description: 'fire pokemons room');
    final bRoom = PokemonRoomEntity(roomName: 'B room', pokemons: waterPokemons, description: 'water pokemons room');
    final cRoom = PokemonRoomEntity(roomName: 'C room', pokemons: grassPokemons, description: 'grass pokemons room');
    final dRoom = PokemonRoomEntity(roomName: 'D room', pokemons: othersPokemons, description: 'others pokemons room');

    pokemonRooms.add(aRoom);
    pokemonRooms.add(bRoom);
    pokemonRooms.add(cRoom);
    pokemonRooms.add(dRoom);
    return pokemonRooms;
  }

}