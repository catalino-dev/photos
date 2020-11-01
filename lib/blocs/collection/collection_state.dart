import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:photos/models/collection.dart';

@immutable
abstract class CollectionState extends Equatable {
  CollectionState([List props = const []]) : super(props);
}

class CollectionInitial extends CollectionState {}

class CollectionLoading extends CollectionState {}

class CollectionLoaded extends CollectionState {
  final List<Collection> collections;

  CollectionLoaded(this.collections) : super([collections]);
}
