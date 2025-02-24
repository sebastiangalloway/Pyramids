class Entity {
  String name;
  String description;
  int health; // Number of actions to defeat
  List<String> actions; // Mindfulness exercises or interactions
  bool isDefeated;

  Entity({
    required this.name,
    required this.description,
    required this.health,
    required this.actions,
    this.isDefeated = false,
  });

  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      health = 0;
      isDefeated = true;
    }
  }
}
