import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 250,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/empty.png'),
            Positioned(
              top: 10,
              right: 10,
              child: FilledButton(
                onPressed: () => onPressed(),
                child: const Text('Retry'),
              ),
            ),
          ],
        ));
  }
}
