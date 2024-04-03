import 'package:flutter/material.dart';

class SamplePage extends StatelessWidget {
  final String extraString;

  const SamplePage({super.key, required this.extraString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(extraString),
      ),
    );
  }
}
