import 'package:flutter_test/flutter_test.dart';
import 'package:retainedmemoryattack/application/book_service.dart';
import 'package:retainedmemoryattack/domain/entities/book.dart';
import 'package:retainedmemoryattack/infrastructure/repositories/memory_book_repository.dart';

void main() {
  late BookService bookService;
  late InMemoryBookRepository repository;

  setUp(() {
    repository = InMemoryBookRepository();
    bookService = BookService(repository);
  });

  group('BookService', () {
    test('should borrow available book', () async {
      final book = Book(
        id: BookId('1'),
        title: 'Clean Architecture',
        author: 'Robert C. Martin',
        isAvailable: true
      );
      await repository.save(book);
      final borrowedBook = await bookService.borrowBook(BookId('1'));
      expect(borrowedBook.isAvailable, false);
    });

    test('should throw exception when borrowing unavailable book', () async {
      final book = Book(
        id: BookId('1'),
        title: 'Clean Architecture',
        author: 'Robert C. Martin',
        isAvailable: false
      );
      await repository.save(book);
      expect(
        () => bookService.borrowBook(BookId('1')),
        throwsA(isA<BookNotAvailableException>())
      );
    });
  });
}