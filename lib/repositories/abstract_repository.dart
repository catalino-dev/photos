abstract class AbstractRepository<T> {
  Future<void> add(T object);
  Future<void> delete(dynamic id);
  Future<T> get(dynamic id);
  Future<List<T>> getAll();
  Future<void> update(dynamic id, T object);
}
