import 'package:flutter/material.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/search/title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/search/search_bloc.dart';


class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Movies & TV'),
        height10,
        Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1 / 1.4,
          shrinkWrap: true,
          children: List.generate(20, 
          (index) {
            final movie = state.searchResultList[index];
                return MainCard(imageUrl: movie.posterImageUrl);
          }),
        );
              }
            ))
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({Key? key,
  required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
