import 'package:dicee/pages/dice_page.dart';
import 'package:dicee/pages/one_dice.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dicee+',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.casino_outlined),
              text: 'One die',
            ),
            Tab(
              icon: Icon(Icons.casino),
              text: 'Two dice',
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            OneDicePage(),
            DicePage(),
          ],
        ),
      ),
    );
  }
}
