import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());

  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.red,
          appBar: AppBar(
            title: const Text(
              'Dicee',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
            centerTitle: true,
          ),
          bottomNavigationBar: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(5.0),
              indicatorColor: Colors.redAccent,
              tabs: [
                Tab(
                  icon: Image.asset('images/icons8-dice-100.png'),
                ),
                Tab(
                  icon: Image.asset('images/icons8-cubos-de-dados-64.png'),
                )
              ]),
          body: const TabBarView(
            children: [
              OneDicePage(),
              DicePage(),
            ],
          ),
        ),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int letfDiceNumber = 1;
  int rightDiceNumber = 1;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _loading
                    ? const CircularProgressIndicatorWidget()
                    : Image.asset('images/dice$letfDiceNumber.png'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _loading
                    ? const CircularProgressIndicatorWidget()
                    : Image.asset('images/dice$rightDiceNumber.png'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30.0,
        ),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _loading = true;
            });
            Future.delayed(const Duration(milliseconds: 500)).then((_) {
              throwDices();
            });
          },
          icon: Image.asset('images/icons8-dice-100.png'),
          label: const Text(''),
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
        )
      ],
    );
  }

  throwDices() {
    setState(() {
      _loading = false;
      letfDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }
}

class OneDicePage extends StatefulWidget {
  const OneDicePage({super.key});

  @override
  State<OneDicePage> createState() => _OneDicePageState();
}

class _OneDicePageState extends State<OneDicePage> {
  int diceNumber = 1;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _loading
            ? const CircularProgressIndicatorWidget()
            : Image.asset(
                'images/dice$diceNumber.png',
                height: 150.0,
                width: 150.0,
              ),
        const SizedBox(height: 30.0),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _loading = true;
            });
            Future.delayed(const Duration(milliseconds: 500)).then((_) {
              throwDice();
            });
          },
          icon: Image.asset('images/icons8-dice-100.png'),
          label: const Text(''),
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
        )
      ],
    );
  }

  throwDice() {
    setState(() {
      _loading = false;
      diceNumber = Random().nextInt(6) + 1;
    });
  }
}

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 5,
      backgroundColor: Colors.redAccent,
      valueColor: AlwaysStoppedAnimation(Colors.red),
    );
  }
}
