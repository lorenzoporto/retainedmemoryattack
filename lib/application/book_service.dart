import '../domain/entities/book.dart';
import '../domain/repositories/book_repository.dart';

class BookService {
  final BookRepository _repository;

  BookService(this._repository);

  Future<List<Book>> findAll() async {
    return await _repository.findAll();
  }

  Future<Book> borrowBook(BookId id) async {
    final book = await _repository.findById(id);
    if (!book.isAvailable) {
      throw BookNotAvailableException();
    }
    final updatedBook = Book(
      id: book.id,
      title: book.title,
      author: book.author,
      isAvailable: false
    );
    await _repository.save(updatedBook);
    return updatedBook;
  }
}

class BookNotAvailableException implements Exception {}
