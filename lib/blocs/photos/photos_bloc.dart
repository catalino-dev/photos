import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photos/blocs/photos/photos_event.dart';
import 'package:photos/blocs/photos/photos_state.dart';
import 'package:photos/models/models.dart';
import 'package:photos/repositories/abstract_repository.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final AbstractRepository<Photos> _photosRepository;
  StreamSubscription _photosSubscription;

  PhotosBloc({@required AbstractRepository<Photos> photosRepository})
      : assert(photosRepository != null),
        _photosRepository = photosRepository,
        super(PhotosLoading()) {
    this.listen((state) {
      if (state is PhotosLoaded) {
        add(PhotosUpdated(state.photos));
      }
    });
  }

  @override
  Stream<PhotosState> mapEventToState(PhotosEvent event) async* {
    if (event is LoadPhotos) {
      yield* _mapLoadPhotosToState();
    } else if (event is AddPhoto) {
      yield* _mapAddPhotoToState(event);
    } else if (event is DeletePhoto) {
      yield* _mapDeletePhotoToState(event);
    } else if (event is PhotosUpdated) {
      yield* _mapPhotosUpdateToState(event);
    }
  }

  Stream<PhotosState> _mapLoadPhotosToState() async* {
    _photosSubscription?.cancel();
    _photosSubscription = Stream.fromFuture(_photosRepository.getAll()).listen(
      (photos) => add(PhotosUpdated(photos)),
    );
  }

  Stream<PhotosState> _mapAddPhotoToState(AddPhoto event) async* {
    _photosRepository.add(event.photo);
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> _mapAddPhotoToState: ${_photosSubscription?.isPaused}');
    _photosSubscription?.cancel();
    _photosSubscription = Stream.fromFuture(_photosRepository.getAll()).listen(
          (photos) => add(PhotosUpdated(photos)),
    );
  }

  Stream<PhotosState> _mapDeletePhotoToState(DeletePhoto event) async* {
    _photosRepository.delete(event.photo);
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> _mapDeletePhotoToState: ${_photosSubscription?.isPaused}');
    _photosSubscription?.cancel();
    _photosSubscription = Stream.fromFuture(_photosRepository.getAll()).listen(
          (photos) => add(PhotosUpdated(photos)),
    );
  }

  Stream<PhotosState> _mapPhotosUpdateToState(PhotosUpdated event) async* {
    yield PhotosLoaded(event.gallery);
  }

  // @override
  // Map<String, dynamic> toJson(PhotosState state) {
  //   if (state is PhotosLoaded) {
  //     if (state.photos.isEmpty) {
  //       return Map();
  //     }
  //     return state.photos[0].toJson();
  //   } else {
  //     return null;
  //   }
  // }

  // @override
  // PhotosState fromJson(Map<String, dynamic> json) {
  //   try {
  //     final photos = Photos.fromJson(json);
  //     return PhotosLoaded([photos]);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  @override
  Future<void> close() {
    _photosSubscription?.cancel();
    return super.close();
  }
}
