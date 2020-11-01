import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'photos.g.dart';

@HiveType(typeId: 1)
class Photos extends HiveObject {
  @HiveField(0)
  final String caption;

  @HiveField(1)
  final Uint8List sourceBytes;

  @HiveField(2)
  final String sourceUrl;

  Photos({
    @required this.caption,
    @required this.sourceBytes,
    @required this.sourceUrl,
  });

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
    caption: json["caption"],
    sourceBytes: json["sourceBytes"],
    sourceUrl: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "caption": caption,
    "sourceBytes": sourceBytes,
    "source": sourceUrl,
  };
}
