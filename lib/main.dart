import 'package:flutter/material.dart';

import 'application/book_service.dart';
import 'domain/entities/book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookListPage(bookService: null),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookListPage extends StatelessWidget {
  final BookService bookService;

  const BookListPage({required this.bookService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      //temporary test-> future: bookService.findAll(),
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
        return CircularProgressIndicator();
      },
    );
  }
}
