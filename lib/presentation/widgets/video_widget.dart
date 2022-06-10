import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Image.network(
            "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/mC66fsuzlYHSoZwb6y6emSCaRv5.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: kblack.withOpacity(0.5),
            radius: 25,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_off,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
