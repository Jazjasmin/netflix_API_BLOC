import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new/hot_and_new/hot_and_new.dart';
import 'package:netflix_app/domain/hot_and_new/hot_and_new_service.dart';
import 'package:injectable/injectable.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {

  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      //send loading to UI
      emit(const HotAndNewState(
        isLoading: true,
        hasError: false,
        comingSoonList: [],
        everyOneIsWatchingList: [],
      ));

      // get daa from remote
      final _result = await _hotAndNewService.getHotAndNewMovieData();

      //data to state
      final newState = _result.fold((MainFailure failure) {
        return const HotAndNewState(
            isLoading: false,
            hasError: true,
            comingSoonList: [],
            everyOneIsWatchingList: []);
      }, (HotAndNewResp resp) {
        return HotAndNewState(
            isLoading: false,
            hasError: false,
            comingSoonList: resp.results,
            everyOneIsWatchingList: state.everyOneIsWatchingList);
      });
      emit(newState);
    });

    on<LoadDataInEveryoneIsWatching>((event, emit) async {
      //send loading to UI
      emit(const HotAndNewState(
        isLoading: true,
        hasError: false,
        comingSoonList: [],
        everyOneIsWatchingList: [],
      ));

      // get daa from remote
      final _result = await _hotAndNewService.getHotAndNewTvData();

      //data to state
      final newState = _result.fold((MainFailure failure) {
        return const HotAndNewState(
            isLoading: false,
            hasError: true,
            comingSoonList: [],
            everyOneIsWatchingList: []);
      }, (HotAndNewResp resp) {
        return HotAndNewState(
            isLoading: false,
            hasError: false,
            comingSoonList: state.comingSoonList,
            everyOneIsWatchingList: resp.results);
      });
      emit(newState);
    });
  }
}
