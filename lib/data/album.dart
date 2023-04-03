// ignore_for_file: non_constant_identifier_names

//import 'dart:ffi';

class Album {
  late final int id;
  late final int? userId;
  late final String? title;

  Album.fromJson(dynamic json)
      : id = json['id'],
        userId = json['userId'],
        title = json['title'];
}

class AlbumDetail {
  late final int albumId;
  late final int id;
  late final String title;
  late final String url;
  late final String thumbnailUrl;

  AlbumDetail.fromJson(Map json)
      : albumId = json['albumId'],
        id = json['id'],
        title = json['title'],
        url = json['url'],
        thumbnailUrl = json['thumbnailUrl'];
}

class Links {
  late final String? self;
  Links.fromJson(Map json) : self = json['self'];
}
