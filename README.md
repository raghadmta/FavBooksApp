# 📚 Flutter BookList App


A Flutter application to manage a personal list of favorite books using CRUD operations. The app allows users to add, edit, view, and delete books, along with images for each book, and stores the data using SQLite for persistent storage.

## Features
- Add new books with title, author, description, and a cover image.
- View the details of each book, including a full description and cover image.
- Edit existing book information.
- Delete books with confirmation.
- All data is persisted using SQLite.

## Screenshots

### Book List Screen
The main screen displays a list of books with their cover images, titles, and short descriptions.
<p align="center">
  <img src="https://github.com/user-attachments/assets/eae4088a-bd55-4559-a007-a38ac629d878" alt="Book List Screen" width="300" />
</p>


### Add/Edit Book Screen
Users can add or edit a book, filling out the title, author, description, and choosing a cover image from their device.

#### Add a Book
<p align="center">
  <img src="https://github.com/user-attachments/assets/e5210680-8ae4-4743-9231-470c81e22c2b" alt="Book List Screen" width="150" />
  <img src="https://github.com/user-attachments/assets/9e3560ef-413f-4ca3-82d7-6faf7ca63976" alt="Add Book Screen" width="150" />
    <img src="https://github.com/user-attachments/assets/99deb3a7-4e94-48c8-b49b-b4e62e28988b" alt="Book List Screen" width="150" />
</p>

#### Edit a Book
<p align="center">
  <img src="https://github.com/user-attachments/assets/70055b9e-c3d1-42b7-92e8-3bcb323a8846" alt="Add Book Screen" width="150" />
    <img src="https://github.com/user-attachments/assets/aa1d02a1-fb10-49f2-8965-9d524f010b2d" alt="Add Book Screen" width="150" />
    <img src="https://github.com/user-attachments/assets/7679137a-c959-4418-a06c-f6a44c55386e" alt="Add Book Screen" width="150" />
</p>

### Book Detail Screen
Detailed view of a selected book with options to edit.

<p align="center">
  <img src="https://github.com/user-attachments/assets/49dcdcc3-1ff5-4a3e-9dc9-bd9e2e0f8d5f" alt="Book List Screen" width="300" />
</p>

### Delete A Book Screen
Confirmation dialog before deleting a book,
<p align="center">
  <img src="https://github.com/user-attachments/assets/1f53d6c6-ccce-4ce0-af1b-a4ea8b5895b1" alt="Book List Screen" width="150" />
    <img src="https://github.com/user-attachments/assets/f2e148e4-b1c2-411e-9719-ec1e8e10c9fe" alt="Book List Screen" width="150" />   
  <img src="https://github.com/user-attachments/assets/7e90e55a-a588-42ed-a935-1279d968b149" alt="Book List Screen" width="150" />
</p>


### Folder Structure

```

├── lib/
│   ├── models/
│   │   └── book.dart           # Book model
│   ├── database/
│   │   └── db_helper.dart      # Database helper for SQLite
│   ├── screens/
│   │   ├── book_list_screen.dart  # Displays the list of books
│   │   ├── add_book_screen.dart   # Form to add/edit a book
│   │   └── book_detail_screen.dart  # Detailed view of a book
│   └── main.dart               # Main entry point of the app
└── 
```

### Key Dependencies

- **[sqflite](https://pub.dev/packages/sqflite):** SQLite plugin to handle local database storage.
- **[path_provider](https://pub.dev/packages/path_provider):** To access local storage paths.
- **[image_picker](https://pub.dev/packages/image_picker):** For selecting images from the device's gallery.
