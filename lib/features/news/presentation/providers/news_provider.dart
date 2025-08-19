import 'package:flutter/material.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/no_params.dart';
import '../../domain/entities/news_article_entity.dart';
import '../../domain/usecases/get_news_sources.dart';
import '../../domain/usecases/get_top_headlines.dart';

enum NewsState { initial, loading, loaded, error }

class NewsProvider with ChangeNotifier {
  final GetNewsSources getNewsSources;
  final GetTopHeadlines getTopHeadlines;

  NewsProvider({required this.getNewsSources, required this.getTopHeadlines});

  NewsState _newsState = NewsState.initial;
  NewsState get newsState => _newsState;

  List<NewsArticleEntity> _topHeadlines = [];
  List<NewsArticleEntity> get topHeadlines => _topHeadlines;

  String _newsErrorMessage = '';
  String get newsErrorMessage => _newsErrorMessage;

  Future<void> fetchTopHeadlines() async {
    _newsState = NewsState.loading;
    notifyListeners();

    final result = await getTopHeadlines(NoParams());

    result.fold(
      (failure) {
        _newsState = NewsState.error;
        _newsErrorMessage = _mapFailureToMessage(failure);
        notifyListeners();
      },
      (articles) {
        _newsState = NewsState.loaded;
        _topHeadlines = articles;
        notifyListeners();
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error: Please try again later.';
      case NetworkFailure:
        return 'Network connection error: Check your internet connection.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
