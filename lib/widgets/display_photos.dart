import 'package:flutter/material.dart';
import 'package:photos/model/model.dart';

typedef AddToCollectionCallback = Function(Photos photo);

class DisplayPhotos extends StatelessWidget {
  final List<Photos> photos;
  final AddToCollectionCallback addToCollectionCallback;

  DisplayPhotos({
    @required this.photos,
    this.addToCollectionCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: photos.map((Photos photo) {
          return GridTile(
            child: GestureDetector(
              onTap: () {
                addToCollectionCallback(photo);
              },
              child: Hero(
                tag: photo.caption,
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        photo.sourceBytes,
                        height: 50,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ),
            )
          );
        }).toList()
      ),
    );
  }
}
