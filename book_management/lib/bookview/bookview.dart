// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../BookSetting/provider/theme_provider.dart';
import '../Model/BookModel.dart';
import 'widgets/BookDescriptions.dart';
import 'widgets/bookAuthorTitleLink.dart';
import 'widgets/bookCover.dart';

class BookView extends StatefulWidget {
  final BookModel bookDetail;
  BookView(this.bookDetail);

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
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
          return 
            Scaffold(

              appBar: _buildAppBar(
                context, themeProvider.darkTheme
              ),
              body: Container(
                color: themeProvider.darkTheme ? Colors.black : Colors.white,
                height: double.infinity,
                child: SingleChildScrollView(
                 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: 20),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        bookCover(widget.bookDetail.imgUrl),
                        bookAuthorTitleLink(
                          title: widget.bookDetail.title,
                          author: widget.bookDetail.author,
                          genre: widget.bookDetail.genre,
                          downloadUrl: widget.bookDetail.downloadUrl,
                        )
                      ]),
                      Container(height: 30),
                      BookDescriptions(widget.bookDetail.description),
                    ],
                  ),
                ),
              ),
              // backgroundColor: Color(0xff686868),
            );
         
        }));
  }
}

AppBar _buildAppBar(BuildContext context,bool darkTheme) {
  return AppBar(
   backgroundColor:darkTheme ? HexColor("#292929") : HexColor("#F9E1E1"),
      bottomOpacity: 0.0,
      elevation: 0.0,
//       foregroundColor: HexColor("#B6442A"),
//       backgroundColor: HexColor("#F9E1E1"),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
          )));
}
