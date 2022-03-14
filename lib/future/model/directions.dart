enum Direction { kazan, innopolis, zelenodolsk, chelni }

extension ParseToString on Direction {
  String cityToString() {
    switch (index) {
      case 0:
        return 'Казань';
      case 1:
        return 'Иннополис';
      case 2:
        return 'Зеленодольск';
      case 3:
        return 'Наб. Челны';
      default:
        return 'Unknown City';
    }
  }
}
