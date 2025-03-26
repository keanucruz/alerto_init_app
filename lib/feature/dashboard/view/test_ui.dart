import 'package:app/feature/dashboard/widget/glassmorphic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class TestUi extends ConsumerWidget {
  const TestUi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: GestureDetector(
                onTap: () {},
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Glassmorphism(
                      blur: 10,
                      opacity: 0.2,
                      radius: 12,
                      width: 50,
                      height: 50,
                      child: Icon(Icons.question_mark, color: Colors.white),
                    ),
                    Glassmorphism(
                      blur: 10,
                      opacity: 0.2,
                      radius: 12,
                      width: 50,
                      height: 50,
                      child:
                          Icon(Icons.chat_bubble_outline, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(36),
            child: Center(
              child: Column(
                children: [
                  Text(
                    '28 C°',
                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Dagupan City',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Clouds',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'overcast clouds',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Lottie.asset(
                    'assets/alternate.json',
                  ),
                  Text(
                    'Heat Index: 51°',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'EXTREME DANGER',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search))
                ],
              ),
            ),
          )),
    );
  }
}
