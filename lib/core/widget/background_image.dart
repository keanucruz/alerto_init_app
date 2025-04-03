import 'package:flutter/material.dart';

class BackgroundImageFb1 extends StatelessWidget {
  final Widget child;

  const BackgroundImageFb1({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: child);
  }
}
