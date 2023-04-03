//
import 'package:my_album_app/bloc/album_detail_bloc.dart';
import 'package:my_album_app/bloc/album_list_bloc.dart';
import 'package:my_album_app/bloc/bloc_provider.dart';
import 'package:my_album_app/data/album.dart';
import 'package:my_album_app/ui/album_detail_screen.dart';
import 'package:my_album_app/ui/album_list_item.dart';
import 'package:flutter/material.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AlbumListBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search ...',
              ),
              onChanged: bloc.searchQuery.add,
            ),
          ),
          Expanded(
            child: _buildResults(bloc),
          )
        ],
      ),
    );
  }

  Widget _buildResults(AlbumListBloc bloc) {
    // 1
    return StreamBuilder<List<Album>?>(
      stream: bloc.articlesStream,
      builder: (context, snapshot) {
        // 2
        final results = snapshot.data;
        if (results == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (results.isEmpty) {
          return const Center(child: Text('No Results'));
        }
        // 3
        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Album> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final album = results[index];
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AlbumListItem(album: album),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  bloc: AlbumDetailBloc(id: album.id),
                  child: const AlbumDetailScreen(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
