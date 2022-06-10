import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/home/custom_button_widget.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';

class EveryOneWatchingWidget extends StatelessWidget {
  const EveryOneWatchingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height20,
        const Text(
          'Friends',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        height10,
        const Text(
          'This hit sitcom follows the merry misadventure of six 20-somthing pals as they navigate the pitfalls of work, life and love in 1900s manhattan',
          style: TextStyle(
            color: kGrey,
          ),
        ),
        height50,
        const VideoWidget(),
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
