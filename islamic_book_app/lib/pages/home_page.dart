import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamic_book_app/pages/NavDrawer.dart';

import 'chapter_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List> booksListFuture;
  Future<List> getBooksList() async {
    var response = await http.get(Uri.parse("http://alquranbd.com/api/hadith"));
    if (response.statusCode == 200) {
      List resData = jsonDecode(response.body);
      return resData;
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    super.initState();
    booksListFuture = getBooksList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Center(child: Text('বাংলা হাদিস')),
        actions: [
          PopupMenuButton(
            color: Colors.black,
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(
                child: Text(
                  "Night Mode",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
              PopupMenuItem(
                  child: Text(
                "Night Mode On",
                style: TextStyle(color: Colors.greenAccent),
              )),
              PopupMenuItem(
                child: Text(
                  "Rate Us ",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: booksListFuture,
            builder: (BuildContext context, AsyncSnapshot<List> sn) {
              if (sn.hasData) {
                return ListView.builder(
                  itemCount: sn.data!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChaptersList(
                            bookName: sn.data![index]["nameBengali"],
                            bookKey: sn.data![index]["book_key"]),
                      ));
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: Text(
                            sn.data![index]["id"],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(sn.data![index]["nameBengali"]),
                        subtitle: Text(sn.data![index]["book_key"]),
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
              icon: Icon(Icons.person), label: 'Account', tooltip: "Account"),
        ],
      ),
    );
  }
}
