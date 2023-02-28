import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/downloads/i_download_repo.dart';

import '../../domain/downloads/models/downloads.dart';

part 'fastlaugh_event.dart';
part 'fastlaugh_state.dart';
part 'fastlaugh_bloc.freezed.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
];

ValueNotifier<Set<int>> likedVideoIdsNotifier = ValueNotifier({});

@injectable
class FastlaughBloc extends Bloc<FastlaughEvent, FastlaughState> {
  FastlaughBloc(
    IDownloadRepo _downloadService,
  ) : super(FastlaughState.initial()) {

    on<Initialize>((event, emit) async {
      //sending loading to UI
      emit( const FastlaughState(
        videoList: [], 
        isLoading: true, 
        isError: false,
        
        ));
      // get trending movies
      final _result = await _downloadService.getDownloadsImages();
      final _state = _result.fold((f) {
        return  FastlaughState(
          videoList: [], 
          isLoading: false, 
          isError: true,
               
          );
      }, (resp) {
          return FastlaughState(
          videoList: resp, 
          isLoading: false, 
          isError: false,
        
          );
      });
      //send to ui
      emit(_state);
    });

    on<LikeVideo>((event, emit) {
      likedVideoIdsNotifier.value.add(event.id);
          likedVideoIdsNotifier.notifyListeners();
    });

    on<UnlikeVideo>((event, emit) {
     likedVideoIdsNotifier.value.remove(event.id);
           likedVideoIdsNotifier.notifyListeners();
    });
  }
}
