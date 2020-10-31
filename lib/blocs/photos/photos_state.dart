import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../model/photos.dart';

@immutable
abstract class PhotosState extends Equatable {
  PhotosState([List props = const []]) : super(props);
}

class PhotosInitial extends PhotosState {}

class PhotosLoading extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<Photos> photos;

  PhotosLoaded(this.photos) : super([photos]);
}
