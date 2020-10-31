import 'package:hive/hive.dart';
import 'package:photos/repositories/abstract_repository.dart';

class HiveRepository<T> implements AbstractRepository<T> {
  final Box _box;

  HiveRepository(this._box);

  @override
  Future<T> get(dynamic id) async {
    if (this.boxIsClosed) {
      return null;
    }

    return this._box.get(id);
  }

  @override
  Future<List<T>> getAll() async {
    if (this.boxIsClosed) {
      return List.empty();
    }

    Iterable<T> boxValues = this._box.values;
    if (boxValues.length == 0) {
      return List.empty();
    }
    return boxValues.toList();
  }

  @override
  Future<void> add(T object) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.add(object);
  }

  @override
  Future<void> delete(dynamic id) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.delete(id);
  }

  @override
  Future<void> update(dynamic id, T object) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.putAt(id, object);
  }

  bool get boxIsClosed => !(this._box?.isOpen ?? false);
}
