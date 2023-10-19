import 'package:flutter/material.dart';
import 'package:playtify/logic/recently_played.dart';
import 'package:playtify/pages/playlist.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:playtify/pages/search.dart';
import 'package:provider/provider.dart';
// import 'pages/recently_played.dart';

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
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Home",
            style: TextStyle(
              fontFamily: 'Proxima Nova Bold',
              fontSize: 31,
            )),
        backgroundColor: Colors.blue,
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 3, top: 10, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recently Played",
                    style: TextStyle(
                      fontFamily: 'Proxima Nova Bold',
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontFamily: 'Proxima Nova Bold',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 1),
              child: SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryCardMallika1(
                        title: "Pop",
                        image: "assets/pop.jpg",
                        onTap: () {},
                        selected: false,
                      ),
                      CategoryCardMallika1(
                          title: "Love",
                          image:
                              "assets/love.png",
                          onTap: () {}),
                      CategoryCardMallika1(
                          title: "Song",
                          image: "assets/love.png",
                          onTap: () {}),
                      CategoryCardMallika1(
                          title: "Song",
                          image:
                              "assets/pop.jpg",
                          onTap: () {}),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 2, right: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Playlist",
                    style: TextStyle(
                      fontFamily: 'Proxima Nova Bold',
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontFamily: 'Proxima Nova Bold',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 1, top: 20, right: 1),
              child: CarouselSlider(
                options: CarouselOptions(height: 200.0),
                items: [
                  "assets/south.png",
                  "assets/south.png",
                  "assets/south.png"
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              // color: Colors.amber,

                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Image(
                                  image: AssetImage(
                            "$i",
                          ))));
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        iconSize: 30,
        currentIndex: selectedIndex,
        onTap: (value) {
          onItemTapped(value);
        },
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.blue,
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
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    final recentlyPlayed = Provider.of<RecentlyPlayedLogic>(context);
    if (!recentlyPlayed.funCalled) {
      recentlyPlayed.getSongHistory();
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
        ),
      ),
    );
  }
}

class CategoryCardMallika1 extends StatelessWidget {
  final String title;
  final String image;
  final Function() onTap;
  final bool selected;
  const CategoryCardMallika1(
      {required this.title,
      required this.image,
      required this.onTap,
      this.selected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: selected ? 2 : 0, color: const Color(0xffFF8527)),
                  borderRadius: BorderRadius.circular(20.0)),
              child: ClipRRect(
                child: Image.asset(
                  image,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 12.5,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: selected ? const Color(0xffFF8527) : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
