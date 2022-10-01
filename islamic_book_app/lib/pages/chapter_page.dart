import 'dart:convert';
import 'NavDrawer.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'hadith_list_page.dart';

class ChaptersList extends StatefulWidget {
  final String? bookName;
  final String? bookKey;

  const ChaptersList({
    Key? key,
    required String this.bookName,
    required this.bookKey,
  }) : super(key: key);

  @override
  _ChaptersListState createState() => _ChaptersListState();
}

class _ChaptersListState extends State<ChaptersList> {
  late Future<List> chaptersListFuture;

  Future<List> getChaptersList() async {
    var response = await http
        .get(Uri.parse("http://alquranbd.com/api/hadith/${widget.bookKey}/"));
    if (response.statusCode == 200) {
      print(response.body);
      List resData = jsonDecode(response.body);
      return resData;
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    super.initState();
    chaptersListFuture = getChaptersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Center(child: Text(widget.bookName!)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: FutureBuilder(
          future: chaptersListFuture,
          builder: (BuildContext context, AsyncSnapshot<List> sn) {
            if (sn.hasData) {
              return ListView.builder(
                itemCount: sn.data!.length,
                itemBuilder: (context, index) => Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => HadithListPage(
                            book_key: widget.bookKey,
                            chapter_no: sn.data![index]["chSerial"],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        child: Text(
                          sn.data![index]["chSerial"],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(sn.data![index]["nameBengali"]),
                      subtitle: Text(sn.data![index]["hadith_number"]),
                    ),
                  ),
                ),
              );
            } else if (sn.hasError) {
              return Text("Problem Loading Data");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedLabelStyle: TextStyle(color: Colors.greenAccent),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            tooltip: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favourite',
            tooltip: 'Favourite',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_outlined), label: 'Menu', tooltip: "Menu"),
        ],
      ),
    );
  }
}
