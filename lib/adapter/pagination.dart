import 'dart:convert';

import 'package:dcard_clone/models/api.dart';

typedef DecoderFunc<T> = Future<List<T>> Function(dynamic response);
typedef FromJsonFunc<T> = T Function(dynamic json);
typedef SelectIdFunc<T> = String Function(T item);
typedef GetPaginationKeyFunc = String Function(Map<String, dynamic> query);

String defaultGetPaginationKey(Map<String, dynamic> query) {
  return json.encode(query);
}

class Pagination<T> {
  List<String> indices = [];
  String error;
  bool loading = false;
  bool fetched = false;
}

class PaginationAdapter<T> {
  /// provided by invoker
  FromJsonFunc<T> fromJson;
  SelectIdFunc<T> selectId;
  GetPaginationKeyFunc getPaginationKey;
  PaginationAdapter(this.fromJson, this.selectId,
      [this.getPaginationKey = defaultGetPaginationKey]);

  /// accessible attributes
  Map<String, Pagination<T>> paginations = {};
  Map<String, T> store = {};

  ApiModel api = ApiModel();
  Future<void> list(String path, [Map<String, dynamic> query]) async {
    final paginationKey = query is Map ? this.getPaginationKey(query) : '';

    /// append default pagination
    if (paginations[paginationKey] == null) {
      paginations[paginationKey] = Pagination<T>();
    }

    /// get pagination
    final pagination = paginations[paginationKey];

    pagination.loading = true;

    try {
      final response = await api.fetch(path, query);
      final listDecoder = _makeListDecoder(this.fromJson);
      final payload = await listDecoder(response);

      for (var item in payload) {
        var id = this.selectId(item);
        pagination.indices.add(id);
        store[id] = item;
      }

      pagination.loading = false;
      pagination.fetched = true;
    } catch (e) {
      pagination.error = e.toString();
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

  T selectEntry(String id) {
    return store[id];
  }

  Pagination<T> selectPagination([Map<String, dynamic> query]) {
    final paginationKey = query is Map ? this.getPaginationKey(query) : '';
    final pagination = paginations[paginationKey];
    return pagination ?? Pagination<T>();
  }

  List<T> selectEntryList([Map<String, dynamic> query]) {
    final paginationKey = query is Map ? this.getPaginationKey(query) : '';
    final pagination = paginations[paginationKey];
    if (pagination == null) return [];

    return pagination.indices.map((id) => store[id]).toList();
  }
}
