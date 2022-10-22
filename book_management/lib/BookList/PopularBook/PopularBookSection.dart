import 'package:book_management/BookList/PopularBook/PopularBookList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../BookSetting/provider/theme_provider.dart';

class PopularBookSection extends StatefulWidget {
  @override
  State<PopularBookSection> createState() => _PopularBookSectionState();
}

class _PopularBookSectionState extends State<PopularBookSection> {
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
    var deviceSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Text(
                    "Popular Books",
                    style: GoogleFonts.rozhaOne(
                     color:themeProvider.darkTheme == true ? Colors.white : HexColor("#B6442A"),
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                    // color: HexColor("#E5E5E5"),
                    // width: deviceSize.width,
                    height: deviceSize.height * 0.37,
                    child: PopularBookList()),
              ],
            ),
          );
        },
      ),
    );
  }
}
