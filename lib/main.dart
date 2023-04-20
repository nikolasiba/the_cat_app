import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:the_cats_app/presentation/home/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
               Locale('es', 'es_CO'), // español,
               Locale('en', 'en_us'), // English,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato-Regular',
              brightness: Brightness.light,
              textSelectionTheme:
                  const TextSelectionThemeData(cursorColor: Colors.black),
            ),
            title: 'The Cats App',
           
            initialRoute: '/home',
            getPages: [
              GetPage(name: '/home', page: () =>  HomePage()),
            ]);
  }
}

