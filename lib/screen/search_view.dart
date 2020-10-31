import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos/blocs/blocs.dart';
import 'package:photos/model/model.dart';
import 'package:photos/widgets/display_photos.dart';

class SearchView extends StatefulWidget {
  final PhotoSearchBloc photoSearchBloc;
  final String search;

  SearchView({
    @required this.photoSearchBloc,
    @required this.search,
  });

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Photos> gallery = new List();
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    searchController.text = widget.search;
    widget.photoSearchBloc.add(
      TextChanged(text: widget.search),
    );
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
                        hintText: "Search Photos by Name",
                        border: InputBorder.none)
                      )
                    ),
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
              BlocBuilder<PhotoSearchBloc, PhotoSearchState>(
                  cubit: widget.photoSearchBloc,
                  builder: (context, state) {
                    if (state is SearchStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SearchStateSuccess) {

                      return DisplayPhotos(
                          photos: state.results
                      );
                    } else {
                      return Container();
                    }
                  }
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
