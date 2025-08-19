import 'package:dartz/dartz.dart';
import 'package:news_app/core/usecases/no_params.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/source_entity.dart';
import '../repositories/news_repository.dart';

class GetNewsSources implements UseCase<List<SourceEntity>, NoParams> {
  final NewsRepository repository;

  GetNewsSources({required this.repository});

  @override
  Future<Either<Failure, List<SourceEntity>>> call(NoParams params) async {
    return await repository.getNewsSources();
  }
}
