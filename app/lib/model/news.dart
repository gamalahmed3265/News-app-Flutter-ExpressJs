class NewModel {
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String category;
  final DateTime publishedAt;
  final String source;

  NewModel({
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.category,
    required this.publishedAt,
    required this.source,
  });

  factory NewModel.fromJson(Map<String, dynamic> json) {
    return NewModel(
      title: json['title'],
      description: json['description'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      publishedAt: DateTime.parse(json['publishedAt']),
      source: json['source'],
    );
  }
}
