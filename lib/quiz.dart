import 'package:flutter/material.dart';
import 'package:quizzly/main.dart';
import 'package:quizzly/result.dart';

class QuizPage extends StatefulWidget{
  final List<int> questionIds;
  const QuizPage({
    Key? key,
    required this.questionIds,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

// I am using a Stateful Widget because I am going to stay on the same scaffold/page
// but update every question and the choices after the user go to the next question.
class _QuizPageState extends State<QuizPage> {
  int questionNumber = 0;
  String answerChoice = '';

  List<String> answerList = List.filled(5, '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Question ${questionNumber+1} out of 5', style: Theme.of(context).textTheme.headline1,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Text(Question.quiz[widget.questionIds[questionNumber]].question!, style: Theme.of(context).textTheme.headline2,),

                    //This is a list generator that will generate a RadioListTile for each of the choices.
                    //The triple dots is a spread operator which mean make them as 3 separate RadioListTile
                    //instead of List<RadioListTile> with 3 elements.
                    ...List.generate(
                        3, (index) =>
                        RadioListTile<String>(
                          title: Text(Question.quiz[widget.questionIds[questionNumber]].choices![index], style: Theme.of(context).textTheme.bodyText1,),
                          value: Question.quiz[widget.questionIds[questionNumber]].choices![index],
                          groupValue: answerChoice,
                          onChanged: (String? value){
                            setState(() {
                              answerChoice = value!;
                            });
                          },
                        )
                    ),
                  ],
                ),
              ),

              //Ternary operator to check whether the user is on the last question or not
              (questionNumber < 4) ? ElevatedButton(
                onPressed: (){
                  //check whether user has choose any answer or not, then save the answer to answerList
                  if(answerChoice != ''){
                    answerList[questionNumber] = answerChoice;
                    answerChoice = '';
                    setState((){
                      questionNumber++;
                    });
                  }
                  else {
                    //This is a scaffold messager that will pop up on the bottom.
                    //basically it's an error notification if the user has not choose any answer try to go to the next question
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please choose 1 answer!'),
                        duration: Duration(seconds: 2),
                      )
                    );
                  }
                },
                child: const Text('Next question'),
              )
              //If the user is at the last question,
              //then change the button to Finish and go to the result page.
              : ElevatedButton(
                onPressed: (){
                  if(answerChoice != ''){
                    answerList[questionNumber] = answerChoice;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ResultPage(questionIds: widget.questionIds, answerList: answerList)),
                        ModalRoute.withName('/')
                    );
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please choose 1 answer!'),
                          duration: Duration(seconds: 2),
                        )
                    );
                  }
                },
                child: const Text('Finish'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Question{
  //Data structuce for a question.
  //At the moment it's just the question, list of the choices, and the answer for that question.
  String? question;
  List<String>? choices;
  String? answer;

  Question({
    this.question,
    this.choices,
    this.answer
  });

  //Hard coded questions.
  //Of course it can be adjusted later on with the video given by LangInnov where the questions are in the cloud.
  //I have experience using Firebase.
  static List<Question> quiz= [
    //1
    Question(
      question: 'He\'s not very well and feeling a bit under the ____.',
      choices: ['clouds', 'weather', 'rain'],
      answer: 'weather',
    ),
    //2
    Question(
      question: 'It ____ cats and dogs.',
      choices: ['shone', 'rained', 'snowed'],
      answer: 'rained',
    ),
    //3
    Question(
      question: 'How ____ going to the cinema tonight?',
      choices: ['about', 'far', 'long'],
      answer: 'about',
    ),
    //4
    Question(
      question: 'There ____ some people waiting to see you.',
      choices: ['am', 'is', 'are'],
      answer: 'are',
    ),
    //5
    Question(
      question: 'We ____ nearly ready.',
      choices: ['am', 'is', 'are'],
      answer: 'are',
    ),
    //6
    Question(
      question: 'He ____ a nice person.',
      choices: ['am', 'is', 'are'],
      answer: 'is',
    ),
    //7
    Question(
      question: 'She\'s away on a business ____.',
      choices: ['journey ', 'travel', 'trip'],
      answer: 'trip',
    ),
    //8
    Question(
      question: 'I\'m going to ____ by plane.',
      choices: ['journey ', 'travel', 'trip'],
      answer: 'travel',
    ),
    //9
    Question(
      question: 'I fell over and ____ my knee.',
      choices: ['ached ', 'pained', 'hurt'],
      answer: 'hurt',
    ),
    //10
    Question(
      question: 'I was in a lot of ____ after the operation.',
      choices: ['sore ', 'hurt', 'pain'],
      answer: 'pain',
    ),
  ];
}