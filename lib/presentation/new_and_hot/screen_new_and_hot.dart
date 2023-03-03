import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_app/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/commingsoon_widgets.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyone_watching_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              'New & Hot',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: kwhite,
                size: 30,
              ),
              width5,
              Container(
                width: 30,
                height: 20,
                color: Colors.blue,
              ),
              width5,
            ],
            bottom: TabBar(
                labelColor: kblack,
                unselectedLabelColor: kwhite,
                isScrollable: true,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                    color: kwhite, borderRadius: BorderRadius.circular(20)),
                tabs: const [
                  Tab(
                    text: '🍿 Coming Soon',
                  ),
                  Tab(
                    text: "👀 Everyone's Watching",
                  )
                ]),
          ),
        ),
        body: const TabBarView(children: [
          ComingSoonList(
            key: Key('coming soon'),
          ),
          EveryoneIsWatchingList(
            key: Key('everyone is watching'),
          )
        ]),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(onRefresh: () async {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    }, child:
        BlocBuilder<HotAndNewBloc, HotAndNewState>(builder: ((context, state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      } else if (state.hasError) {
        return const Center(
          child: Text("Error while loading coming soon list"),
        );
      } else if (state.comingSoonList.isEmpty) {
        return const Center(
          child: Text("Coming soon list"),
        );
      } else {
        return ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: state.comingSoonList.length,
            itemBuilder: (BuildContext context, index) {
              final movie = state.comingSoonList[index];
              if (movie.id == null) {
                return const SizedBox();
              }
              log(movie.releaseDate.toString());
              log(movie.originalTitle.toString());
              String month = '';
              String date = '';
              try {
                final _date = DateTime.tryParse(movie.releaseDate!);
                final formatDate = DateFormat.yMMMMd('en_US').format(_date!);
                month =
                    formatDate.split(' ').first.substring(0, 3).toUpperCase();
                date = movie.releaseDate!.split('-')[1];
              } catch (_) {
                month = '';
                date = '';
              }

              return ComingSoonWidget(
                  id: movie.id.toString(),
                  month: month,
                  day: date,
                  posterPath: '$imageAppendUrl${movie.posterPath}',
                  movieName: movie.originalTitle ?? 'No title',
                  description: movie.overview ?? 'No description');
            });
      }
    })));
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });

    return RefreshIndicator(
      onRefresh: (() async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryoneIsWatching());
      }),
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
          builder: ((context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (state.hasError) {
          return const Center(
            child: Text("Error while loading Everyone Watching  list"),
          );
        } else if (state.everyOneIsWatchingList.isEmpty) {
          return const Center(
            child: Text("Everyone Watching list"),
          );
        } else {
          return ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              itemCount: state.everyOneIsWatchingList.length,
              itemBuilder: (BuildContext context, index) {
                final tv = state.everyOneIsWatchingList[index];
                if (tv.id == null) {
                  return const SizedBox();
                }
                print(tv.releaseDate);
                print(tv.originalName);
                String month = '';
                String date = '';

                try {
                  final _date = DateTime.tryParse(tv.releaseDate!);
                  final formatDate = DateFormat.yMMMMd('en_US').format(_date!);
                  month =
                      formatDate.split(' ').first.substring(0, 3).toUpperCase();
                  ;
                  date = tv.releaseDate!.split('_')[1];
                } catch (_) {
                  month = '';
                }

                return EveryOneWatchingWidget(
                    posterPath: '$imageAppendUrl${tv.posterPath}',
                    movieName: tv.originalName ?? 'No title',
                    description: tv.overview ?? 'No description');
              });
        }
      })),
    );
  }
}
