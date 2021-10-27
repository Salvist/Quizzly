import 'package:flutter/material.dart';
import 'package:quizzly/quiz.dart';

class ResultPage extends StatelessWidget{
  final List<int> questionIds;
  final List<String> answerList;

  ResultPage({
    Key? key,
    required this.questionIds,
    required this.answerList,
  }) : super(key: key);

  int correct = 0;
  double percentage = 0;

  //This is a function to count correct answer
  void checkAnswer(){
    int c = 0;
    for(int i = 0; i < questionIds.length; i++){
      //check if the user answer is equal with the question's answer.
      //if it is equal, then increase the correct count.
      if(answerList[i] == Question.quiz[questionIds[i]].answer) c++;
    }
    correct = c;
    percentage = double.parse((c/5*100).toStringAsFixed(2)); // calculate percentage of the correct answer
  }

  @override
  Widget build(BuildContext context) {
    checkAnswer();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Here is your Result', style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.center,),
                //different percentage conditions for different messages
                //above 70% = Great Job
                //between 40% and 70% = You are doing well, but you can improve more!
                //below 40% = Please try to study more!
                if(percentage > 70.0) Text('$correct out of 5 questions are correct! ($percentage%)\n Great job!', style: Theme.of(context).textTheme.headline2,),
                if(percentage > 40.0 && percentage <= 70.0) Text('$correct out of 5 questions are correct! ($percentage%)\n You are doing well, but you can improve more!', style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.center,),
                if(percentage <= 40.0) Text('$correct out of 5 questions are correct! ($percentage%)\n Please try to study more!', style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.center,),
                ...List.generate(
                    5, (index) => Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Text(Question.quiz[questionIds[index]].question!, style: Theme.of(context).textTheme.bodyText1),
                      Text('Your answer: ${answerList[index]}', style: Theme.of(context).textTheme.bodyText1),
                      Text('Correct answer: ${Question.quiz[questionIds[index]].answer}', style: Theme.of(context).textTheme.bodyText1)
                    ]

                  ),
                )
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Done'),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}