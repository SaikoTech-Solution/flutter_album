import 'dart:async';
import 'dart:convert' show json;

import 'package:my_album_app/data/album.dart';
import 'package:http/http.dart' as http;

class Client {
  final _host = 'jsonplaceholder.typicode.com';

  Future<List<Album>?> fetchAlbums(String? query) async {
    Map<String, Object> params = {
      'filter[content_types][]': 'article',
      'page[size]': '25',
    };

    if (query != null && query.isNotEmpty) {
      params['filter[q]'] = query;
    }

    final results = await request(path: 'albums', parameters: params);
    final albums = results.map<Album>((album) => Album.fromJson(album)).toList(growable: false);
    return albums;
  }

  Future<List<AlbumDetail>> getDetailAlbum(int id) async {
    final results = await request(path: 'albums/$id/photos', parameters: {});
    final albumDetails = results.map<AlbumDetail>((albumDetail) => AlbumDetail.fromJson(albumDetail)).toList(growable: false);
    return albumDetails;
  }

  Future<dynamic> request({
    required String path,
    required Map<String, Object> parameters,
  }) async {
    final uri = Uri.https(_host, '/$path', parameters);
    final headers = _headers;
    final results = await http.get(uri, headers: headers);
    final dynamic jsonObject = json.decode(results.body);
    if (jsonObject is List<dynamic>) {
      return List.from(jsonObject);
    }
    return jsonObject;
  }

  Map<String, String> get _headers => {
        'content-type': 'application/vnd.api+json; charset=utf-8',
        'Accept': 'application/json',
      };
}
