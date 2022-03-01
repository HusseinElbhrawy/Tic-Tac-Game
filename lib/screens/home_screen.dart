import 'package:flutter/material.dart';
import 'package:tic_tac_game/game_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();

  bool isSwitched = false;
  void resetData() {
    activePlayer = 'X';
    gameOver = false;
    turn = 0;
    result = '';
    Player.playerX.clear();
    Player.playerO.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> firstBloc = [
      SwitchListTile.adaptive(
        value: isSwitched,
        title: Text(
          'Turn on/off two player',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
              ),
        ),
        onChanged: (bool newValue) {
          isSwitched = newValue;
          setState(() {});
        },
      ),
      Text(
        'It\'s $activePlayer turn'.toUpperCase(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Colors.white,
            ),
      ),
    ];
    List<Widget> lastBloc = [
      Text(
        result,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.white,
            ),
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            resetData();
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text('Repeat the game'),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).splashColor)),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  ...firstBloc,
                  _expanded(context),
                  ...lastBloc,
                ],
              )
            : Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...firstBloc,
                      ...lastBloc,
                    ],
                  )),
                  _expanded(context),
                ],
              ),
      ),
    );
  }

  Expanded _expanded(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        padding: const EdgeInsetsDirectional.all(16),
        children: List.generate(
          9,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: gameOver ? null : () => _onTap(index),
            child: Container(
              // margin: const EdgeInsetsDirectional.all(20),
              child: Center(
                child: Text(
                  Player.playerX.contains(index)
                      ? 'X'
                      : Player.playerO.contains(index)
                          ? 'O'
                          : '',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Player.playerX.contains(index)
                            ? Colors.blue
                            : Colors.pink,
                      ),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);

      updateState();
    }

    if (isSwitched == false && !gameOver && turn != 9) {
      await game.autoPlay(activePlayer);
      updateState();
    }
  }

  void updateState() {
    return setState(
      () {
        activePlayer = activePlayer == Player.x ? Player.o : Player.x;
        turn++;

        String winner = game.checkWinner();
        if (winner != '') {
          gameOver = true;
          result = '$winner is Winner';
        } else if (!gameOver && turn == 9) {
          result = 'It\'s Drawl';
        }
      },
    );
  }
}
