import 'dart:convert';

class NewModel {
  final String title;
  final String? description; // Nullable
  final String? content; // Nullable
  final String? imageUrl; // Nullable
  final String category;
  final String? source; // Nullable
  final DateTime createdAt;

  NewModel({
    required this.title,
    this.description,
    this.content,
    this.imageUrl,
    required this.category,
    this.source,
    required this.createdAt,
  });

  // Convert JSON to NewModel object
  factory NewModel.fromJson(Map<String, dynamic> json) {
    return NewModel(
      title: json['title'] ?? 'No Title', // Handle null title with default
      description: json['description'] as String?, // Allow null
      content: json['content'] as String?, // Allow null
      imageUrl: json['imageUrl'] as String?, // Allow null
      category: json['category'] ?? '', // Default category
      source: json['source'] ?? "" as String?, // Allow null
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.now(), // Default to now if null
    );
  }

  // Convert NewModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'imageUrl': imageUrl,
      'category': category,
      'source': source,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert a list of JSON objects to a list of NewModel objects
  static List<NewModel> listFromJson(String jsonString) {
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => NewModel.fromJson(item)).toList();
  }
}
