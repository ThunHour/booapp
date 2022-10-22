import 'package:book_management/BookList/RecentBook/RecentBookService.dart';
import 'package:book_management/Model/BookModel.dart';
import 'package:book_management/bookview/bookview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../BookSetting/provider/theme_provider.dart';

class RecentBookList extends StatefulWidget {
  const RecentBookList({Key? key}): super (key: key);

  @override
  State createState() => RecentBookListState();
}

class RecentBookListState extends State<RecentBookList> {
  RecentBookService recentService = RecentBookService();
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
    return StreamBuilder(
      stream: recentService.loadRecentStream(),
      builder: (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
        if (snapshot.hasData) {
          List<BookModel> saveBooks = snapshot.data!;
          List<BookModel> books = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  recentService.addRecent(books[index], saveBooks);
                  recentService.saveRecent(saveBooks);
                  recentService.loadRecentStream();
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookView(books[0])));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 125,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 125,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    books[index].imgUrl)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          books[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.roboto(
                              color:themeProvider.darkTheme?Colors.white: HexColor("#B6442A"),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 3),
                        Text(
                          books[index].genre,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:
                          GoogleFonts.roboto(color: Colors.grey),
                        ),
                      ]
                    ),
                  )
                ],
              ),
            )
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

}