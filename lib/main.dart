import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Dicee'),
        backgroundColor: Colors.red,
      ),
      body: DicePage(),
    ),
  ));
}

class DicePage extends StatelessWidget {
  const DicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                onPressed: () {
                  print('Left button got pressed');
                },
                child: Image.asset('images/dice1.png')),
          ),
          Expanded(
            child: TextButton(
                onPressed: () {
                  print('Right button got pressed');
                },
                child: Image.asset('images/dice1.png')),
          ),
        ],
      ),
    );
  }
}
