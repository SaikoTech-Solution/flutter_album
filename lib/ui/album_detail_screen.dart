import 'package:my_album_app/bloc/album_detail_bloc.dart';
import 'package:my_album_app/bloc/bloc_provider.dart';
import 'package:my_album_app/data/album.dart';
import 'package:my_album_app/ui/album_detail_item.dart';
import 'package:flutter/material.dart';

class AlbumDetailScreen extends StatelessWidget {
  const AlbumDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AlbumDetailBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles detail'),
      ),
      body: RefreshIndicator(
        onRefresh: bloc.refresh,
        child: Container(
          alignment: Alignment.center,
          child: _buildContent(bloc),
        ),
      ),
    );
  }

  Widget _buildContent(AlbumDetailBloc bloc) {
    return StreamBuilder<List<AlbumDetail>?>(
      stream: bloc.albumDetailStream,
      builder: (context, snapshot) {
        final albumList = snapshot.data;
        if (albumList == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return AlbumDetailItem(albumList);
      },
    );
  }
}
