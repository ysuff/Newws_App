import 'package:dartz/dartz.dart';
import 'package:news_app/features/news/data/models/news_source_model.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/news_article_entity.dart';
import '../../domain/entities/source_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';
import '../models/news_article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SourceEntity>>> getNewsSources() async {
    try {
      final List<SourceModel> sources = await remoteDataSource.getNewsSources();

      return Right(sources);
    } on NetworkFailure {
      return const Left(NetworkFailure('Network connection error.'));
    } on ServerFailure {
      return const Left(ServerFailure('Server error.'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NewsArticleEntity>>> getTopHeadlines() async {
    try {
      final List<NewsArticleModel> articles = await remoteDataSource
          .getTopHeadlines();
      return Right(articles);
    } on NetworkFailure {
      return const Left(NetworkFailure('Network connection error.'));
    } on ServerFailure {
      return const Left(ServerFailure('Server error.'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
