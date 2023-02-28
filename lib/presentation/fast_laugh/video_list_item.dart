import 'package:flutter/material.dart';
import 'package:netflix_app/application/fast_laugh/fastlaugh_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'image_previews.dart';


class VideoListItemInheritedWidget extends InheritedWidget{
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    Key? key,
   required this.widget, required this.movieData,
   }): super(key: key, child: widget);
   
  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }
  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
  }
class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath = VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];              

    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl, onStateChanged: (bool){},
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //left side
                CircleAvatar(
                  backgroundColor: kblack.withOpacity(0.5),
                  radius: 25,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.volume_mute,
                    ),
                  ),
                ),

                //right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null ? null :
                        NetworkImage(
                          '$imageAppendUrl$posterPath'
                        ),
                      ),
                             ),
                   ValueListenableBuilder(
                     valueListenable: likedVideoIdsNotifier,
                     builder: (BuildContext context, Set<int> newLikedListIds , Widget? _) {
                       final _index = index;
                       if(newLikedListIds.contains(_index))
                       {
                         return GestureDetector(
                           onTap: () {
                            // BlocProvider.of<FastlaughBloc>(context)
                             //.add(UnlikeVideo(id: _index));
                             likedVideoIdsNotifier.value.remove(_index);
                              likedVideoIdsNotifier.notifyListeners();
                           },
                             child: const VideoActionsWidget(
                               icon: Icons.favorite_outline,
                                title: 'Liked'
                            ),
                           
                           
                         );                       
                       }
                       return GestureDetector(
                             onTap: (){
                               //BlocProvider.of<FastlaughBloc>(context)
                                   //.add(LikeVideo(id: _index));
                                   likedVideoIdsNotifier.value.add(_index);
                                    likedVideoIdsNotifier.notifyListeners();
                             },
                             child: const VideoActionsWidget(
                            icon: Icons.emoji_emotions, title: 'LOL',
                        ),
                       );
                     }
                   ),
                   VideoActionsWidget(icon: Icons.add, title: 'My List'),
                   GestureDetector(
                     onTap: (){
                       final movieName = VideoListItemInheritedWidget.of(context)
                       ?.movieData
                       .posterPath;
                       if(movieName != null) {
                         Share.share(movieName);
                       }
                     },
                     child: VideoActionsWidget(icon: Icons.share, title: 'Share')),
                   VideoActionsWidget(icon: Icons.play_arrow, title: 'Play'),
                  ],
                )
              ]
            ),
            ),
          ),
       ], 
      
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionsWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: kwhite,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              color: kwhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}


class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
   FastLaughVideoPlayer({ Key? key,
  required this.videoUrl,
  required this.onStateChanged,
   }) : super(key: key);

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {

    late VideoPlayerController _videoPlayerController;
    @override
    void initState(){
      _videoPlayerController = VideoPlayerController.network(
        widget.videoUrl);
        _videoPlayerController.initialize().then((value) {
           setState(() {
          _videoPlayerController.play();
        });
        });
        super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
      ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
                 child: VideoPlayer(_videoPlayerController),
              )
      : const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),      
    );
  }
  @override
  void dispose() {
      _videoPlayerController.dispose();
      super.dispose();
  }
}