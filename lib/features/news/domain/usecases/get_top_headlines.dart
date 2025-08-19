import 'package:dartz/dartz.dart';
import 'package:news_app/core/usecases/no_params.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/news_article_entity.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines implements UseCase<List<NewsArticleEntity>, NoParams> {
  final NewsRepository repository;

  GetTopHeadlines({required this.repository});

  @override
  Future<Either<Failure, List<NewsArticleEntity>>> call(NoParams params) async {
    return await repository.getTopHeadlines();
  }
}
