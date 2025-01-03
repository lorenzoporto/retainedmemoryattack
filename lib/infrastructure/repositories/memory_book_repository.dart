import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';

class InMemoryBookRepository implements BookRepository {
  final Map<String, Book> _books = {};

  @override
  Future<Book> findById(BookId id) async {
    final book = _books[id.value];
    if (book == null) throw BookNotFoundException();
    return book;
  }

  @override
  Future<List<Book>> findAll() async {
    return _books.values.toList();
  }

  @override
  Future<void> save(Book book) async {
    _books[book.id.value] = book;
  }

  @override
  Future<void> delete(BookId id) async {
    _books.remove(id.value);
  }
}

class BookNotFoundException implements Exception {}
