import 'dart:async';

import 'package:my_album_app/bloc/bloc.dart';
import 'package:my_album_app/data/album.dart';
import 'package:my_album_app/data/client.dart';
import 'package:rxdart/rxdart.dart';

class AlbumDetailBloc implements Bloc {
  final int id;
  final _refreshController = StreamController<void>();
  final _client = Client();

  late Stream<List<AlbumDetail>?> albumDetailStream;

  AlbumDetailBloc({
    required this.id,
  }) {
    albumDetailStream = _refreshController.stream
        .startWith({})
        .mapTo(id)
        .switchMap(
          (id) => _client.getDetailAlbum(id).asStream(),
        )
        .map<List<AlbumDetail>>((albumList) => albumList.map<AlbumDetail>((album) => album).toList())
        .asBroadcastStream();
  }

  Future refresh() {
    final future = albumDetailStream.first;
    _refreshController.sink.add({});
    return future;
  }

  @override
  void dispose() {
    _refreshController.close();
  }
}
