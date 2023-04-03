import 'package:my_album_app/data/album.dart';
import 'package:flutter/material.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({
    required this.album,
    Key? key,
  }) : super(key: key);
  final Album album;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Id: ${album.id}',
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (album.title != null)
              Text.rich(
                TextSpan(
                  text: 'Album title: ${album.title}',
                  style: textTheme.bodyMedium,
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
