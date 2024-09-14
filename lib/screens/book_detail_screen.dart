import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book.dart';
import 'add_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final int index;
  final Function(int, Book) onEditBook;

  BookDetailScreen({required this.book, required this.index, required this.onEditBook});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookScreen(
                    book: book,
                    onAddBook: (editedBook) {
                      onEditBook(index, editedBook);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: book.imagePath != null
                  ? Image.file(
                File(book.imagePath),
                width: 150,
                height: 220,
                fit: BoxFit.cover,
              )
                  : Text('No image available'),
            ),
            SizedBox(height: 20),
            Text(
              book.title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'by ${book.author}',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
