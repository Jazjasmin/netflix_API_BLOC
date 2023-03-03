import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new/hot_and_new/hot_and_new.dart';
import 'package:netflix_app/domain/hot_and_new/hot_and_new_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    
    // get event homescreen data
    on<GetHomeScreenData>((event, emit) async {
      log('GETTYING HOME SCREEN DATA');
      emit(state.copyWith(isLoading: true, hasError: false));

      final movieResult = await _homeService.getHotAndNewMovieData();
      final tvResult = await _homeService.getHotAndNewTvData();

      //transform data
       final _state1 = movieResult.fold(
        (MainFailure failure) {
          return  HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          final pastYear = resp.results;
          final trending = resp.results;
          final dramas = resp.results;
          final southindian = resp.results;
          trending.shuffle();
          pastYear.shuffle();
          dramas.shuffle();
          southindian.shuffle();
          return HomeState(
             stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear,
            trendingMovieList: trending,
            tenseDramasMovieList: dramas,
            southIndianMovieList: southindian,
            trendingTvList: state.trendingTvList,
            isLoading: true,
            hasError: false,
          );
        },
      );

      emit(_state1);

       final _state2 = tvResult.fold(
        (MainFailure failure) {
          return  HomeState(
             stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          final top10 = resp.results;

          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: state.pastYearMovieList,
            trendingMovieList: state.trendingMovieList,
            tenseDramasMovieList: state.tenseDramasMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: top10,
            isLoading: false,
            hasError: false,
          );
        },
      );

      //send to ui
    emit(_state2);

    });
  }
}
