import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Simple extends StatelessWidget {
  const Simple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Desktop'),
      ),
    );
  }
}
