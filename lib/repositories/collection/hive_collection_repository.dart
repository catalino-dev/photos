import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:photos/model/model.dart';
import 'package:photos/repositories/abstract_repository.dart';

class HiveCollectionRepository implements AbstractRepository<Collection> {
  final AbstractRepository<Collection> cache;

  HiveCollectionRepository({
    @required this.cache,
  });

  @override
  Future<void> add(Collection collection) async {
    await this.cache.add(collection);
  }

  @override
  Future<void> delete(dynamic id) async {
    return this.cache.delete(id);
  }

  @override
  Future<Collection> get(dynamic id) {
    return this.cache.get(id);
  }

  @override
  Future<List<Collection>> getAll() async {
    return await this.cache.getAll();
  }

  @override
  Future<void> update(dynamic id, Collection collection) async {
    return await this.cache.update(id, collection);
  }
}
