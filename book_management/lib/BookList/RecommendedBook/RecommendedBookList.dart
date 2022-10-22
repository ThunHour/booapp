import 'package:book_management/BookList/RecentBook/RecentBookService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../BookSetting/provider/theme_provider.dart';
import '../../Model/BookModel.dart';
import '../../HttpService.dart';
import '../../bookview/bookview.dart';

class RecommendedBookList extends StatefulWidget {
  late final List<BookModel> books;

  RecommendedBookList({required this.books});

  @override
  State<RecommendedBookList> createState() => _RecommendedBookListState();
}

class _RecommendedBookListState extends State<RecommendedBookList> {
  RecentBookService recentService = RecentBookService();
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
    List<BookModel> saveBooks = [];
    recentService.loadRecent().then((value) => saveBooks..addAll(value));
    var deviceSize = MediaQuery.of(context).size;
    // return ListView.builder(
    //     shrinkWrap: true,
    //     physics: BouncingScrollPhysics(),
    //     itemCount: books.length,
    //     reverse: true,
    //     itemBuilder: (context, index) => GestureDetector(
    //         onTap: () {
    //           Navigator.push(
    //               context, MaterialPageRoute(builder: (context) => BookView(books[index])));
    //           recentService.addRecent(books[index], saveBooks);
    //           recentService.saveRecent(saveBooks);
    //           recentService.loadRecentStream();
    //         },
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Container(
    //               margin: EdgeInsets.symmetric(vertical: 5),
    //               width: 125,
    //               height: 180,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 image: DecorationImage(
    //                     fit: BoxFit.fill,
    //                     image: NetworkImage(books[index].imgUrl)),
    //               ),
    //             ),
    //             SizedBox(
    //               width: deviceSize.width * 0.4,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    return ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: Consumer<ThemeProvider>(builder: (context, value, child) {
          return Container(
            height:200,
            color:themeProvider.darkTheme?Colors.black:Colors.white,
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: widget.books.length,
                reverse: true,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => BookView(widget.books[index])));
                recentService.addRecent(widget.books[index], saveBooks);
                recentService.saveRecent(saveBooks);
                recentService.loadRecentStream();
              },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: 125,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.books[index].imgUrl)),
                          ),
                        ),
                        SizedBox(
                          width: deviceSize.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.books[index].title,
                                style: GoogleFonts.roboto(
                                  color: themeProvider.darkTheme == true
                                      ? Colors.white
                                      : HexColor("#B6442A"),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "By " + widget.books[index].author,
                                style: GoogleFonts.roboto(
                                     color: themeProvider.darkTheme == true
                                      ? Colors.white
                                      : HexColor("#B6442A"),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.books[index].genre,
                                style: GoogleFonts.roboto(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            color: HexColor("#F9E1E1"),
                            child: SizedBox(
                                height: 25,
                                child: Image.asset("assets/icons/eye.png"))),
                      ],
                    ))),
          );
        }));
  }
}
