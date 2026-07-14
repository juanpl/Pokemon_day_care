enum ListRoutes { home, room, honorRoll}

extension RouteExtension on ListRoutes {
  String get path {
    switch (this) {
      case ListRoutes.home:
        return '/';
      case ListRoutes.room:
        return '/room/:id';
      case ListRoutes.honorRoll:
        return '/honorRoll';
    }
  }
}