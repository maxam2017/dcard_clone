import 'package:dcard_clone/models/api.dart';

typedef DecoderFunc<T> = Future<List<T>> Function(dynamic response);
typedef FromJsonFunc<T> = T Function(dynamic json);
typedef SelectIdFunc<T> = String Function(T item);

class StoreAdapter<T> {
  /// provided by invoker
  FromJsonFunc<T> fromJson;
  SelectIdFunc<T> selectId;
  StoreAdapter(
    this.fromJson,
    this.selectId,
  );

  /// accessible attributes
  List<String> indices = [];
  Map<String, T> store = {};
  String error;
  bool loading = false;
  bool fetched = false;

  ApiModel api = ApiModel();
  Future<void> list(String path, [Map<String, dynamic> query]) async {
    loading = true;

    try {
      final response = await api.fetch(path, query);
      final listDecoder = _makeListDecoder(this.fromJson);
      final payload = await listDecoder(response);

      for (var item in payload) {
        var id = this.selectId(item);
        indices.add(id);
        store[id] = item;
      }

      loading = false;
      fetched = true;
    } catch (e) {
      error = e.toString();
    }
  }

  DecoderFunc<T> _makeListDecoder(FromJsonFunc<T> fromJson) {
    Future<List<T>> func(dynamic response) async {
      final json = await toJson(response);
      Iterable list = json;
      return list.map((item) => fromJson(item)).toList();
    }

    return func;
  }
}
