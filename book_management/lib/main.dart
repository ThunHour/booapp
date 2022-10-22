import 'package:book_management/BookList/BookListPage.dart';
import 'package:book_management/BookList/RecentBook/RecentBookService.dart';
import 'package:flutter/material.dart';
import './bookview/bookview.dart';
import 'BookSetting/provider/theme_provider.dart';
import 'BookSetting/style/style.dart';
import 'Model/BookModel.dart';
import 'TabView.dart';
import 'BookSetting/booksetting.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabView(),
      // home: MyHomePage(),
    );
  }
}
