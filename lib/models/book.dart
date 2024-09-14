class Book {
  int? id;
  final String title;
  final String author;
  final String description;
  final String imagePath;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'imagePath': imagePath,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }
}