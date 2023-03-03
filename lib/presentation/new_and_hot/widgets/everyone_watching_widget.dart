import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/home/custom_button_widget.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';

class EveryOneWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  
  const EveryOneWatchingWidget({
    Key? key, required this.posterPath, required this.movieName, required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height20,
         Text(
          movieName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        height10,
         Text(
          description,
          style: const TextStyle(
            color: kGrey,
          ),
        ),
        height50,
         VideoWidget(url: posterPath,),
        height10,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustomeButtonWidget(
              icon: Icons.share,
              title: 'share',
              iconSize: 25,
              textSize: 12,
            ),
            Width10,
            CustomeButtonWidget(
              icon: Icons.add,
              title: "add",
              iconSize: 25,
              textSize: 12,
            ),
            Width10,
            CustomeButtonWidget(
              icon: Icons.play_arrow_rounded,
              title: 'Play',
              iconSize: 25,
              textSize: 12,
            ),
            width5,
          ],
        )
      ],
    );
  }
}
