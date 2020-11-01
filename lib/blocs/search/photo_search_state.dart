import 'package:equatable/equatable.dart';
import 'package:photos/models/models.dart';

abstract class PhotoSearchState extends Equatable {
  const PhotoSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends PhotoSearchState {}

class SearchStateLoading extends PhotoSearchState {}

class SearchStateSuccess extends PhotoSearchState {
  final List<Photos> results;

  const SearchStateSuccess(this.results);

  @override
  List<Object> get props => [results];

  @override
  String toString() => 'SearchStateSuccess { results: $results }';
}

class SearchStateError extends PhotoSearchState {
  final String error;

  const SearchStateError(this.error);

  @override
  List<Object> get props => [error];
}
