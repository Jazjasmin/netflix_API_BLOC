import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/search/model/search_respo/search_respo.dart';
import 'package:dartz/dartz.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchRespo>> searchMovies({
    required String movieQuery,
  });
}
