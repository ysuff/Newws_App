import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'features/news/data/datasources/news_remote_datasource.dart';
import 'features/news/data/repositories/news_repository_impl.dart';
import 'features/news/domain/repositories/news_repository.dart';
import 'features/news/domain/usecases/get_news_sources.dart';
import 'features/news/domain/usecases/get_top_headlines.dart';
import 'features/news/presentation/pages/news_list_page.dart';
import 'features/news/presentation/providers/news_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(create: (_) => http.Client()),
        Provider<NewsRemoteDataSource>(
          create: (context) =>
              NewsRemoteDataSourceImpl(client: context.read<http.Client>()),
        ),
        Provider<NewsRepository>(
          create: (context) => NewsRepositoryImpl(
            remoteDataSource: context.read<NewsRemoteDataSource>(),
          ),
        ),
        Provider<GetNewsSources>(
          create: (context) =>
              GetNewsSources(repository: context.read<NewsRepository>()),
        ),
        Provider<GetTopHeadlines>(
          create: (context) =>
              GetTopHeadlines(repository: context.read<NewsRepository>()),
        ),
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(
            getNewsSources: context.read<GetNewsSources>(),
            getTopHeadlines: context.read<GetTopHeadlines>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const NewsListPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
