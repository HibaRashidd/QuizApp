import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is the capital of France?',
      'imageUrl': 'https://canopylab.com/wp-content/uploads/2023/01/Blog-Creating-multiple-choice-quizzes-with-the-CanopyLAB-Quiz-engine.jpg',
      'answers': [
        {'text': 'Paris', 'score': 1},
        {'text': 'London', 'score': 0},
        {'text': 'Berlin', 'score': 0},
        {'text': 'Madrid', 'score': 0},
      ],
    },
    {
      'questionText': 'Who wrote "To Kill a Mockingbird"?',
      'imageUrl': 'https://canopylab.com/wp-content/uploads/2023/01/Blog-Creating-multiple-choice-quizzes-with-the-CanopyLAB-Quiz-engine.jpg',
      'answers': [
        {'text': 'Harper Lee', 'score': 1},
        {'text': 'Mark Twain', 'score': 0},
        {'text': 'J.K. Rowling', 'score': 0},
        {'text': 'Ernest Hemingway', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the smallest planet in our solar system?',
      'imageUrl': 'https://canopylab.com/wp-content/uploads/2023/01/Blog-Creating-multiple-choice-quizzes-with-the-CanopyLAB-Quiz-engine.jpg',
      'answers': [
        {'text': 'Mercury', 'score': 1},
        {'text': 'Venus', 'score': 0},
        {'text': 'Mars', 'score': 0},
        {'text': 'Jupiter', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _currentQuestionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: _currentQuestionIndex < _questions.length
          ? Quiz(
        questionData: _questions[_currentQuestionIndex],
        answerQuestion: _answerQuestion,
      )
          : Result(
        score: _score,
        resetQuiz: _resetQuiz,
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final Map<String, Object> questionData;
  final Function(int) answerQuestion;

  Quiz({
    required this.questionData,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          questionData['imageUrl'] as String,
          height: 200,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20),
        Text(
          questionData['questionText'] as String,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ...(questionData['answers'] as List<Map<String, Object>>).map((answer) {
          return Answer(
            text: answer['text'] as String,
            onSelect: () => answerQuestion(answer['score'] as int),
          );
        }).toList(),
      ],
    );
  }
}

class Answer extends StatelessWidget {
  final String text;
  final VoidCallback onSelect;

  Answer({required this.text, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: ElevatedButton(
        onPressed: onSelect,
        child: Text(text),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetQuiz;

  Result({required this.score, required this.resetQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You did it!',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Text(
            'Your score is: $score',
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetQuiz,
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
