import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanoi_tower/app/tower_ui.dart';
import 'package:hanoi_tower/main.dart';

import 'widgets.dart';

const _duration = Duration(milliseconds: 800);

// Uma torre/haste é representada por uma lista de inteiros, pois cada disco
// pode ser visto como um inteiro de 1 a n.
typedef Tower = List<int>;
// Temp representa um disco "flutuante", para realizar a animação, o primeiro
// inteiro sendo o disco, o segundo inteiro sendo a haste onde está flutuando.
typedef Temp = (int, int);

enum GameState { initial, playing, done }

class GameScreen extends StatefulWidget {
  final Controller controller;
  final VoidCallback onStart;

  const GameScreen({
    required this.controller,
    required this.onStart,
    super.key,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

// Tela principal do jogo, contendo 3 torres, onde a primeira torre contém
// todos os discos

class _GameScreenState extends State<GameScreen> {
  final rods = List<Tower>.generate(3, (_) => <int>[]);
  var state = GameState.initial;
  Temp? temp;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Inicializa a primeira torre com os n discos
    List.generate(num_disks, (i) => num_disks - (i + 1))
        .forEach(rods.first.add);

    // Callback para quando, na main, for chamado controller.move
    widget.controller.animateMovement = (from, to) async {
      temp = (rods[from].last, from);
      rods[from].removeLast();
      await updateScreen();
      temp = (temp!.$1, to);
      await updateScreen();
      rods[to].add(temp!.$1);
      temp = null;
      await updateScreen();
    };
  }

  Future<void> updateScreen() async {
    setState(() {});
    await Future.delayed(_duration, () {});
  }

  @override
  Widget build(BuildContext context) {
    return TowerUI(
      rods: rods,
      temp: temp,
      body: state == GameState.initial
          ? Menu(
              onStart: () {
                setState(() => state = GameState.playing);
                widget.onStart();
              },
              onChangeNum: (n) {
                num_disks = n;

                rods.first.clear();
                List.generate(num_disks, (i) => num_disks - (i + 1))
                    .forEach(rods.first.add);

                setState(() {});
              },
            )
          : null,
    );
  }
}

class Controller {
  Future<void>? Function(int from, int to)? animateMovement;

  Future<void> move(int from, int to) async => animateMovement?.call(from, to);
}
