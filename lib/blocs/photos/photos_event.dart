import 'package:equatable/equatable.dart';
import 'package:photos/models/photos.dart';

abstract class PhotosEvent extends Equatable {
  const PhotosEvent();

  @override
  List<Object> get props => [];
}

class LoadPhotos extends PhotosEvent {}

class AddPhoto extends PhotosEvent {
  final Photos photo;

  const AddPhoto(this.photo);

  @override
  List<Object> get props => [photo];

  @override
  String toString() => 'AddPhoto { photo: $photo }';
}

class DeletePhoto extends PhotosEvent {
  final Photos photo;

  const DeletePhoto(this.photo);

  @override
  List<Object> get props => [photo];

  @override
  String toString() => 'DeletePhoto { photo: $photo }';
}

class PhotosUpdated extends PhotosEvent {
  final List<Photos> gallery;

  const PhotosUpdated(this.gallery);

  @override
  List<Object> get props => [gallery];
}
