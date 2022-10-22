import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../BookSetting/provider/theme_provider.dart';

class bookAuthorTitleLink extends StatefulWidget {
  final String title;
  final String author;
  final String downloadUrl;
  final String genre;
  bookAuthorTitleLink(
      {required this.title,
      required this.author,
      required this.downloadUrl,
      required this.genre});

  @override
  State<bookAuthorTitleLink> createState() => _bookAuthorTitleLinkState();
}

class _bookAuthorTitleLinkState extends State<bookAuthorTitleLink> {
    ThemeProvider themeProvider = ThemeProvider();

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }
  _launcher() async {
      await launch(widget.downloadUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: Consumer<ThemeProvider>(builder: (context, value, child) {
          return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                color: themeProvider
                .darkTheme?Colors.white :HexColor("#B6442A"),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              width: 150,
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Author : ${widget.author}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  // fontWeight: FontWeight.w500,
                ),
              )),
          Container(
            width: 150,
            padding: const EdgeInsets.only(top: 5, bottom: 20),
            child: Text(
              "Genre : ${widget.genre}",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
                // fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed:_launcher,
            icon: const Icon(Icons.download),
            label: const Text("Go to Download",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            style: ElevatedButton.styleFrom(
              primary: themeProvider.darkTheme?Colors.white:Colors.redAccent,
              onPrimary: themeProvider.darkTheme?Colors.redAccent:Colors.white ,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
        }));
  }
}
