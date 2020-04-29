import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures and Animations',
      theme: ThemeData(

      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin calls on ticker. a ticker is called once
  //per animation frame

  Animation<double> animation;
  AnimationController controller;
  @override
  void initState(){
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,

    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut
      
    );
    animation.addListener((){
      setState(() {

        boxSize = fullBoxSize * animation.value;
      });

      center(context);
    });

    controller.forward();

  }


  int numTap = 0;
  int numDoubleTaps = 0;
  int numLongPress = 0;

  double posX = 0.0;
  double posY = 0.0;
  double boxSize = 150.0;
  final double fullBoxSize = 150.0;

  @override
  Widget build(BuildContext context) {

    if(posX == 0.0){
      center(context);
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestures and Animations"),
      ),
      body: GestureDetector(
        onTap: (){
          setState(() {
            numTap++;
          });
        },
        onDoubleTap: (){
          setState(() {
            numDoubleTaps++;
          });
        },
        onLongPress: (){
          setState(() {
            numLongPress++;
          });
        },
        onVerticalDragUpdate: (DragUpdateDetails value){
          setState(() {
            //reads the value of the vertical value
            double delta = value.delta.dy;
            posY += delta;
          });
        },
        onHorizontalDragUpdate: (DragUpdateDetails value){
          setState(() {
            //reads the value of the vertical value
            double delta = value.delta.dx;
            posX += delta;
          });
        },
        child: Stack (
          children: <Widget>[
            Positioned(
              left: posX,
              top: posY,
              child: Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  color: Colors.red
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColorLight,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text("Taps $numTap - Double Taps: $numDoubleTaps -Long Presses: $numLongPress",
          style: Theme.of(context).textTheme.title,),

        ),

      ),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void center(BuildContext context){

    //media query gives you the size and the orientation of the app
    posX = (MediaQuery.of(context)).size.width /2 - boxSize/2;
    posY = (MediaQuery.of(context)).size.height /2 - boxSize/2 -30.0;
    setState(() {
      posY = posY;
      posX = posX;
    });
  }



}
