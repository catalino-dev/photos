import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photos/home_screen.dart';
import 'package:photos/models/models.dart';
import 'package:photos/repositories/abstract_repository.dart';
import 'package:photos/repositories/collection/hive_collection_repository.dart';
import 'package:photos/repositories/hive_repository.dart';
import 'package:photos/repositories/photos/hive_photos_repository.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Photos>(PhotosAdapter());
  Hive.registerAdapter<Collection>(CollectionAdapter());
  final photosBox = await Hive.openBox<Photos>('Photos');
  final collectionsBox = await Hive.openBox<Collection>('Collections');
  // HydratedBloc.storage = await HydratedStorage.build();
  // Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    photosBox: photosBox,
    collectionsBox: collectionsBox,
  ));
}

class MyApp extends StatelessWidget {
  final Box<Photos> photosBox;
  final Box<Collection> collectionsBox;

  const MyApp({
    Key key,
    @required this.photosBox,
    @required this.collectionsBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AbstractRepository<Photos>>(
          create: (_) => HivePhotosRepository(
            cache: HiveRepository<Photos>(this.photosBox),
          ),
        ),
        RepositoryProvider<AbstractRepository<Collection>>(
          create: (_) => HiveCollectionRepository(
            cache: HiveRepository<Collection>(this.collectionsBox),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Photos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
