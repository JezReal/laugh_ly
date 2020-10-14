import 'package:flutter/material.dart';
import 'package:laugh_ly/models/joke_model.dart';
import 'package:laugh_ly/services/joke_service.dart';

void main() => runApp(MaterialApp(
      home: LaughlyApp(),
    ));

class LaughlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laugh.ly'),
        centerTitle: true,
      ),
      body: LaughlyJokes(),
    );
  }
}

class LaughlyJokes extends StatefulWidget {
  @override
  _LaughlyJokesState createState() => _LaughlyJokesState();
}

class _LaughlyJokesState extends State<LaughlyJokes> {
  List<Joke> jokes = List<Joke>();
// TODO: fix classes and layout, themes, etc.
  @override
  Widget build(BuildContext context) {
    if (jokes.length == 0) {
      return FutureBuilder<JokeList>(
          future: _refreshJokes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.purple[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('${jokes[index].setup}'),
                          Text('${jokes[index].punchLine}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          });
    }

    return RefreshIndicator(
      onRefresh: _refreshJokes,
      child: ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ExpansionTile(
              title: Text(jokes[index].setup),
              children: [Text(jokes[index].punchLine)],
              childrenPadding: EdgeInsets.all(10.0),
            ),
          );
        },
      ),
    );
  }

  Future<Null> _refreshJokes() async {
    jokes = await getTenJokes().then((value) => value.jokeList);

    setState(() {
      this.jokes = jokes;
    });
    return null;
  }
}
