class Player {
  int xp;
  int level;
  int coins;

  Player({this.xp = 0, this.level = 1, this.coins = 0});

  void addXp(int amount) {
    xp += amount;
    if (xp >= level * 100) {
      // Level up every 100 XP
      xp -= level * 100;
      level++;
    }
  }

  void addCoins(int amount) {
    coins += amount;
  }
}
