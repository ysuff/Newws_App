import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/core/constansts/app_constants.dart';
import 'package:news_app/features/news/data/models/news_article_model.dart';
import 'package:news_app/features/news/data/models/news_source_model.dart';
import '../../../../core/errors/failures.dart';

abstract class NewsRemoteDataSource {
  Future<List<SourceModel>> getNewsSources();
  Future<List<NewsArticleModel>> getTopHeadlines();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SourceModel>> getNewsSources() async {
    final String apiKey = AppConstants.newsApiKey;
    final String baseUrl = AppConstants.newsApiBaseUrl;
    final Uri uri = Uri.parse('$baseUrl/top-headlines/sources?apiKey=$apiKey');

    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> sourcesJson = jsonResponse['sources'];
        return sourcesJson
            .map((json) => SourceModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerFailure(
          'Failed to load news sources: ${response.statusCode}',
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkFailure('Network error: ${e.message}');
    } catch (e) {
      throw UnknownFailure('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<List<NewsArticleModel>> getTopHeadlines() async {
    final String apiKey = AppConstants.newsApiKey;
    final String baseUrl = AppConstants.newsApiBaseUrl;
    final Uri uri = Uri.parse(
      '$baseUrl/top-headlines?country=us&apiKey=$apiKey',
    );
    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> articlesJson = jsonResponse['articles'];
        return articlesJson
            .map(
              (json) => NewsArticleModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw ServerFailure(
          'Failed to load top headlines: ${response.statusCode}',
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkFailure('Network error: ${e.message}');
    } catch (e) {
      throw UnknownFailure('An unexpected error occurred: ${e.toString()}');
    }
  }
}
