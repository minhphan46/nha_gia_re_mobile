enum Direction {
  east,
  west,
  south,
  north,
  northEast,
  northWest,
  southEast,
  southWest;

  static Direction parse(String value) {
    for (Direction direction in Direction.values) {
      if (direction.toString() == value) return direction;
    }
    throw Exception("Can't parse Direction! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case Direction.east:
        return "east";
      case Direction.west:
        return "west";
      case Direction.south:
        return "south";
      case Direction.north:
        return "north";
      case Direction.northEast:
        return "north_east";
      case Direction.northWest:
        return "north_west";
      case Direction.southEast:
        return "south_east";
      case Direction.southWest:
        return "south_west";
    }
  }
}
