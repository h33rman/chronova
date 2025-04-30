import 'package:flutter/material.dart';


class OnGameScreen extends StatefulWidget {
  const OnGameScreen({super.key});

  @override
  State<OnGameScreen> createState() => _OnGameScreenState();
}

class _OnGameScreenState extends State<OnGameScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              backgroundColor: Colors.blue,
              pinned: true,
              floating: true,
              toolbarHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                background:  Column(
                  children: [
                    Text("data")
                  ],
                ),
                title: Text("On gaming"),
              ),
            ),
            SliverFillRemaining(

            )
          ],
        ),
      ),
    );
  }
}
