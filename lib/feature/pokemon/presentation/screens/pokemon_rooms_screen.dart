import 'package:flutter/material.dart';

class PokemonRoomsScreen extends StatelessWidget {
  const PokemonRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Center(
          child: Container(
            child: Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/132.svg'),
          )
        ),
      );
  }
}