import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../BookSetting/provider/theme_provider.dart';

class BookDescriptions extends StatefulWidget {
  final String description;
  BookDescriptions(this.description);

  @override
  State<BookDescriptions> createState() => _BookDescriptionsState();
}

class _BookDescriptionsState extends State<BookDescriptions> {
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
          return Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
                    child: Text("About the book".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Text(widget.description,
                        style: TextStyle(
                          fontSize: 15,
                          color:themeProvider.darkTheme ?Colors.white:Colors.black,
                        )),
                  ),
                  Container(height: 70)
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: themeProvider.darkTheme ? Colors.white : Colors.red,
                    width: 1.5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ));
        }));
  }
}
