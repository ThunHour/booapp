import 'dart:convert';

import 'package:book_management/Model/Author.dart';
import 'package:book_management/Model/BookModel.dart';
import 'package:book_management/Model/Genre.dart';
import 'package:http/http.dart';

class HttpService {
  final String allBookUrl = "http://54.255.235.62:9093/bookapi/book";
  final String allAuthorUrl = "http://54.255.235.62:9093/bookapi/author";
  final String allGenreUrl = "http://54.255.235.62:9093/bookapi/genre";
  List<BookModel> books = [];

  Future<List<BookModel>> getAllBooks() async {
    Response res = await get(Uri.parse(allBookUrl));

    if(res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      List<BookModel> books = [];
      for (int i = 0; i< obj.length; i++) {
        BookModel book = new BookModel(
            id: obj[i]['id'],
            title: obj[i]['title'],
            description: obj[i]['description'],
            genre: obj[i]['genre'],
            author: obj[i]['author'],
            imgUrl: obj[i]['imgUrl'],
            downloadUrl: obj[i]['downloadUrl']
        );
      books.add(book);
      }
      return books;
    } else {
      throw "Unable to get Book Data.";
    }
  }

  Future<List<String>> getAllBookTitles() async {
    Response res = await get(Uri.parse(allBookUrl));

    if(res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      List<String> books = [];
      for (int i = 0; i< obj.length; i++) {
        String book = obj[i]['title'];
        books.add(book);
      }
      return books;
    } else {
      throw "Unable to get Book Title.";
    }
  }

  Future<List<Author>> getAllAuthors() async {
    Response res = await get(Uri.parse(allAuthorUrl));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      List<Author> authors = [];
      for (int i = 0; i < obj.length; i++) {
        Author author = new Author(
          id: obj[i]['id'],
          name: obj[i]['name'],
          biography: obj[i]['biography'],
          imgUrl: obj[i]['imgUrl']
        );
        authors.add(author);
      }
      return authors;
    } else {
      throw "Unable to get Author Data.";
    }
  }

  Future<List<Genre>> getAllGenres() async {
    Response res = await get(Uri.parse(allGenreUrl));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      List<Genre> genres = [];
      for (int i = 0; i < obj.length; i++) {
        Genre genre = new Genre(
            id: obj[i]['id'],
            name: obj[i]['name'],
            description: obj[i]['description'],
            imgUrl: obj[i]['imgUrl']
        );
        genres.add(genre);
      }
      return genres;
    } else {
      throw "Unable to get Genre Data.";
    }
  }
}