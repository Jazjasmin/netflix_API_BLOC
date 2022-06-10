import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://www.themoviedb.org/t/p/w220_and_h330_face/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg",
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 13,
          bottom: -30,
          child: BorderedText(
            strokeWidth: 10.0,
            strokeColor: kwhite,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                fontSize: 140,
                color: kblack,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                decorationColor: kblack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
