import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField( 
             cursorHeight: 25,
              // onSubmitted: () {},
              style: const TextStyle(fontSize: 25,),
              onTapOutside: (event) =>
                  FocusScope.of(context).requestFocus(FocusNode()),
              decoration: const InputDecoration(hintText: "Search here",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                prefix: Icon(
                  Icons.search,
                  size: 25,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  Card(
                    child: Image.asset("assets/pop.jpg"),
                  ),
                  Card(
                    child: Image.asset("assets/jazzgenre.jpeg"),
                  ),
                  Card(
                    child: Image.asset("assets/love.png"),
                  ),
                  Card(
                    child: Image.asset("assets/folk.webp"),
                  ),
                  Card(
                    child: Image.asset("assets/hindi.jpg"),
                  ),
                  Card(
                    child: Image.asset("assets/south.png"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
