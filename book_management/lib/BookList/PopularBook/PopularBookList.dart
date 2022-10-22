import 'package:book_management/BookList/RecentBook/RecentBookService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../BookSetting/provider/theme_provider.dart';
import '../../Model/BookModel.dart';
import '../../HttpService.dart';
import '../../bookview/bookview.dart';

class PopularBookList extends StatefulWidget {
  @override
  State<PopularBookList> createState() => _PopularBookListState();
}

class _PopularBookListState extends State<PopularBookList> {
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
          return (FutureBuilder(
              future: httpService.getAllBooks(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<BookModel>> snapshot) {
                if (snapshot.hasData) {
                  List<BookModel> books = snapshot.data!;
                  return ListView.builder(
                      padding: EdgeInsets.all(8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: books.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => BookView(books[index])
                          )
                        );
                      },
                            child: Column(
                              // alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  // color: Colors.deepOrange,
                                  // alignment: AlignmentDirectional.topCenter,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  // width: deviceSize.width * 0.3,
                                  width: 125,
                                  // height: deviceSize.height * 0.4,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // width: deviceSize.width * 0.3,
                                          width: 125,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                              color:themeProvider.darkTheme == true ? Colors.white : HexColor("#B6442A"),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          books[index].genre,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                          ));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },));
        },));
  }
}
