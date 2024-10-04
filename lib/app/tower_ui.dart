import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hanoi_tower/app/colors.dart';

import 'game_screen.dart';

// Componente visual das torres e discos, recebendo uma lista de torres,
// onde cada torre contém uma lista de discos, que são nada mais que inteiros.
// Além disso recebe um valor temporário que representa um disco quando se
// movendo entre as torres, onde ele fica "flutuando".

class TowerUI extends StatelessWidget {
  final List<Tower> rods;
  final Temp? temp;
  final Widget? body;

  const TowerUI({
    required this.rods,
    required this.temp,
    required this.body,
    super.key,
  });

  double diskDiameter(int i) => 40 + 30.0 * i;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          if (temp != null)
            Positioned(
              bottom: size.height * 0.4 + 150,
              left: size.width * 0.25 * (temp!.$2 + 1) -
                  diskDiameter(temp!.$1) / 2,
              child: _Disk(diskDiameter(temp!.$1), colors[temp!.$1]),
            ),
          ...List.generate(
            3,
            (i) => Positioned(
              bottom: size.height * 0.4,
              left: size.width * 0.25 * (i + 1) - 10,
              child: const _Rod(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: size.height * 0.4,
              color: Colors.black,
              child: body,
            ),
          ),
          ...rods.mapIndexed((i, disks) {
            return Positioned(
              bottom: size.height * 0.4,
              left: size.width * 0.25 * (i + 1) - 95,
              child: SizedBox(
                width: 190,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: disks.reversed
                      .map((e) => _Disk(diskDiameter(e), colors[e]))
                      .toList(),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class _Rod extends StatelessWidget {
  const _Rod();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 20,
      height: 140,
    );
  }
}

class _Disk extends StatelessWidget {
  final double diameter;
  final Color color;

  const _Disk(this.diameter, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      height: 20,
      width: diameter,
    );
  }
}
