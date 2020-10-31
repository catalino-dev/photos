import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:photos/model/model.dart';
import 'package:photos/repositories/abstract_repository.dart';

class HivePhotosRepository implements AbstractRepository<Photos> {
  final AbstractRepository<Photos> cache;

  HivePhotosRepository({
    @required this.cache,
  });

  @override
  Future<void> add(Photos photo) async {
    await this.cache.add(photo);
  }

  @override
  Future<void> delete(dynamic id) async {
    return this.cache.delete(id);
  }

  @override
  Future<Photos> get(dynamic id) {
    return this.cache.get(id);
  }

  @override
  Future<List<Photos>> getAll() async {
    return await this.cache.getAll();
  }

  @override
  Future<void> update(dynamic id, Photos photo) async {
    return await this.cache.update(id, photo);
  }
}
