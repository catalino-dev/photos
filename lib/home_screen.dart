import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/modals.dart';
import 'package:photos/models/models.dart';
import 'package:photos/repositories/abstract_repository.dart';
import 'package:photos/screen/image_view.dart';
import 'package:photos/screen/search_view.dart';
import 'package:photos/widgets/collections_tile.dart';
import 'package:photos/widgets/display_photos.dart';

import 'blocs/blocs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PhotosBloc _photosBloc;
  PhotoSearchBloc _photoSearchBloc;
  CollectionBloc _collectionBloc;
  TextEditingController searchController = new TextEditingController();
  List<Collection> collections = List();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _photosBloc.close();
    _photoSearchBloc.close();
    _collectionBloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (this._collectionBloc == null) {
      final collectionRepository = RepositoryProvider.of<AbstractRepository<Collection>>(context);
      this._collectionBloc = CollectionBloc(collectionRepository: collectionRepository)
        ..add(LoadCollection());
    }
    if (this._photosBloc == null) {
      final photosRepository = RepositoryProvider.of<AbstractRepository<Photos>>(context);
      this._photosBloc = PhotosBloc(photosRepository: photosRepository)
        ..add(LoadPhotos());

      if (this._photoSearchBloc == null) {
        this._photoSearchBloc = PhotoSearchBloc(photosRepository: photosRepository);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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
                          border: InputBorder.none
                        ),
                      )
                    ),
                    InkWell(
                      onTap: () {
                        if (searchController.text != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                  SearchView(
                                    photoSearchBloc: this._photoSearchBloc,
                                    search: searchController.text,
                                  )
                              )
                          );
                        }
                      },
                      child: Container(child: Icon(Icons.search))
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Stack(
                children: [
                  BlocBuilder<CollectionBloc, CollectionState>(
                    cubit: this._collectionBloc,
                    builder: (context, state) {
                      if (state is CollectionLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CollectionLoaded) {
                        collections = state.collections;
                        return Container(
                          height: 80,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            itemCount: collections.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CollectionsTile(
                                collectionBloc: _collectionBloc,
                                collection: collections[index],
                              );
                            },
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    child: CollectionsTile(
                        collectionBloc: _collectionBloc
                    ),
                  ),
                ],
              ),
              BlocBuilder<PhotosBloc, PhotosState>(
                  cubit: this._photosBloc,
                  builder: (context, state) {
                    if (state is PhotosLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PhotosLoaded) {
                      return DisplayPhotos(
                        photos: state.photos,
                        addToCollectionCallback: (Photos photo) {
                          showPhoto(this._collectionBloc, photo);
                        }
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
      floatingActionButton: SizedBox(
        width: 180.0,
        height: 50.0,
        child: FloatingActionButton.extended(
          icon: Icon(Icons.add_photo_alternate),
          label: Text('Add Photo'),
          onPressed: () {
            openFile();
          },
        ),
      )
    );
  }

  Future<void> showPhoto(CollectionBloc collectionBloc, Photos photo) async {
    if (collectionBloc != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
              ImageView(
                photo: photo,
                menuItems: collections.expand((collection) => {
                  FocusedMenuItem(
                    title: Text(collection.name),
                    onPressed: () {
                      collectionBloc.add(
                        UpdateCollection(collection, collection.name, photo),
                      );
                    }
                  )
                }).toList(),
              )
          )
      );
    }
  }

  Future<void> openFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null && result.files.first != null) {
      PlatformFile file = result.files.first;
      _photosBloc.add(
        AddPhoto(Photos(caption: file.name, sourceBytes: file.bytes)),
      );
    }
  }
}

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Photos",
        style: TextStyle(color: Colors.black87),
      ),
    ],
  );
}
