import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/application/search/search_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/domain/core/debounce/debounce.dart';
import 'package:netflix_app/presentation/search/search_idle.dart';
import 'package:netflix_app/presentation/search/search_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSearh extends StatelessWidget {
  ScreenSearh({Key? key}) : super(key: key);

  final _debouncer = Debouncer(milliseconds: 1 * 1000);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CupertinoSearchTextField(
              backgroundColor: kGrey.withOpacity(0.4),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: kGrey,
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark_circle_fill,
                color: kGrey,
              ),
              style: const TextStyle(
                color: kwhite,
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                _debouncer.run(() {
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchMovie(movieQuery: value));
                });
              },
            ),
            height10,
            Expanded(child:
                BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              if (state.searchResultList.isEmpty) {
                return const SearchIdle();
              } else {
                return const SearchResult();
              }
            })),
          ],
        ),
      )),
    );
  }
}
