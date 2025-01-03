import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../application/book_service.dart';
import '../../domain/entities/book.dart';

class BookListPage extends StatelessWidget {
  final BookService bookService;

  const BookListPage({super.key, required this.bookService});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<Book>>(
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}