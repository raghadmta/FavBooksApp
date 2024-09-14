import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book.dart';
import 'add_book_screen.dart';
import 'book_detail_screen.dart';
import '../database/db_helper.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final dbBooks = await dbHelper.getBooks();
    setState(() {
      books = dbBooks;
    });
  }

  Future<void> _addBook(Book book) async {
    if (book.title.isNotEmpty && book.author.isNotEmpty) {
      await dbHelper.insertBook(book);
      _loadBooks();
    } else {
      print("Missing book data");
    }
  }

  Future<void> _editBook(int index, Book editedBook) async {
    await dbHelper.updateBook(editedBook);
    _loadBooks();
  }

  Future<void> _deleteBook(int id) async {
    await dbHelper.deleteBook(id);
    _loadBooks();
  }
  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this book?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fave Books List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookScreen(
                    onAddBook: (newBook) {
                      _addBook(newBook);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailScreen(
                        book: book,
                        index: index,
                        onEditBook: (index, editedBook) =>
                            _editBook(index, editedBook),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 120,
                        child: book.imagePath.isNotEmpty &&
                                File(book.imagePath).existsSync()
                            ? Image.file(
                                File(book.imagePath),
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.image,
                                size: 50,
                                color:
                                    Colors.grey),
                      ),

                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              book.author,
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              book.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          final shouldDelete = await _showDeleteConfirmationDialog(context);
                          if (shouldDelete) {
                            _deleteBook(book.id!);
                          }
                        },
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
