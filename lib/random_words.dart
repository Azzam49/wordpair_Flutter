import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  //list of random words
  final _randomWordPairs = <WordPair>[];

  final _savedWordPairs = Set<WordPair>();

  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, item){

        //returns a divider widget similiar to <hr> in html
        if(item.isOdd) return Divider();

        // gets the total index of wordpairs by subtracting out the number of dividers
        final index = item ~/ 2;

        //generate more 10 random wordpairs if we scroll to the end
        if(index >= _randomWordPairs.length){
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        
        return _buildRow(_randomWordPairs[index]);
      },
    );   
  }

Widget _buildRow(WordPair pair){

    //check if wordPair is saved in set or not
    final alreadySaved = _savedWordPairs.contains(pair);

      return ListTile(
        title: Text(pair.asPascalCase, 
        style: TextStyle(
          fontSize: 18.0,
        ),
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
          ),
        onTap: (){
          setState(() {
            if(alreadySaved) {
              _savedWordPairs.remove(pair);
            }else{
              _savedWordPairs.add(pair);
            }
          });
        },
      );
    }

  void _pushSaved(){
    //create a page of the favroite wordPairs


    Navigator.of(context).push(
      //add route on top of our main route
      MaterialPageRoute(
        builder: (BuildContext context){
          //the map function returns ListTiles to our
          //tiles Iterable
          final Iterable<ListTile> tiles = 
          _savedWordPairs.map((WordPair pair){
            return ListTile(
              title: Text(pair.asPascalCase,
              style: TextStyle(
                fontSize: 16.0,
              ),
              ),
            );
          });

          // adding border between each tile using divideTiles
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles:tiles,
          ).toList();

          //this is the body of our new page route
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved WordPairs'),
              centerTitle: true,
            ),
            body: ListView(
              children: divided,
            ),
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: _buildList());
  }
}


