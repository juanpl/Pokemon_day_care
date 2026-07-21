import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_local_datasource.dart';
import 'package:pokemon_day_care/feature/pokemon/data/datasource/pokemon_remote_datasource.dart';
import 'package:pokemon_day_care/feature/pokemon/data/repository_impl/pokemon_repository_imp.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/repository/pokemon_repository.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/create_pokemon_rooms_use_case.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/delete_pokemon_in_honor_roll_use_case.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/detect_pokemons_on_honor_roll_use_case.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/get_honor_roll_pokemons_use_case.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/get_pokemon_list_use_case.dart';
import 'package:pokemon_day_care/feature/pokemon/domain/use_cases/save_pokemon_in_honor_roll_use_case.dart';
import 'package:pokemon_day_care/provider.dart';

final pokemonRemoteDatasourceProvider = Provider<PokemonRemoteDatasource>((
  ref,
) {
  return PokemonRemoteDatasource(ref.watch(graphqlClientProvider));
});

final pokemonLocalDatasourceProvider = Provider((ref) {
  return PokemonLocalDatasource(ref.watch(sembastClientProvider));
});

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImp(
    ref.watch(pokemonRemoteDatasourceProvider),
    ref.watch(pokemonLocalDatasourceProvider),
  );
});

final getPokemonListUseCaseProvider = Provider<GetPokemonListUseCase>((ref) {
  return GetPokemonListUseCase(ref.watch(pokemonRepositoryProvider));
});

final deletePokemonInHonorRollUseCaseProvider = Provider((ref) {
  return DeletePokemonInHonorRollUseCase(ref.watch(pokemonRepositoryProvider));
});

final getHonorRollPokemonsUseCaseProvider = Provider((ref) {
  return GetHonorRollPokemonsUseCase(ref.watch(pokemonRepositoryProvider));
});

final savePokemonInHonorRollUseCaseProvider = Provider((ref) {
  return SavePokemonInHonorRollUseCase(ref.watch(pokemonRepositoryProvider));
});

final detectPokemonsOnHonorRollUseCaseProvider = Provider((ref){
  return DetectPokemonsOnHonorRollUseCase();
});

final createPokemonRoomsProvider = Provider<CreatePokemonRoomsUseCase>((ref) {
  return CreatePokemonRoomsUseCase(
    ref.watch(getPokemonListUseCaseProvider),
    ref.watch(getHonorRollPokemonsUseCaseProvider),
    ref.watch(detectPokemonsOnHonorRollUseCaseProvider)
  );
});
