import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:photos/blocs/blocs.dart';
import 'package:photos/model/collection.dart';
import 'package:photos/model/model.dart';
import 'package:photos/repositories/abstract_repository.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final AbstractRepository<Collection> _collectionRepository;
  StreamSubscription _collectionSubscription;

  CollectionBloc({@required AbstractRepository<Collection> collectionRepository})
      : assert(collectionRepository != null),
        _collectionRepository = collectionRepository,
        super(CollectionLoading()) {
    this.listen((state) {
      if (state is CollectionLoaded) {
        add(CollectionsUpdated(state.collections));
      }
    });
  }

  @override
  Stream<CollectionState> mapEventToState(CollectionEvent event) async* {
    if (event is LoadCollection) {
      yield* _mapLoadCollectionToState();
    } else if (event is AddCollection) {
      yield* _mapAddCollectionToState(event);
    } else if (event is UpdateCollection) {
      yield* _mapUpdateCollectionToState(event);
    } else if (event is DeleteCollection) {
      yield* _mapDeleteCollectionToState(event);
    } else if (event is CollectionsUpdated) {
      yield* _mapCollectionsUpdateToState(event);
    }
  }

  Stream<CollectionState> _mapLoadCollectionToState() async* {
    _collectionSubscription?.cancel();
    _collectionSubscription = Stream.fromFuture(_collectionRepository.getAll()).listen(
          (collections) => add(CollectionsUpdated(collections)),
    );
  }

  Stream<CollectionState> _mapAddCollectionToState(AddCollection event) async* {
    _collectionRepository.add(event.collection);
    _collectionSubscription?.cancel();
    _collectionSubscription = Stream.fromFuture(_collectionRepository.getAll()).listen(
          (collections) => add(CollectionsUpdated(collections)),
    );
  }

  Stream<CollectionState> _mapUpdateCollectionToState(UpdateCollection event) async* {
    Collection collection = event.collection;
    List<Photos> photos = collection.photos ?? List();
    bool photoAlreadyExistInCollection = photos.indexOf(event.photo) != -1;
    if (photoAlreadyExistInCollection) {
      return;
    }

    List<Collection> collections = await _collectionRepository.getAll();
    int index = collections.indexOf(collection);
    photos.add(event.photo);
    Collection updatedCollection = Collection(name: event.name, imageUrl: '', photos: photos);

    _collectionRepository.update(index, updatedCollection);
    _collectionSubscription?.cancel();
    _collectionSubscription = Stream.fromFuture(_collectionRepository.getAll()).listen(
          (collections) => add(CollectionsUpdated(collections)),
    );
  }

  Stream<CollectionState> _mapDeleteCollectionToState(DeleteCollection event) async* {
    List<Collection> collections = await _collectionRepository.getAll();
    int index = collections.indexOf(event.collection);
    _collectionRepository.delete(index);
    _collectionSubscription?.cancel();
    _collectionSubscription = Stream.fromFuture(_collectionRepository.getAll()).listen(
          (collections) => add(CollectionsUpdated(collections)),
    );
  }

  Stream<CollectionState> _mapCollectionsUpdateToState(CollectionsUpdated event) async* {
    yield CollectionLoaded(event.collections);
  }

  // @override
  // Map<String, dynamic> toJson(CollectionState state) {
  //   if (state is CollectionLoaded) {
  //     return state.photos.toJson();
  //   } else {
  //     return null;
  //   }
  // }

  // @override
  // CollectionState fromJson(Map<String, dynamic> json) {
  //   try {
  //     final photos = Collection.fromJson(json);
  //     return CollectionLoaded(photos);
  //   } catch (_) {
  //     return null;
  //   }
  // }
}
