import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/presentation/downloads/widgets/screen_downloads.dart';
import 'package:netflix_app/presentation/fast_laugh/screen_fast_laugh.dart';
import 'package:netflix_app/presentation/home/screen_home.dart';
import 'package:netflix_app/presentation/main_page/widgets/bottom_nav.dart';
import 'package:netflix_app/presentation/new_and_hot/screen_new_and_hot.dart';
import 'package:netflix_app/presentation/search/screen_search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({Key? key}) : super(key: key);

  final pages = [
    ScreenHome(),
    ScreenNewAndHot(),
    ScreenFastLaugh(),
    ScreenSearh(),
    ScreenDownload(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return pages[index];
          },
        ),
      ),
      bottomNavigationBar: BottomNavWidget(),
    );
  }
}
