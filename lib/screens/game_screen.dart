import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:memory_game/models/image.dart';
import 'package:memory_game/models/memory_brain.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<ImageData> images = MemoryBrain().getListElements();

  List<bool> cardFlips = [];
  int previousIndex = -1;
  bool flip = false;

  int time = 0;
  Timer timer;
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    for (int x = 0; x < images.length; x++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naruto Memory Game'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bzzelaqwogi31.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Time Elapsed ',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Text(
              time == -1 ? '0' : '$time',
              style: TextStyle(fontSize: 50.0, color: Colors.white),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) => FlipCard(
                key: cardStateKeys[index],
                onFlip: () {
                  if (!flip) {
                    flip = true;
                    previousIndex = index;
                  } else {
                    flip = false;
                    if (previousIndex != index) {
                      if (images[previousIndex].key != images[index].key) {
                        cardStateKeys[previousIndex].currentState.toggleCard();
                        previousIndex = index;
                      } else {
                        cardFlips[previousIndex] = false;
                        cardFlips[index] = false;
                        if (cardFlips.every((element) => element == false)) {
                          print('Won');
                          showResult();
                        }
                      }
                    }
                  }
                },
                direction: FlipDirection.HORIZONTAL,
                flipOnTouch: cardFlips[index],
                front: Container(
                  margin: EdgeInsets.all(4.0),
                  color: Color(0xffffffff).withOpacity(0.6),
                ),
                back: Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff).withOpacity(0.6),
                    image: DecorationImage(
                        image: AssetImage(
                          images[index].imageLocation,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              itemCount: 16,
            ),
          ],
        ),
      ),
    );
  }

  showResult() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text('Congratulations. You Won!!!'),
              content: Text('Time: $time'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      setState(() {
                        time = 0;
                      });
                      cardFlips.clear();
                      cardStateKeys.clear();
                      images.clear();
                      images = MemoryBrain().getListElements();
                      for (int x = 0; x < images.length; x++) {
                        cardStateKeys.add(GlobalKey<FlipCardState>());
                        cardFlips.add(true);
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Try Again'))
              ],
            ));
  }
}
