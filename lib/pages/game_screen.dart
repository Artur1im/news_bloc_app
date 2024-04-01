import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;

  GameScreen({Key? key, required this.player1, required this.player2})
      : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "x";
    _winner = "";
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
      _currentPlayer = "x";
      _winner = "";
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _winner.isNotEmpty) return;
    setState(() {
      _board[row][col] = _currentPlayer;
      if (_checkWinner(row, col)) _winner = _currentPlayer;
      _currentPlayer = _currentPlayer == "x" ? "o" : "x";
      if (!_board.any((row) => row.any((cell) => cell.isEmpty))) {
        _winner = "It's a tie";
      }
      if (_winner.isNotEmpty) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              _winner == "x"
                  ? "${widget.player1} Won!"
                  : _winner == "o"
                      ? "${widget.player2} Won! Start over?"
                      : "It's a tie",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetGame();
                },
                child: const Text("Play again"),
              ),
            ],
          ),
        );
      }
    });
  }

  bool _checkWinner(int row, int col) {
    return _board[row][0] == _currentPlayer &&
            _board[row][1] == _currentPlayer &&
            _board[row][2] == _currentPlayer ||
        _board[0][col] == _currentPlayer &&
            _board[1][col] == _currentPlayer &&
            _board[2][col] == _currentPlayer ||
        _board[0][0] == _currentPlayer &&
            _board[1][1] == _currentPlayer &&
            _board[2][2] == _currentPlayer ||
        _board[0][2] == _currentPlayer &&
            _board[1][1] == _currentPlayer &&
            _board[2][0] == _currentPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323D5B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            SizedBox(
              height: 100,
              child: Column(children: [
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Turn: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "${_currentPlayer == "x" ? widget.player1 : widget.player2} ($_currentPlayer)",
                        style: TextStyle(
                          color: _currentPlayer == "x"
                              ? Colors.red[300]
                              : Colors.blue[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(5),
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
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
                        padding: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Text(
                                _board[row][col],
                                style: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  color: _board[row][col] == "x"
                                      ? Colors.red[300]
                                      : Colors.blue[600],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: _resetGame,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                    child: const Text(
                      'Reset Game',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
