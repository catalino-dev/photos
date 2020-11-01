import 'package:equatable/equatable.dart';
import 'package:photos/models/models.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class LoadCollection extends CollectionEvent {}

class AddCollection extends CollectionEvent {
  final Collection collection;

  const AddCollection(this.collection);

  @override
  List<Object> get props => [collection];

  @override
  String toString() => 'AddCollection { collection: $collection }';
}

class UpdateCollection extends CollectionEvent {
  final Collection collection;
  final String name;
  final Photos photo;

  const UpdateCollection(this.collection, this.name, this.photo);

  @override
  List<Object> get props => [collection, name, photo];

  @override
  String toString() => 'UpdateCollection { collection: $collection, name: $name, photo: $photo }';
}

class AddToCollection extends CollectionEvent {
  final dynamic id;
  final Photos photo;

  const AddToCollection(this.id, this.photo);

  @override
  List<Object> get props => [id, photo];

  @override
  String toString() => 'AddToCollection { photo: $photo }';
}

class DeleteCollection extends CollectionEvent {
  final Collection collection;

  const DeleteCollection(this.collection);

  @override
  List<Object> get props => [collection];

  @override
  String toString() => 'DeleteCollection { collection: $collection }';
}

class CollectionsUpdated extends CollectionEvent {
  final List<Collection> collections;

  const CollectionsUpdated(this.collections);

  @override
  List<Object> get props => [collections];

  @override
  String toString() => 'CollectionUpdated { collections: $collections }';
}
