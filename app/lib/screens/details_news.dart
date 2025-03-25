import 'package:app/model/news.dart';
import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewModel news;
  const NewsDetailsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                      label: Text(
                    news.category,
                    style: TextStyle(color: Colors.purple[800]),
                  )),
                  Text("${news.createdAt.toLocal()}",
                      style: TextStyle(color: Colors.grey, fontSize: 12))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                news.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                news.source.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  news.imageUrl ?? "",
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                news.content.toString(),
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
