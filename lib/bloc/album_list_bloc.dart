import 'dart:async';

import 'package:my_album_app/bloc/bloc.dart';
import 'package:my_album_app/data/album.dart';
import 'package:my_album_app/data/client.dart';
import 'package:rxdart/rxdart.dart';

class AlbumListBloc implements Bloc {
  final _client = Client();
  final _searchQueryController = StreamController<String?>();
  Sink<String?> get searchQuery => _searchQueryController.sink;
  late Stream<List<Album>?> articlesStream;

  AlbumListBloc() {
    articlesStream = _searchQueryController.stream
        .startWith(null) // 1
        .debounceTime(const Duration(milliseconds: 100)) // 2
        .switchMap(
          // 3
          (query) => _client
              .fetchAlbums(query)
              .asStream() // 4
              .startWith(null), // 5
        );
  }

  @override
  void dispose() {
    _searchQueryController.close();
  }
}
