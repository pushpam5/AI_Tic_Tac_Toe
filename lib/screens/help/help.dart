import 'package:flutter/material.dart';


import 'package:tic_tac_toe/screens/CommonWidgets/gradient_text.dart';
import 'package:tic_tac_toe/screens/game_play/game_page.dart';
import 'package:tic_tac_toe/constants.dart';

class HelpPage extends StatefulWidget{

  _HelpPageState createState() => _HelpPageState();

}

class _HelpPageState extends State<HelpPage>{

  @override
  Widget build(BuildContext context){
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;

      return Scaffold(
        
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return;
            },
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(children: [

              SizedBox(height : height/8),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/urban-395.png')),
                ),
                child: Image.asset('assets/images/howto.png'),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,25, 15,20),
                child: Text("How To Play",style: TextStyle(fontFamily: 'lilita',fontSize: 25),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
                child: Text("1. The game is played on a grid that's 3 squares by 3 squares.\n\n2. You are X, Friday is O. Players take turns putting their marks in empty squares.\n\n3. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.\n\n4. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a draw."
                ,style: TextStyle(color: Colors.grey.shade500,fontFamily: 'lilita',fontSize: 15),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
                child: ButtonTheme(
                    minWidth: 150,
                    height: 60,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 0),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          
                        ),
                        color: helpbuttoncolor,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => GamePage())
                          );
                        },
                        child: Text('Play',style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'lilita'),),
                    ),
                  ),
              )
            ],),
                    ),
          ),
        ),

      ) ;          


  }

}
