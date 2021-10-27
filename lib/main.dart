import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzly/constants.dart';
import 'package:quizzly/quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Constants.purple),
        scaffoldBackgroundColor: Constants.teal,
        textTheme: TextTheme(
          headline1: GoogleFonts.ubuntu(fontSize: 36, color: Colors.white),
          headline2: GoogleFonts.ubuntu(fontSize: 24, color: Colors.white),
          bodyText1: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            textStyle: GoogleFonts.ubuntu(fontSize: 20)
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      // home: const QuizzlyHomePage(),
      initialRoute: '/',
      routes:{
        '/' : (context) => QuizzlyHomePage(),
      }
    );
  }
}

class QuizzlyHomePage extends StatelessWidget {
  const QuizzlyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzly', style: GoogleFonts.ubuntu(fontSize: 36),),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Welcome to Quizzly', style: Theme.of(context).textTheme.headline1,),
              ElevatedButton(
                onPressed: (){
                  Random rand = Random();
                  List<int> questionIds = List.empty(growable: true);

                  //Generate a unique 5 random questions out of the 10 questions pool, hence why I am using while loop.
                  //While loop will keep looping until there are 5 unique question ids, then proceed to the next page.
                  //In other words, no same questions will be shown.
                  while(questionIds.length != 5){
                    int id = rand.nextInt(Question.quiz.length);
                    if(!questionIds.contains(id)) questionIds.add(id);
                  }
                  print(questionIds);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(questionIds: questionIds)));

                },
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}