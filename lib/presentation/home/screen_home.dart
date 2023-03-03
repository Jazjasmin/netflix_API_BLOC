import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_app/application/Home/home_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/home/custom_button_widget.dart';
import 'package:netflix_app/presentation/home/number_title_card.dart';
import 'package:netflix_app/presentation/widgets/main_title_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

ValueNotifier<bool> scrolNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: scrolNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                // print(direction);
                if (direction == ScrollDirection.reverse) {
                  scrolNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrolNotifier.value = true;
                }
                return true;
              },
              //padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.hasError) {
                        return const Center(
                          child: Text(
                            'Error while getting data',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final _releasedPastYear =
                          state.pastYearMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      final _trending = state.trendingMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      final _tensDramas = state.tenseDramasMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();

                      final _southIndian = state.southIndianMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();
                      _southIndian.shuffle();

                      print(state.tenseDramasMovieList);
                      print(state.southIndianMovieList.length);

                      final top10TvShows = state.trendingTvList.map((t) {
                        return '$imageAppendUrl${t.posterPath}';
                      }).toList();
                      top10TvShows.shuffle();

                      return ListView(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 600,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(kMainImage),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const CustomeButtonWidget(
                                        icon: Icons.add,
                                        title: 'My List',
                                        iconSize: 30,
                                        textSize: 18,
                                      ),
                                      _PlayButton(),
                                      const CustomeButtonWidget(
                                        icon: Icons.info,
                                        title: 'Info',
                                        iconSize: 30,
                                        textSize: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          if (_releasedPastYear.length >= 10)
                            MainTitleCard(
                              title: 'Release in the past year',
                              posterList: _releasedPastYear.sublist(0, 10),
                            ),
                          height10,
                          if (_trending.length >= 10)
                            MainTitleCard(
                              title: 'Trending Now',
                              posterList: top10TvShows.sublist(0, 10),
                            ),
                          height10,
                          NumberTitleCard(
                            posterList: top10TvShows.sublist(0, 10),
                          ),
                          height10,
                          if (_tensDramas.length >= 10)
                            MainTitleCard(
                              title: 'Trends Dramas',
                              posterList: _tensDramas, //.sublist(0,10)
                            ),
                          height10,
                          if (_southIndian.length >= 10)
                            MainTitleCard(
                                title: 'South Indian Cinemas',
                                posterList: _southIndian.sublist(0, 10)),
                          height20,
                          height10,
                        ],
                      );
                    },
                  ),
                  scrolNotifier.value == true
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: double.infinity,
                          height: 90,
                          color: kblack.withOpacity(0.3),
                          child: Column(
                            children: [
                              Row(children: [
                                Image.network(
                                  "https://logodix.com/logo/38213.jpg",
                                  width: 60,
                                  height: 60,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: kwhite,
                                  size: 30,
                                ),
                                width5,
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                Width10,
                              ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'TV Shows',
                                    style: KHomeText,
                                  ),
                                  Text(
                                    'Movies',
                                    style: KHomeText,
                                  ),
                                  Text(
                                    'Categories',
                                    style: KHomeText,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : height10,
                ],
              ),
            );
          }),
    );
  }

  TextButton _PlayButton() {
    return TextButton.icon(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          kwhite,
        ),
      ),
      icon: const Icon(
        Icons.play_arrow,
        size: 25,
        color: kblack,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'play',
          style: TextStyle(
            fontSize: 18,
            color: kblack,
          ),
        ),
      ),
    );
  }
}
