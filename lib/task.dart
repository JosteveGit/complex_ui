import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class GuitarDetails extends StatefulWidget {
  @override
  _GuitarDetailsState createState() => _GuitarDetailsState();
}

class _GuitarDetailsState extends State<GuitarDetails>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double maxSlide = 600;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  void toggle() =>
      _controller.isDismissed ? _controller.forward() : _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onDragUpdate(DragUpdateDetails details) {
    double delta = details.primaryDelta / maxSlide;
    _controller.value += -delta;
  }

  onDragEnd(DragEndDetails details) {
    if (_controller.value < 0.5) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    maxSlide = MediaQuery.of(context).size.height - 117;
    var details = Container(
      color: Colors.blueGrey[400],
      width: maxSlide,
      height: double.maxFinite,
      padding: EdgeInsets.all(40),
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Fender\nAmerican\nElite Strat",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "The American Acoustasonic™ Stratocaster® continues to embody the spirit of purposeful innovation that drives Fender guitars. The power of the Fender and Fishman®-designed Acoustic Engine is sure to deliver true inspiration. From acoustic shapeshifting to electric rhythm tones.",
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 16
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "images/playing_guit.jpg",
                    width: double.maxFinite,
                    scale: 1,
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 80
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    var myChild = Container(
      color: Colors.blueGrey[300],
      height: double.maxFinite,
      child: RotatedBox(
        quarterTurns: 1,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 80,),
              Row(
                children: <Widget>[
                  SizedBox(width: 30,),
                  FractionalTranslation(
                    translation: Offset(0.17,-0.1),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        "FENDER",
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[700]
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 50,
                    color: Color(0xff00FFFFFF),
                    child: Image.asset(
                      "images/guit.png",
                      height:380,
                      fit: BoxFit.contain
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: 40,),
                  Expanded(
                    child: Text(
                      "Fender\nAmerican\nElite Strat",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(width: 50,),
                  Row(
                    children: <Widget>[
                      Text(
                        "SPEC",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down
                      )
                    ],
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: GestureDetector(
        onTap: toggle,
        onVerticalDragUpdate: onDragUpdate,
        onVerticalDragEnd: onDragEnd,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Transform.translate(
                    offset: Offset(0, maxSlide * (1- _controller.value)),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                        ..rotateY(pi / 2 * (1 - _controller.value)),
                        child: details,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -maxSlide* _controller.value),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-pi / 2 * _controller.value),
                      child: myChild,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 50,
                  child: Text(
                    "PRODUCT DETAILS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Positioned(
                  top: 38,
                  left: 10,
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  )
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
