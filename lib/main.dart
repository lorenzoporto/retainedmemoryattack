import 'package:flutter/material.dart';

import 'application/book_service.dart';
import 'domain/entities/book.dart';
import 'infrastructure/repositories/memory_book_repository.dart';

void main() {
  final bookRepository = InMemoryBookRepository();
  final bookService = BookService(bookRepository);
  bookRepository.save(
      Book(id: BookId('1'), title: 'Clean Code', author: 'Robert C. Martin'));
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

class BookListPage extends StatelessWidget {
  final BookService bookService;

  const BookListPage({super.key, required this.bookService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: bookService.findAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final book = snapshot.data![index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                trailing: Text(book.isAvailable ? 'Available' : 'Borrowed'),
              );
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
