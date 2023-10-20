// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';
import '../home_page.dart';

import 'barriers.dart';
import 'bird.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  static double barrierXone = 2;
  double barrierXtwo = barrierXone + 1.5;
  bool gameHasStarted = false;
  bool isDialogVisible = false;
  var score = 0;
  //var Score= TextEditingController();

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  bool birdIsDead() {
    if (birdYaxis < -1 || birdYaxis > 1) {
      return true;
    } else {
      return false;
    }
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      if (birdIsDead()) {
        timer.cancel();
        //gameHasStarted = false;
        _showDialog();
      }
        
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      if (birdYaxis > 1) {
        setState(() {
          timer.cancel();
        });
      }
     time += 0.01;
    });
  }

  void resetGame() {
    //   if (isDialogVisible) {
    //   Navigator.of(context).pop();
    //   isDialogVisible = false;
    // }
    //Navigator.pop(context);
    Navigator.of(context,rootNavigator: true).pop();
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void _showDialog() {
    //isDialogVisible = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text(
              "G A M E  O V E R",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(7),
                  color: Colors.white,
                  child: Text(
                    "P L A Y  A G A I N",
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
//   Future<void> _Score() async{
//     await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Score:" + score.$oid)));
//  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: const Text("Flappy Game"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => game2Page(appUrl: 'game2.dart'),
              ),
            );
          },
      ),
      ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? Text(" ")
                          : Text("T A P  T O  P L A Y",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 150.00,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 180.00,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 170.00,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 150.00,
                      ),
                    ),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
            )),
          ],
        ),
      ),
    );
  }
}

class game2Page extends StatelessWidget {
  final String appUrl;

  game2Page({required this.appUrl}); // Constructor to accept the parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flappy Bird'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Text(
            "Home Page",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
         // Use the parameter in your widget
      ),
    );
  }
}

