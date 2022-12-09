import 'package:empty_proj/models/question.dart';

class GameLogic {
  GameLogic();

  int scoreCalculator(List<Question> question, List<int> answers) {
    int res = 0;
    for (var i = 0; i < question.length; i++) {
      int temp = 0;
      int streak = 1;
      if (question[i].dapAnDung == answers[i]) {
        temp += 10;
      }
      if (i != 0) {
        if (question[i - 1].dapAnDung == answers[i - 1]) {
          streak++;
        } else {
          streak = 1;
        }
      }
      temp *= streak;
      res += temp;
    }
    return res;
  }

  int correctAnswer(List<Question> question, List<int> answers) {
    int res = 0;
    for (var i = 0; i < question.length; i++) {
      if (question[i].dapAnDung == answers[i]) {
        res++;
      }
    }
    return res;
  }

  int correctStreak(List<Question> question, List<int> answers) {
    int res = 0;
    int temp = 0;
    for (var i = 0; i < question.length; i++) {
      if (i != 0) {
        if (question[i - 1].dapAnDung == answers[i - 1]) {
          temp++;
          if (temp > res) {
            res = temp;
          }
        } else {
          temp = 0;
        }
      }
    }
    return res;
  }

  double percent(List<Question> question, List<int> answers) {
    double res = 0.0;
    int correct = correctAnswer(question, answers);
    res = (correct / question.length) * 100;
    return res;
  }
}
