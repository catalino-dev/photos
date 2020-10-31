import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:hive/hive.dart';

part 'photos.g.dart';

@HiveType(typeId: 1)
class Photos extends HiveObject {
  @HiveField(0)
  final String caption;

  @HiveField(1)
  final Uint8List sourceBytes;

  @HiveField(2)
  final String source;

  Photos({
    @required this.caption,
    @required this.sourceBytes,
    this.source,
  });

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
    caption: json["caption"],
    sourceBytes: json["sourceBytes"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "caption": caption,
    "sourceBytes": sourceBytes,
    "source": source,
  };
}
