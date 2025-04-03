import 'package:app/core/widget/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatbotPage extends ConsumerWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: BackgroundImageFb1(
            child: Center(
      child: ElevatedButton(onPressed: () {}, child: const Text('Groq')),
    )));
  }
}
