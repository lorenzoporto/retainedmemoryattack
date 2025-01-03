
class Book {
  final BookId id;
  final String title;
  final String author;
  final bool isAvailable;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.isAvailable = true,
  });
}

class BookId {
  final String value;
  BookId(this.value);
}