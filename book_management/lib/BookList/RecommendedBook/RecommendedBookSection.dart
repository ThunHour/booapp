import 'package:book_management/BookList/PopularBook/PopularBookSection.dart';
import 'package:book_management/BookList/RecommendedBook/RecommendedBookList.dart';
import 'package:book_management/HttpService.dart';
import 'package:book_management/Model/BookModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../BookSetting/provider/theme_provider.dart';

class RecommendedBookSection extends StatefulWidget {
  @override
  State<RecommendedBookSection> createState() => _RecommendedBookSectionState();
}

class _RecommendedBookSectionState extends State<RecommendedBookSection> {
  HttpService httpService = HttpService();
  ThemeProvider themeProvider = ThemeProvider();
  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: Consumer<ThemeProvider>(builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(child: PopularBookSection()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Text(
                  "Recommended Books",
                  style: GoogleFonts.rozhaOne(
                    color: themeProvider.darkTheme == true
                        ? Colors.white
                        : HexColor("#B6442A"),
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder(
                  future: httpService.getAllBooks(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<BookModel>> snapshot) {
                    if (snapshot.hasData) {
                      List<BookModel> books = snapshot.data!;
                      return Container(
                        height: 190 * books.length.toDouble(),
                        child: RecommendedBookList(
                          books: books,
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              // Container(
              //   height: 190 * 20,
              //     child: RecommendedBookList(),
              // ),
            ],
          );
        }));
  }
}
