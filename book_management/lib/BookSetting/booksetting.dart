import 'package:book_management/BookSetting/preference/preference.dart';
import 'package:book_management/BookSetting/style/style.dart';
import 'package:book_management/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../TabView.dart';
import 'provider/theme_provider.dart';

class bookSetting extends StatefulWidget {
  const bookSetting({Key? key}) : super(key: key);

  @override
  State<bookSetting> createState() => _bookSettingState();
}

class _bookSettingState extends State<bookSetting> {
  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  ThemeProvider themeProvider = ThemeProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.darkTheme, context),
            home: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Setting",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              body: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.dark_mode_sharp,
                      size: 50,
                    ),
                    Switch(
                      value: themeProvider.darkTheme,
                      onChanged: (val) {
                        themeProvider.darkTheme = !themeProvider.darkTheme;
                        setState(() {
                          themeProvider.darkTheme = val;
                          TabView();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
