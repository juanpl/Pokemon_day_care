import 'package:pokemon_day_care/feature/pokemon/domain/entities/pokemon_entity.dart';

class DetectPokemonsOnHonorRollUseCase {

  List<PokemonEntity> call(
    List<PokemonEntity> remotePokemonList,
    List<PokemonEntity> dbPokemonList,
  ) {
    for (var i = 0; i < remotePokemonList.length; i++) {
      for (var j = 0; j < dbPokemonList.length; j++) {
        if (remotePokemonList[i].id == dbPokemonList[j].id) {
          remotePokemonList[i] = remotePokemonList[i].copyWith(
            isOnHonorRoll: true,
          );
        }
      }
    }

    return remotePokemonList;
  }
}
