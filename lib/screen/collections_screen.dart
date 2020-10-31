import 'package:flutter/material.dart';
import 'package:photos/model/model.dart';
import 'package:photos/widgets/display_photos.dart';

class CollectionsScreen extends StatefulWidget {
  final Collection collection;
  final List<Widget> actions;

  CollectionsScreen({
    @required this.collection,
    this.actions,
  });

  @override
  _CollectionsScreenState createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Photos> photos = widget.collection.photos ?? List();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Collections",
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        elevation: 0.0,
        actions: widget.actions,
      ),
      body: SingleChildScrollView(
        child: DisplayPhotos(photos: photos)
      ),
    );
  }
}
