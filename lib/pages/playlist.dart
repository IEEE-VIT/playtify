import 'package:flutter/material.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key});

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.network(
                "https://static.vecteezy.com/system/resources/previews/023/506/852/original/cute-kawaii-mushroom-chibi-mascot-cartoon-style-vector.jpg"),
                const Text("Library Goes here",style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}
