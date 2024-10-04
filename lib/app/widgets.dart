import 'package:flutter/material.dart';
import 'package:hanoi_tower/app/colors.dart';
import 'package:hanoi_tower/main.dart';

class Menu extends StatelessWidget {
  final VoidCallback onStart;
  final void Function(int) onChangeNum;

  const Menu({super.key, required this.onStart, required this.onChangeNum});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'TORRE DE HANÓI',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Selector(n: num_disks, max: colors.length, onChange: onChangeNum),
        Button(
          text: 'Iniciar',
          onTap: onStart,
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const Button({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          color: Colors.black,
        ),
        width: 120,
        height: 40,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class Selector extends StatelessWidget {
  final int n;
  final int max;
  final void Function(int) onChange;

  const Selector({
    super.key,
    required this.n,
    required this.max,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectorBtn(
          inactive: n <= 1,
          icon: Icons.chevron_left,
          onTap: () => onChange(n - 1),
        ),
        SizedBox(
          width: 40,
          child: Center(
            child: Text(
              'n=$n',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        SelectorBtn(
          inactive: n >= max,
          icon: Icons.chevron_right,
          onTap: () => onChange(n + 1),
        ),
      ],
    );
  }
}

class SelectorBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool inactive;

  const SelectorBtn({
    super.key,
    required this.icon,
    required this.onTap,
    this.inactive = false,
  });

  Color get color => !inactive ? Colors.white : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !inactive ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
