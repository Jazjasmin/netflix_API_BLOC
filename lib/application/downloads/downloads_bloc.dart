import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix_app/domain/downloads/i_download_repo.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';

import '../../domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadRepo _downloadRepo;
  DownloadsBloc(this._downloadRepo) : super(DownloadsState.initial()) {
    on<_GetDownloadsImages>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          downloadsFailureOrSuccessOption: none(),
        ),
      );
      final Either<MainFailure, List<Downloads>> downloadsOption =
          await _downloadRepo.getDownloadsImages();
      emit(
        downloadsOption.fold(
          (failure) => state.copyWith(
            isLoading: false,
            downloadsFailureOrSuccessOption: Some(
              Left(failure),
            ),
          ),
          (success) => state.copyWith(
            isLoading: false,
            downloads: success,
            downloadsFailureOrSuccessOption: Some(Right(success)),
          ),
        ),
      );
    });
  }
}
