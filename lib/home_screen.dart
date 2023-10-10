import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic/recently_played.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> widgetOptions = <Widget>[];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Add Bottom Navigation Bar Here : Dashboard and Playlist Add/Remove View
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playtify home screen"),
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                child: ChangeNotifierProvider(
                  create: (_) => RecentlyPlayedLogic(),
                  child: const RecentlyPlayed(),
                ),
              ),
              // MadeforYou(),
              // RecomendedforYou(),
              // PopularTrending(),
              // EditorsPicks(),
              // GlobalReleases(),
              // BecauseYouLike(),
            ],
          ),
        ],
      )),
      bottomNavigationBar: Container(
        height: 60.0,
        color: Colors.grey.withOpacity(0.2),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.home),
                Text("Home"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text("Search"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.library_music),
                Text("Library"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person_outline),
                Text("Premium"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    final recentlyPlayed = Provider.of<RecentlyPlayedLogic>(context);
    if (!recentlyPlayed.funCalled) {
      recentlyPlayed.getSongHistory();
    }

    return Column(
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
            style: TextStyle(fontFamily: 'Proxima Nova Bold', fontSize: 30.0),
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
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  /*(recentlyPlayed
                                          .recntlyPlayedStuff[i].type ==
                                      "song")
                                  ? NetworkImage(recentlyPlayed
                                      .recntlyPlayedStuff[i].thumbnail)
                                  :*/
                                  AssetImage(recentlyPlayed
                                      .recntlyPlayedStuff[i].thumbnail),
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
    );
  }
}
