import 'package:book_management/BookList/RecentBook/RecentBookService.dart';
import 'package:book_management/BookList/RecommendedBook/RecommendedBookList.dart';
import 'package:book_management/Model/BookModel.dart';
import 'package:book_management/HttpService.dart';
import 'package:book_management/bookview/bookview.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomSearchDelegate extends SearchDelegate {

  
//   HttpService httpService = HttpService();
  RecentBookService recentService = RecentBookService();
  bool dark;
  CustomSearchDelegate(this.dark);
  HttpService httpService = HttpService();
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      
      textTheme:TextTheme(headline6: TextStyle(
        color: dark?Colors.white:Colors.black
      )),
      hintColor: dark ? Colors.white : Colors.black,
      appBarTheme: AppBarTheme(
        color: dark ? HexColor("#292929") : Colors.white,
      ),
      
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(
        color: dark ? HexColor("#292929") : Colors.white,
        child: IconButton(
          icon: Icon(Icons.clear),
          color: dark ? Colors.white : Colors.black,
          onPressed: () {
            query = '';
          },
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Container(
      color: dark ? HexColor("#292929") : Colors.white,
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        color: dark ? Colors.white : Colors.black,
        onPressed: () {
          close(context, null);
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      child: Container(
        
         height: double.infinity,
        color: dark ?Colors.black : Colors.white,
        child: FutureBuilder(
            future: httpService.getAllBooks(),
            builder:
                (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
              if (snapshot.hasData) {
                List<BookModel> books = snapshot.data!
                    .where((element) =>
                        element.title.toLowerCase().contains(query.toLowerCase()))
                    .toList();
                return RecommendedBookList(books: books);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<BookModel> saveBooks = [];
    recentService.loadRecent().then((value) => saveBooks..addAll(value));
    return SizedBox(      
      height:double.infinity,
      child: FutureBuilder(

        future: httpService.getAllBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
          if (snapshot.hasData) {
            List<BookModel> books = snapshot.data!.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();;

            return Container(
              color: dark ? Colors.black : Colors.white,
              child: ListView.separated(
                itemCount: books.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    books[index].title,
                    style: TextStyle(color: dark ? Colors.white : Colors.black)
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookView(books[index])));
                    recentService.addRecent(books[index], saveBooks);
                    recentService.saveRecent(saveBooks);
                  },
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
