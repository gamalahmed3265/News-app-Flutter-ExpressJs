import 'package:app/model/news.dart';
import 'package:app/providers/news.dart';
import 'package:app/screens/details_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Newsscreen extends StatefulWidget {
  const Newsscreen({super.key});

  @override
  State<Newsscreen> createState() => _NewsscreenState();
}

class _NewsscreenState extends State<Newsscreen> {
  final controller = ScrollController();

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
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                controller: controller,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryList(newsProvider),
                      newsProvider.news.isEmpty
                          ? _buildWidgetNotFound()
                          : _buildCardNews(newsProvider.news.first),
                      SizedBox(
                        height: 30,
                      ),
                      _buildSectionsWithAction("Around The world", "see more",
                          () {
                        print("object");
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      _buildHorizontalNewList(newsProvider),
                      SizedBox(
                        height: 30,
                      ),
                      _buildSectionsWithAction("Around The world", "see more",
                          () {
                        print("object");
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      newsProvider.news.isEmpty
                          ? _buildWidgetNotFound()
                          : _buildListBuild(newsProvider.news, controller),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Center _buildWidgetNotFound() {
    return Center(
      child: Text(
        'No news found',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  _buildSectionsWithAction(
      String title, String? acionText, VoidCallback? onActionTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        if (acionText != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              acionText,
              style: TextStyle(color: Colors.blue),
            ),
          )
      ],
    );
  }

  _buildCardNews(NewModel news) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.purple[100], borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple[800]),
          )
        ],
      ),
    );
  }

  _buildCategoryList(NewsProviders newsProvider) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsProvider.categories.length,
        itemBuilder: (context, index) {
          final categoryItem = newsProvider.categories[index];
          final isSelected = categoryItem.name == newsProvider.selectedCategory;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => newsProvider.fetchNews(
                  category:
                      categoryItem.name == "All" ? null : categoryItem.name),
              child: Chip(
                  backgroundColor:
                      isSelected ? Colors.purple : Colors.grey[200],
                  label: Text(
                    categoryItem.name,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black),
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListBuild(List<NewModel> news, ScrollController controller) {
    return GridView.builder(
      controller: controller,
      itemCount: news.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 10, // Space between columns
        mainAxisSpacing: 10, // Space between rows
        childAspectRatio: 0.9, // Adjust for better fit
      ),
      itemBuilder: (context, index) {
        return NewsCard(news: news[index]);
      },
    );
  }

  _buildHorizontalNewList(NewsProviders newsprovider) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsprovider.news.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    NewsDetailsScreen(news: newsprovider.news[index])));
          },
          child: Container(
            width: 150,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage(newsprovider.news[index].imageUrl ?? ""))),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    newsprovider.news[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    newsprovider.news[index].category,
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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

class NewsCard extends StatelessWidget {
  final NewModel news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // News Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              news.imageUrl ?? "https://via.placeholder.com/150",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // News Title
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),

                // News Description
                Text(
                  news.description ?? "No description available",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),

                // News Category & Source
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(
                        news.category.toUpperCase(),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                    Text(
                      news.source ?? "Unknown Source",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
