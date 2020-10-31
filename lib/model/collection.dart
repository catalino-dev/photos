import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:photos/model/model.dart';

part 'collection.g.dart';

@HiveType(typeId: 0)
class Collection extends Equatable {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final List<Photos> photos;

  Collection({
    @required this.name,
    this.imageUrl,
    this.photos,
  }) : super([name, imageUrl, photos]);

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    name: json["name"],
    imageUrl: json["imageUrl"],
    photos: json["photos"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "imageUrl": imageUrl,
    "photos": photos,
  };

  @override
  List<Object> get props => [name, imageUrl, photos];
}
