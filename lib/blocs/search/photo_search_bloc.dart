import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photos/blocs/blocs.dart';
import 'package:photos/models/models.dart';
import 'package:photos/repositories/abstract_repository.dart';
import 'package:photos/repositories/photos/hive_photos_repository.dart';

class PhotoSearchBloc extends Bloc<PhotoSearchEvent, PhotoSearchState> {
  final HivePhotosRepository _photosRepository;

  PhotoSearchBloc({@required AbstractRepository photosRepository})
      : assert(photosRepository != null),
        _photosRepository = photosRepository,
        super(SearchStateLoading());

  @override
  Stream<PhotoSearchState> mapEventToState(PhotoSearchEvent event) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          await Future<void>.delayed(Duration(seconds: 3));
          final List<Photos> results = await _photosRepository.search(searchTerm);
          yield SearchStateSuccess(results);
        } catch (error) {
          yield SearchStateError('Something went wrong');
        }
      }
    }
  }
}
