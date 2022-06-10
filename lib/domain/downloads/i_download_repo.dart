import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';

import 'models/downloads.dart';

abstract class IDownloadRepo {
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages();
}
