import '../entities/book.dart';

abstract class BookRepository {
  Future<Book> findById(BookId id);
  Future<List<Book>> findAll();
  Future<void> save(Book book);
  Future<void> delete(BookId id);
}