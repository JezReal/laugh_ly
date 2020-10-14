import 'package:http/http.dart';
import 'package:laugh_ly/models/joke_model.dart';

Future<JokeList> getTenJokes() async {
  Response response =
      await get('https://official-joke-api.appspot.com/random_ten');
  return tenJokesFromJson(response.body);
}
