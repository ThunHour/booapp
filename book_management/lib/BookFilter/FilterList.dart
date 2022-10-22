import 'package:book_management/HttpService.dart';
import 'package:book_management/Model/Author.dart';
import 'package:book_management/Model/Genre.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class FilterList extends StatefulWidget {
  const FilterList({Key? key}): super (key: key);

  @override
  State createState() => FilterListState();
}

class FilterListState extends State<FilterList> {
  HttpService httpService = HttpService();
  bool isFilter = false;
  List authorFilters = [];
  List genreFilters = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            foregroundColor: HexColor("#B6442A"),
            backgroundColor: Colors.white30,
            actions: <Widget>[
              FlatButton(
                textColor: Colors.redAccent,
                onPressed: () {},
                child: Text("Start BookFilter"),
                shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
            bottom: TabBar(
              unselectedLabelColor: Colors.redAccent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.redAccent),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Authors"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Genres"),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: httpService.getAllAuthors(),
                        builder: (BuildContext context, AsyncSnapshot<List<Author>> snapshot) {
                          if (snapshot.hasData) {
                            List<Author> authors = snapshot.data!;
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 5,
                                children: List.generate(
                                    authors.length, (index) {
                                  return FilterChip(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
                                        color: HexColor("#B6442A"),
                                        width: 1
                                    ),
                                    avatar: CircleAvatar(
                                        backgroundColor: HexColor("#F9E1E1"),
                                        backgroundImage: NetworkImage(authors[index].imgUrl)
                                    ),
                                    label: Text(authors[index].name, style: TextStyle(color: HexColor("#B6442A")),),
                                    selected: authorFilters.contains(authors[index].name),
                                    selectedColor: HexColor("#F9E1E1"),
                                    onSelected: (bool selected) {
                                      setState((){
                                        if (selected) {
                                          authorFilters.add(authors[index].name);
                                        } else {
                                          authorFilters.removeWhere((name) {
                                            return name == authors[index].name;
                                          });
                                        }
                                      });
                                      print(authorFilters);
                                    },
                                  );
                                }
                                ),
                              ),
                            );

                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: httpService.getAllGenres(),
                          builder: (BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
                            if (snapshot.hasData) {
                              List<Genre> genres = snapshot.data!;
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 5,
                                  children: List.generate(
                                      genres.length, (index) {
                                    return FilterChip(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                          color: HexColor("#B6442A"),
                                          width: 1
                                      ),
                                      avatar: CircleAvatar(
                                          backgroundColor: HexColor("#F9E1E1"),
                                          backgroundImage: NetworkImage(genres[index].imgUrl)
                                      ),
                                      label: Text(genres[index].name, style: TextStyle(color: HexColor("#B6442A")),),
                                      selected: genreFilters.contains(genres[index].name),
                                      selectedColor: HexColor("#F9E1E1"),
                                      onSelected: (bool selected) {
                                        setState((){
                                          if (selected) {
                                            genreFilters.add(genres[index].name);
                                          } else {
                                            genreFilters.removeWhere((name) {
                                              return name == genres[index].name;
                                            });
                                          }
                                        });
                                        print(genreFilters);
                                      },
                                    );

                                  }
                                  ),
                                ),
                              );

                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }
                      ),
                    ],
                  ),
                )

              ]
          )
        ),
    );
  }
}