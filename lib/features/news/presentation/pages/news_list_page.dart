import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/pages/news_detail_page.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchTopHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest news')),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          if (provider.newsState == NewsState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.newsState == NewsState.error) {
            return Center(child: Text(provider.newsErrorMessage));
          } else if (provider.newsState == NewsState.loaded &&
              provider.topHeadlines.isNotEmpty) {
            return ListView.builder(
              itemCount: provider.topHeadlines.length,
              itemBuilder: (context, index) {
                final article = provider.topHeadlines.elementAt(index);
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailPage(article: article),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (article.urlToImage != null)
                          Image.network(
                            article.urlToImage!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text('Image Failed to Load'),
                                ),
                              );
                            },
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            article.description ?? 'No Description',
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article.source.name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No news found.'));
          }
        },
      ),
    );
  }
}
