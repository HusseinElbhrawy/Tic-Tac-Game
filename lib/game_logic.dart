import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainAll on List {
  bool containAll(int x, int y, [int? z]) {
    if (z == null) contains(x) && contains(y);

    return contains(x) && contains(y) && contains(z);
  }
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == Player.x) {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWinner() {
    String winner = '';

    if (Player.playerX.containAll(0, 1, 2) ||
        Player.playerX.containAll(3, 4, 5) ||
        Player.playerX.containAll(6, 7, 8) ||
        Player.playerX.containAll(0, 3, 6) ||
        Player.playerX.containAll(1, 4, 7) ||
        Player.playerX.containAll(2, 5, 8) ||
        Player.playerX.containAll(0, 4, 8) ||
        Player.playerX.containAll(2, 4, 6)) {
      winner = 'X';
    } else if (Player.playerO.containAll(0, 1, 2) ||
        Player.playerO.containAll(3, 4, 5) ||
        Player.playerO.containAll(6, 7, 8) ||
        Player.playerO.containAll(0, 3, 6) ||
        Player.playerO.containAll(1, 4, 7) ||
        Player.playerO.containAll(2, 5, 8) ||
        Player.playerO.containAll(0, 4, 8) ||
        Player.playerO.containAll(2, 4, 6)) {
      winner = 'O';
    } else {
      winner = '';
    }

    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;

    List<int> emptyCells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }
    //Start - Center
    if (Player.playerX.containAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerX.containAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerX.containAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerX.containAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerX.containAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerX.containAll(2, 5) && emptyCells.contains(8)) {
      index = 6;
    } else if (Player.playerX.containAll(0, 4) && emptyCells.contains(8)) {
      index = 6;
    } else if (Player.playerX.containAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    }
    //Start - end
    /// The other condition
    else {
      int randomIndex = Random.secure().nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
    }

    playGame(index, activePlayer);
  }
}
