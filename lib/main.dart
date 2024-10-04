import 'package:flutter/material.dart';

import 'app/game_screen.dart';

void main() {
  runApp(const MainApp());
}

// Quantidade inicial de discos, valor podendo ser mudado em tempo de execução
int num_disks = 4;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Controlador para chamar função de animação em GameScreen, movendo o
    // disco de um haste para outro.
    final controller = Controller();

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: GameScreen(
            controller: controller,
            onStart: () => moveRecursive(num_disks, 0, 1, 2, controller),
          ),
        ),
      ),
    );
  }

  // Função contendo lógica principal da solução, resolvendo o problema
  // através da recursão, onde controller.move chama o callback de uma função
  // definida em GameScreen, que contém a lógica do layout, e que reproduz
  // a animação de movimento do disco.
  Future<void> moveRecursive(int n, int source, int destination, int auxiliary,
      Controller controller) async {
    if (n == 1) {
      await controller.move(source, destination);
      return;
    }

    await moveRecursive(n - 1, source, auxiliary, destination, controller);
    await controller.move(source, destination);
    await moveRecursive(n - 1, auxiliary, destination, source, controller);
  }
}
