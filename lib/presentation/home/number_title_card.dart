import 'package:flutter/material.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/home/number_card.dart';

import '../widgets/main_title.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: 'Top 10 Tv Show In India Today'),
        height10,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(10, (index) {
              return NumberCard(
                index: index,
              );
            }),
          ),
        )
      ],
    );
  }
}
