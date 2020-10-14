import 'package:laugh_ly/services/joke_service.dart';
import 'dart:io';

void main() {
  stdout.write('Start API? ');
  String input = stdin.readLineSync();

  if (input == 'y') {
    loadApiResponse();
  }
}

void loadApiResponse() {
  getTenJokes().then((value) {
    for (int i = 0; i < value.jokeList.length; i++) {
      print(value.jokeList[i].setup);
      print(value.jokeList[i].punchLine);
      print('');
    }
  });
}
