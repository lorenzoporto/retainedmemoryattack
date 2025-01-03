import 'package:flutter/material.dart';
import 'package:retainedmemoryattack/presentation/pages/book_list_page.dart';

import 'application/book_service.dart';
import 'domain/entities/book.dart';
import 'infrastructure/repositories/memory_book_repository.dart';

void main() {
  final bookRepository = InMemoryBookRepository();
  final bookService = BookService(bookRepository);

  bookRepository.save(Book(
        id: BookId('1'),
        title: 'Clean Architecture',
        author: 'Robert C. Martin'
    ));
  runApp(MyApp(bookService: bookService));
}

class MyApp extends StatelessWidget {
  final BookService bookService;

  const MyApp({super.key, required this.bookService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(bookService: bookService));
  }
}

class MyHomePage extends StatefulWidget {
  final BookService bookService;

  const MyHomePage({super.key, required this.bookService});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookListPage(bookService: widget.bookService),
    );
  }
}


