import 'dart:developer';

import 'package:netflix_app/domain/search/model/search_respo/search_respo.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/search/search_service.dart';

import '../../domain/core/api_end_points.dart';

@LazySingleton(as: SearchService)
class SerachImpl implements SearchService{
  @override
  Future<Either<MainFailure, SearchRespo>> searchMovies({
        required String movieQuery}) async {
     try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.search,
          queryParameters:{ 
            'query': movieQuery,
          },
          );
         // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SearchRespo.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } 
    on DioError catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
    catch(e){
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

}
  
  
  