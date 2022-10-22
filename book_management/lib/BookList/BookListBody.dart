import 'package:book_management/BookList/PopularBook/PopularBookSection.dart';
import 'package:book_management/BookList/RecentBook/RecentBookSection.dart';
import 'package:book_management/BookList/RecentBook/RecentBookService.dart';
import 'package:book_management/BookList/RecommendedBook/RecommendedBookSection.dart';
import 'package:flutter/material.dart';

class BookListBody extends StatelessWidget {
  RecentBookService recentService = RecentBookService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          RecentBookSection(),
          // PopularBookSection(),
          // recentService.getRecentLength() > 0 ? RecentBookSection() : PopularBookSection(),
          RecommendedBookSection(),
        ],
      ),
    );
  }
}