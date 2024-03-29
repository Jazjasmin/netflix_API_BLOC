import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new/hot_and_new/hot_and_new.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewMovieData();
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewTvData();
}