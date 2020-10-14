import 'dart:convert';

class JokeList {
  List<Joke> jokeList;

  JokeList({this.jokeList});

  factory JokeList.fromJson(List<dynamic> json) {
    List<Joke> jokes = json.map((e) => Joke.fromJson(e)).toList();
    return JokeList(
      jokeList: jokes,
    );
  }
}

class Joke {
  String setup;
  String punchLine;

  Joke({this.setup, this.punchLine});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(setup: json['setup'], punchLine: json['punchline']);
  }
}

JokeList tenJokesFromJson(String json) {
  var result = jsonDecode(json);
  return JokeList.fromJson(result);
}
