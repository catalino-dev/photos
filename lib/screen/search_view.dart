import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photos/model/model.dart';

class SearchView extends StatefulWidget {
  final String search;

  SearchView({@required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Photos> gallery = new List();
  TextEditingController searchController = new TextEditingController();

  // getSearchWallpaper(String searchQuery) async {
  //   await http.get(
  //       "https://api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1",
  //       headers: {"Authorization": apiKEY}).then((value) {
  //     //print(value.body);
  //
  //     Map<String, dynamic> jsonData = jsonDecode(value.body);
  //     jsonData["photos"].forEach((element) {
  //       //print(element);
  //       Photos photos = new Photos();
  //       photos = Photos.fromJson(element);
  //       gallery.add(photos);
  //       //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
  //     });
  //
  //     setState(() {});
  //   });
  // }

  @override
  void initState() {
    // getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "search wallpapers",
                          border: InputBorder.none),
                    )),
                    InkWell(
                        onTap: () {

                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Photos",
        style: TextStyle(color: Colors.blue),
      )
    ],
  );
}
