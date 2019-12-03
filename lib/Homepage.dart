import 'dart:math';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
   _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
   
  //Initialise Images
  AssetImage circle=AssetImage('images/circle.png');   
  AssetImage rupee=AssetImage('images/rupee.png');   
  AssetImage sadFace=AssetImage('images/sadFace.png');
  
  //initialise array with 25 elements
  List<String> board;
  String message='';
  var random;  
   
   @override
   void initState(){
     random=Random().nextInt(25);
     super.initState();
     setState(() {
      board = board = List<String>.generate(25, (index)=>'empty'); 
     });
   }
   AssetImage getImage(var value){
     switch (value) {
       case 'empty':return circle;
         break;
       case 'rupee':return rupee;
         break;
       case 'sadFace':return sadFace;
         break;            
     }
   }
   void resetGame(){
      random=Random().nextInt(25);
      setState(() {
          board = List<String>.filled(25, 'empty');
        this.message='';
      });
   }
   void playGame(int i){
     if(i==this.random){
       setState(() {
         this.board[i]='rupee';
       });
       checkWin(i);
     }
     else{
       setState(() {
         this.board[i]='sadFace';
       });
     }
   }
   void showAll(){
     setState(() {
       board = List<String>.filled(25, 'empty');
        board[random] = 'rupee';
     });
   }
   void checkWin(int i){
     if(i==this.random){
       setState(() {
        this.message='You Won !';
       });
       Future.delayed(Duration(seconds:2),(){
          resetGame();   
       });
     }
   }
   
   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch And Win'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 5,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 25,
              itemBuilder: (context, i)=> MaterialButton(
                  padding: EdgeInsets.all(2),
                  color: Colors.lightBlue,
                  onPressed: (){
                    playGame(i);
                  },
                  child: Center(
                    child: Image(
                      image: getImage(this.board[i]),
                    ),
                  ),
                )
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(this.message,
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(30),
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text('RESET',
              style: TextStyle(
                color: Colors.white,
              ),               
            ),
            onPressed: resetGame,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Devloped By Bijay',
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
  ),
            ),
          ),
        ],
      ),
    );
  }
} 