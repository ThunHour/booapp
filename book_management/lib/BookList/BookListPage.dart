import 'package:book_management/BookFilter/FilterResult.dart';
import 'package:book_management/BookList/BookListBody.dart';
import 'package:book_management/BookList/Search/CustomSearchDelegate.dart';
import 'package:book_management/HttpService.dart';
import 'package:book_management/Model/Author.dart';
import 'package:book_management/Model/Genre.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../BookSetting/provider/theme_provider.dart';
import '../BookSetting/style/style.dart';
 
class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State createState() => BookListPageState();
}

class BookListPageState extends State<BookListPage> {
  HttpService httpService = HttpService();
  bool isFilter = false;
  List authorFilters = [];
  List genreFilters = [];
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.darkTheme, context),
            home: Scaffold(
                appBar: AppBar(
                  title: Text(
                    authorFilters.length == 0 && genreFilters.length == 0
                        ? "Book Collection HomePage"
                        : "Filter Result",
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search),
                      color: themeProvider.darkTheme
                          ? Colors.white
                          : HexColor("#B6442A"),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate:
                              CustomSearchDelegate(themeProvider.darkTheme),
                        );
                      },
                    ),
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: themeProvider.darkTheme
                              ? Colors.white
                              : HexColor("#B6442A"),
                        ),
                        // color: HexColor("#B6442A"),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ),
                  ],
                  // backgroundColor: HexColor("#F9E1E1"),
                ),
                endDrawer: Drawer(
                    // elevation: 20,
                    child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                      backgroundColor:
                          themeProvider.darkTheme ? Colors.black : Colors.white,
                      appBar: AppBar(
                        elevation: 0,
                        foregroundColor: themeProvider.darkTheme ? Colors.white : HexColor("#B6442A"),
                        backgroundColor: themeProvider.darkTheme ? Colors.black : Colors.white,
                        actions: <Widget>[
                          FlatButton(
                            textColor: themeProvider.darkTheme
                                ? Colors.white
                                : HexColor("#B6442A"),
                            onPressed: () => clearFilter(),
                            child: Text("Clear BookFilter"),
                            shape: CircleBorder(
                                side: BorderSide(color: Colors.transparent)),
                          ),
                        ],
                        bottom: TabBar(
                          labelColor: themeProvider.darkTheme
                              ? Colors.black
                              : Colors.white,
                          unselectedLabelColor: themeProvider.darkTheme
                              ? Colors.white
                              : Colors.redAccent,
                          indicatorSize: TabBarIndicatorSize.label,
                       
                          indicator: BoxDecoration(

                              borderRadius: BorderRadius.circular(50),
                                color: themeProvider.darkTheme
                                            ? HexColor("#B2ADAD")
                                            : Colors.redAccent,
                                            ),
                          tabs: [
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: themeProvider.darkTheme
                                            ? HexColor("#B2ADAD")
                                            : Colors.redAccent,
                                        width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Authors", ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                          color: themeProvider.darkTheme
                                            ? HexColor("#B2ADAD")
                                            : Colors.redAccent, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Genres"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      body: TabBarView(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                                future: httpService.getAllAuthors(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Author>> snapshot) {
                                  if (snapshot.hasData) {
                                    List<Author> authors = snapshot.data!;
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 5,
                                        children: List.generate(authors.length,
                                            (index) {
                                          return FilterChip(
                                            backgroundColor: themeProvider.darkTheme ? HexColor("#B2ADAD")
                                                    :Colors.white,
                                            side: BorderSide(
                                                color: themeProvider.darkTheme ?Colors.white:HexColor("#B6442A"),
                                                width: 1),
                                            avatar: CircleAvatar(
                                                backgroundColor:
                                                    themeProvider.darkTheme ?Colors.white: HexColor("#F9E1E1"),
                                                backgroundImage: NetworkImage(
                                                    authors[index].imgUrl)),
                                            label: Text(
                                              authors[index].name,
                                              style: TextStyle(
                                                  color: themeProvider.darkTheme ?Colors.white:HexColor("#B6442A")),
                                            ),
                                            selected: authorFilters
                                                .contains(authors[index].name),
                                            selectedColor: themeProvider.darkTheme
                                                    ? HexColor("#005B61")
                                                    : HexColor("#F9E1E1"),
                                            
                                            
                                            onSelected: (bool selected) {
                                              setState(() {
                                                if (selected) {
                                                  authorFilters
                                                      .add(authors[index].name);
                                                } else {
                                                  authorFilters
                                                      .removeWhere((name) {
                                                    return name ==
                                                        authors[index].name;
                                                  });
                                                }
                                              });
                                              print(authorFilters);
                                            },
                                          );
                                        }),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ],
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: httpService.getAllGenres(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Genre>> snapshot) {
                                    if (snapshot.hasData) {
                                      List<Genre> genres = snapshot.data!;
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 5,
                                          children: List.generate(genres.length,
                                              (index) {
                                            return FilterChip(
                                              backgroundColor: themeProvider.darkTheme
                                                      ? HexColor("#B2ADAD")
                                                      : Colors.white,
                                              side: BorderSide(
                                                  color:themeProvider.darkTheme ?Colors.white:HexColor("#B6442A"),
                                                  width: 1),
                                              avatar: CircleAvatar(
                                                  backgroundColor:
                                                      themeProvider.darkTheme
                                                          ? Colors.white
                                                          : HexColor("#F9E1E1"),
                                                  backgroundImage: NetworkImage(
                                                      genres[index].imgUrl)),
                                              label: Text(
                                                genres[index].name,
                                                style: TextStyle(
                                                      color: themeProvider
                                                            .darkTheme
                                                        ? Colors.white
                                                        : HexColor("#B6442A")),
                                              ),
                                              selected: genreFilters
                                                  .contains(genres[index].name),
                                              selectedColor:
                                                themeProvider.darkTheme
                                                      ? HexColor("#005B61")
                                                      : HexColor("#F9E1E1"),
                                              onSelected: (bool selected) {
                                                setState(() {
                                                  if (selected) {
                                                    genreFilters.add(
                                                        genres[index].name);
                                                  } else {
                                                    genreFilters
                                                        .removeWhere((name) {
                                                      return name ==
                                                          genres[index].name;
                                                    });
                                                  }
                                                });
                                                print(genreFilters);
                                              },
                                            );
                                          }),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        )
                      ])),
                )),
                body: authorFilters.length == 0 && genreFilters.length == 0
                    ? BookListBody()
                    : FilterResult(
                        authorFilters: authorFilters,
                        genreFilters: genreFilters)),
          );
        },),);
  }

  void clearFilter() {
    setState(() {
      authorFilters.clear();
      genreFilters.clear();
    });
  }
}
