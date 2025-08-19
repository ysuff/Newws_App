import 'package:dartz/dartz.dart';
import 'package:news_app/features/news/domain/entities/news_article_entity.dart';
import '../../../../core/errors/failures.dart';
import '../entities/source_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<SourceEntity>>> getNewsSources();
  Future<Either<Failure, List<NewsArticleEntity>>> getTopHeadlines();
}
