import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';

class VideoWidget extends StatelessWidget {
  final String url;
  const VideoWidget({
    Key? key, required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Image.network(url,
            //"https://www.themoviedb.org/t/p/w300_and_h450_bestv2/mC66fsuzlYHSoZwb6y6emSCaRv5.jpg",
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext _, Widget child, ImageChunkEvent? progress) {
              if(progress == null){
                return child;
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },
            errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
              return const Center(child: Icon(Icons.wifi,color: Colors.white,));
            },
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
