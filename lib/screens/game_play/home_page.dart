import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game_play/game_page.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/screens/help/help.dart';
import 'package:tic_tac_toe/screens/CommonWidgets/gradient_text.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Future<int> _getAiWins() async{
    try{
        String win = await storage.read(key: 'wins');

      return int.parse(win);
    }
     catch(e) {
      await storage.write(key: 'wins', value: ('0'));
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {

  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
    return Scaffold(
          body: Stack(
          children: <Widget>[
            Container(
      color: bgcolor,
            ),
            Positioned(
        right: 20,
        top: 45,
      child:GestureDetector(
        onTap: ()=>{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage())
            )
        },
        child: Container(
        height: 50.0,
        width: 50.0,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: bgcolor2, 
            image: DecorationImage(image: AssetImage("assets/images/info.png"),fit: BoxFit.cover),
            shape: BoxShape.circle,
            
        ),
        ),
      )),
      Positioned(
        
        height: height/3,
        bottom: height/8,
        right:10,
        child: Image.asset('assets/images/pablo.png')),
      // Positioned(
      //   width: width/2,
      //   top: height/6,
      //   child: Image.asset('assets/images/textbg.png')),
            Positioned(
      width: width/2,
      top: height/6,
      left: width/10,
      child: Text("Play ", style: TextStyle(fontSize: 40,color: Colors.white,fontFamily:'blackout'),)),
      Positioned(
      width: width/2,
      top: height/4,
      left: width/10,
      child: Text("Tic Tac Toe !", style: TextStyle(fontSize: 25,color: Colors.white,fontFamily:'blackout'),)),
      Positioned(
      top: height/3,
      left: width/10,
      child: FutureBuilder(
      future: _getAiWins(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null){
                    return Container(
                        color: bgcolor,
                    );
          }
          else{
            if (snapshot.data <= 0) {
              return Text("No AI wins yet!", style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'lilita'));
            }
              return Text("Number of AI wins: ${snapshot.data}", style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'lilita'));  
          }
      }
            )),
            // Positioned(          
            //   left: width/8,
            //   right: width/8,
            //   bottom: height/5,
            //   child: Image.asset('assets/images/bgimg.png')),
            Positioned(
      bottom: height/12,
      left: width/10,
      child: ButtonTheme(
        minWidth: 200,
        height: 80,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(100)),
            
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GamePage())
            );
          },
          
          child: GradientText(
        'New Game >>',
        gradient: LinearGradient(colors: [
          Colors.blue.shade400,
          Colors.blue.shade900,
           Colors.pink

        ]),),
        ),
      ),
            ),
            
          ],
        ),
    );
  }
}
