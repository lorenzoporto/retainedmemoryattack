import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retainedmemoryattack/application/book_service.dart';
import 'package:retainedmemoryattack/domain/entities/book.dart';
import 'package:retainedmemoryattack/infrastructure/repositories/memory_book_repository.dart';
import 'package:retainedmemoryattack/presentation/pages/book_list_page.dart';

void main() {
  testWidgets('BookListPage shows books', (WidgetTester tester) async {

    final repository = InMemoryBookRepository();

    await repository.save(Book(
        id: BookId('1'),
        title: 'Clean Architecture',
        author: 'Robert C. Martin'
    ));

    final service = BookService(repository);

    await tester.pumpWidget(
      MaterialApp(
        home: BookListPage(bookService: service),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Clean Architecture'), findsOneWidget);
    expect(find.text('Robert C. Martin'), findsOneWidget);
  });
}