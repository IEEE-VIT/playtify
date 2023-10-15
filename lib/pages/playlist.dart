import 'package:flutter/material.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key});

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
          
                Text("Library Goes here",style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}
