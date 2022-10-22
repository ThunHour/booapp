import 'package:book_management/BookList/RecommendedBook/RecommendedBookList.dart';
import 'package:book_management/HttpService.dart';
import 'package:book_management/Model/BookModel.dart';
import 'package:flutter/material.dart';

class FilterResult extends StatelessWidget {
  HttpService httpService = HttpService();

  late final List authorFilters;
  late final List genreFilters;
  FilterResult({required this.authorFilters, required this.genreFilters});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: httpService.getAllBooks(),
          builder: (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
            if (snapshot.hasData) {
              List<BookModel> books = snapshot.data!;
              // List<BookModel> filteredBookByAuthor = filter(books, authorFilters);
              List<BookModel> filteredBooks = new List.from(filterByGenre(books, genreFilters))..addAll(filterByAuthor(books, authorFilters));
              var seen = Set<String>();
              List<BookModel> uniqueBooks = filteredBooks.where((element) => seen.add(element.id.toString())).toList();
              return Container(
                // margin: const EdgeInsets.only(top: 20),
                height: 190 * uniqueBooks.length.toDouble(),
                child: RecommendedBookList(books: uniqueBooks,),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }

  List<BookModel> filterByAuthor(List<BookModel> books, List keywords) {
    List<BookModel> filteredBooks = [];

    for (int i = 0; i < books.length; i++) {
      for (int j = 0; j < keywords.length; j++) {
        if (books[i].author.toLowerCase().contains(keywords[j].toString().toLowerCase())) {
          filteredBooks.add(books[i]);
        }
      }
    }
    return filteredBooks;
  }

  List<BookModel> filterByGenre(List<BookModel> books, List keywords) {
    List<BookModel> filteredBooks = [];

    for (int i = 0; i < books.length; i++) {
      for (int j = 0; j < keywords.length; j++) {
        if (books[i].genre.toLowerCase().contains(keywords[j].toString().toLowerCase())) {
          filteredBooks.add(books[i]);
        }
      }
    }
    return filteredBooks;
  }

}