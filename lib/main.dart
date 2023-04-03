import 'package:my_album_app/bloc/album_list_bloc.dart';
import 'package:my_album_app/bloc/bloc_provider.dart';
import 'package:my_album_app/ui/app_colors.dart';
import 'package:my_album_app/ui/album_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ArticleFinder());
}

class ArticleFinder extends StatelessWidget {
  const ArticleFinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w700BitterFont = GoogleFonts.bitter(
      fontWeight: FontWeight.w700,
    );
    return BlocProvider<AlbumListBloc>(
        bloc: AlbumListBloc(),
        child: MaterialApp(
          title: 'RW Finder',
          home: const AlbumListScreen(),
          theme: ThemeData(
            primarySwatch: AppColors.black,
            primaryColor: AppColors.black,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: AppColors.green,
                  primary: AppColors.black,
                  background: AppColors.grey, // Updated line
                ),
            scaffoldBackgroundColor: AppColors.grey,
            primaryTextTheme: TextTheme(
              titleLarge: w700BitterFont,
            ),
            textTheme: TextTheme(
              titleMedium: w700BitterFont.apply(color: AppColors.black),
              titleLarge: w700BitterFont.apply(color: AppColors.black),
              bodyMedium: TextStyle(color: AppColors.black),
            ),
          ),
        ));
  }
}
