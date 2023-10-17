import 'package:flutter/material.dart';
import 'package:playtify/logic/recently_played.dart';
import 'package:playtify/pages/playlist.dart';
import 'package:playtify/pages/search.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  static const List<Widget> pages = <Widget>[
    RecentlyPlayed(),
    SearchPage(),
    PlayListPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playtify home screen"),
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        iconSize: 30,
        currentIndex: selectedIndex,
        onTap: onItemTapped,  // Directly using the onItemTapped function here
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.headphones,
                color: Colors.black,
                size: 40,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 40,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.queue_music_outlined,
                color: Colors.black,
                size: 40,
              ),
              label: ""),
        ],
      ),
    );
  }
}

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({Key? key}) : super(key: key);  // Corrected this line

  @override
  Widget build(BuildContext context) {
    final recentlyPlayed = Provider.of<RecentlyPlayedLogic>(context);

    if (!recentlyPlayed.funCalled) {
      recentlyPlayed.getSongHistory();
      recentlyPlayed.funCalled = true; // To ensure the function isn't called multiple times
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const InkWell(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.settings),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
              child: Text(
                "Recently played",
                style:
                    TextStyle(fontFamily: 'Proxima Nova Bold', fontSize: 30.0),
              ),
            ),
            !recentlyPlayed.funCalled
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: recentlyPlayed.recntlyPlayedStuff.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      AssetImage(recentlyPlayed.recntlyPlayedStuff[i].thumbnail),
                                  fit: BoxFit.cover,
                                )),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                recentlyPlayed.recntlyPlayedStuff[i].title,
                                style: const TextStyle(
                                  fontFamily: 'Proxima Nova Bold',
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
