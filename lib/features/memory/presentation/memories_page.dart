import 'package:flutter/material.dart';

class MemoriesPage extends StatelessWidget {
  const MemoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memories'),
      ),
      body: Center(
        child: Text('Your past conversations and memories will be displayed here.'),
      ),
    );
  }
}