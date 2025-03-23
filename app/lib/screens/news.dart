import 'package:app/providers/news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Newsscreen extends StatefulWidget {
  const Newsscreen({super.key});

  @override
  State<Newsscreen> createState() => _NewsscreenState();
}

class _NewsscreenState extends State<Newsscreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final newsProfider = Provider.of<NewsProviders>(context, listen: false);
      newsProfider.fetchCategories();
      newsProfider.fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Consumer<NewsProviders>(builder: (context, newsProvider, child) {
        return newsProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ))
            : ListView.builder(
                itemCount: newsProvider.news.length,
                itemBuilder: (context, index) {
                  final news = newsProvider.news[index];
                  return ListTile(
                    title: Text(news.title),
                    subtitle: Text(news.description),
                  );
                },
              );
      }),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.mic),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ));
  }
}
