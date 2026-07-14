import 'package:go_router/go_router.dart';
import 'package:pokemon_day_care/core/router/list_routes.dart';
import 'package:pokemon_day_care/feature/pokemon/presentation/screens/pokemon_rooms_screen.dart';

final appRouter = GoRouter(
  initialLocation: ListRoutes.home.path,
  routes: [
    GoRoute(
      path: ListRoutes.home.path,
      name: ListRoutes.home.name,
      builder: (context, state) => const PokemonRoomsScreen(),    
    )
  ],
);