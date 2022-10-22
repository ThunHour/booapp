import 'package:book_management/BookFilter/FilterList.dart';
import 'package:book_management/BookSetting/booksetting.dart';
import 'package:book_management/bookview/bookview.dart';
import 'package:book_management/main.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'BookList/BookListPage.dart';
import 'BookSetting/provider/theme_provider.dart';
import 'Model/BookModel.dart';

class TabView extends StatefulWidget {
  @override
  State createState() => TabViewState();
}

class TabViewState extends State<TabView> {
  ThemeProvider themeProvider = ThemeProvider();

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: Consumer<ThemeProvider>(builder: (context, value, child) {
          return Scaffold(
            body: ChangeNotifierProvider(
                create: (_) => themeProvider,
                child:
                    Consumer<ThemeProvider>(builder: (context, value, child) {
                  return PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                         getCurrentTheme();
                        _currentIndex = index;
                      });
                    },
                    children: [
                      BookListPage(),
                      bookSetting(),
                    ],
                  );
                },),),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              // themeProvider.darkTheme
              //     ? HexColor("#292929")
              //     : 
             // HexColor("#292929"),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: 
              // themeProvider.darkTheme
              //     ? HexColor("#00C9C7")
              //     : 
                  Colors.redAccent,
              unselectedItemColor: Colors.grey[500],
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                 
                  _currentIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "HomePage"),
                // BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite Books"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Setting")
              ],
            ),
          );
        }));
  }
}
