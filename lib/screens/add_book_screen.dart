import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  final Function(Book) onAddBook;
  final Book? book;

  AddBookScreen({required this.onAddBook, this.book});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
      _descriptionController.text = widget.book!.description;
      _selectedImage =
          File(widget.book!.imagePath);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book != null ? 'Edit Book' : 'Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selectedImage != null
                    ? Image.file(
                  _selectedImage!,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 50, color: Colors.grey),
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Select Image'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedImage == null) {
                          return;
                        }

                        final newBook = Book(
                          id: widget.book?.id,
                          title: _titleController.text.isEmpty ? 'Unknown Title' : _titleController.text,
                          author: _authorController.text.isEmpty ? 'Unknown Author' : _authorController.text,
                          description: _descriptionController.text.isEmpty ? 'No description' : _descriptionController.text,
                          imagePath: _selectedImage?.path ?? '',
                        );

                        if (widget.book != null) {
                           widget.onAddBook(newBook);
                        } else {
                           widget.onAddBook(newBook);
                        }

                        Navigator.pop(context);
                      },
                      child: Text(widget.book != null ? 'Save Changes' : 'Add Book'),
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
