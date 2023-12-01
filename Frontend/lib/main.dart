import 'package:flutter/material.dart';
import 'package:hackathon_frontend/Pages/Login.dart';
import 'package:hackathon_frontend/utils/constants.dart';
import 'package:provider/provider.dart';
import 'Pages/Homepage.dart';
import 'provider/model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => TodoModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Palette.kToDark, //here is where the error resides
          ),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => const HomePage(),
            '/login': (BuildContext context) => const LoginScreen(),
            // '/temp': (BuildContext context) => const MyHomePage(title: 'hi',),
          },
        )),
  );
}
