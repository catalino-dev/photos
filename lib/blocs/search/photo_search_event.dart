import 'package:equatable/equatable.dart';

abstract class PhotoSearchEvent extends Equatable {
  const PhotoSearchEvent();
}

class TextChanged extends PhotoSearchEvent {
  final String text;

  const TextChanged({this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
