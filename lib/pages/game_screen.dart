// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  String palyer1;
  String palyer2;

  GameScreen({super.key, required this.palyer1, required this.palyer2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _gameOver = false;
    _winner = "";
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameOver) {
      return;
    }
    setState(() {
      _board[row][col] = _currentPlayer;
      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][col] == _currentPlayer &&
          _board[1][col] == _currentPlayer &&
          _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = "It's a tie";
      }

      if (_winner != "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                _winner == "X"
                    ? "${widget.palyer1} Won!"
                    : _winner == "O"
                        ? "${widget.palyer2} Won! Может быть, нужно перезагрузить?"
                        : "It's a tie",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: Text("Play again"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323D5B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            SizedBox(
              height: 120,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Turn',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    Text(
                      _currentPlayer == "X"
                          ? widget.palyer1 + " ($_currentPlayer)"
                          : widget.palyer2 + " ($_currentPlayer)",
                      style: TextStyle(
                          color: _currentPlayer == "X"
                              ? Colors.purpleAccent
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: 20)
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () => _makeMove(row, col),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            _board[row][col],
                            style: TextStyle(
                                fontSize: 120,
                                fontWeight: FontWeight.bold,
                                color: _board[row][col] == "X"
                                    ? Colors.red
                                    : Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
