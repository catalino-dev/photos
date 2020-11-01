import 'package:flutter/material.dart';
import 'package:photos/blocs/blocs.dart';
import 'package:photos/models/models.dart';
import 'package:photos/screen/collections_screen.dart';
import 'package:photos/widgets/custom_dialog.dart';
import 'package:photos/widgets/extra_actions.dart';

class CollectionsTile extends StatelessWidget {
  final CollectionBloc collectionBloc;
  final Collection collection;

  CollectionsTile({
    @required this.collectionBloc,
    this.collection
  });

  @override
  Widget build(BuildContext context) {
    final _scaffoldState = Scaffold.of(context);

    return GestureDetector(
      onTap: () {
        if (collection != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectionsScreen(
                collection: collection,
                actions: [
                  ExtraActions(
                    collection: collection,
                    menuAction: (action) {
                      _performMenuAction(_scaffoldState, action);
                    }
                  ),
                ],
              )
            )
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
              title: 'Add Collection',
              buttonText: 'Add',
              buttonAction: (collectionName) {
                collectionBloc.add(
                  AddCollection(Collection(name: collectionName)),
                );
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: collection != null ? BorderRadius.circular(8) : BorderRadius.circular(35),
          color: collection != null ? Colors.blue : Colors.deepOrange,
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              alignment: Alignment.center,
              child: collection != null ?  Text(
                collection.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400
                ),
              ) : Icon(
                Icons.add,
                size: 30.0,
                color: Colors.white,
              )
            ),
          ],
        ),
      ),
    );
  }

  _performMenuAction(ScaffoldState scaffoldState, ExtraAction action) {
    switch (action) {
      case ExtraAction.deleteCollection:
        collectionBloc.add(DeleteCollection(collection));
        scaffoldState.showSnackBar(
          SnackBar(
            content: Text(
              'Deleted the collection successfully.',
              overflow: TextOverflow.ellipsis,
            ),
            duration: Duration(seconds: 5),
          ),
        );
        Navigator.pop(scaffoldState.context);
        break;
    }
  }
}
