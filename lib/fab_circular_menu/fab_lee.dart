import 'package:flutter/material.dart';

class CustomFabLee extends StatefulWidget {
  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFabLee> with SingleTickerProviderStateMixin{

  double getRadiansFromDegree(double degree){

    double unitRadian = 57.295779513;

    return degree / unitRadian;
  }

  AnimationController animationController;
  Animation d1egreeTranslation,d2egreeTranslation,d3egreeTranslation,d4egreeTranslation,d5egreeTranslation;
  Animation rotationAnimation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500)
    );
    d1egreeTranslation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0.0,end: 1.1),weight: 80),
      TweenSequenceItem<double>(tween: Tween(begin: 1.1,end: 1.0),weight: 20),
    ]).animate(animationController);
    d2egreeTranslation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0.0,end: 1.2),weight: 60),
      TweenSequenceItem<double>(tween: Tween(begin: 1.2,end: 1.0),weight: 40),
    ]).animate(animationController);
    d3egreeTranslation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0.0,end: 1.3),weight: 40),
      TweenSequenceItem<double>(tween: Tween(begin: 1.3,end: 1.0),weight: 60),
    ]).animate(animationController);
    d4egreeTranslation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0.0,end: 1.4),weight: 20),
      TweenSequenceItem<double>(tween: Tween(begin: 1.4,end: 1.0),weight: 60),
    ]).animate(animationController);
    d5egreeTranslation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0.0,end: 1.15),weight: 70),
      TweenSequenceItem<double>(tween: Tween(begin: 1.15,end: 1.0),weight: 30),
    ]).animate(animationController);
    rotationAnimation = Tween(
      begin: 0.0,
      end: 180.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    final double btnSize = 70;

    return Stack(
      children: <Widget>[

        //Add note / Diary button
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(180),d1egreeTranslation.value * 100),
          child: Container(
            padding: EdgeInsets.all(100),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(d1egreeTranslation.value),
              child: CircularButton(
                height: btnSize,
                width: btnSize,
                color: Colors.red,
                icon: Icon(
                  Icons.note_add,
                  color: Colors.white,
                ),

                onClick: () {
                  Navigator.pushNamed(context, '/diaryAdd');
                },

              ),
            ),
          ),
        ),

        //View note / View Diary button
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(225),d5egreeTranslation.value * 100),
          child: Container(
            padding: EdgeInsets.all(100),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(d1egreeTranslation.value),
              child: CircularButton(
                height: btnSize,
                width: btnSize,
                color: Colors.red,
                icon: Icon(
                  Icons.event_note,
                  color: Colors.white,
                ),
                onClick: () {
                  Navigator.pushNamed(context, '/diaryView');
                },
              ),
            ),
          ),
        ),

        // list to-do
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(270),d2egreeTranslation.value * 100),
          child: Container(
            padding: EdgeInsets.all(100),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(d2egreeTranslation.value),
              child: CircularButton(
                height: btnSize,
                width: btnSize,
                color: Colors.red,
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                onClick: () {
                  Navigator.pushNamed(context, '/todo');
                },
              ),
            ),
          ),
        ),

        //Travelling Cost button
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(315),d2egreeTranslation.value * 100),
          child:Container(
            padding: EdgeInsets.all(100),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(d4egreeTranslation.value),
              child: CircularButton(
                height: btnSize,
                width: btnSize,
                color: Colors.red,
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.white,
                ),
                onClick: () {
                  Navigator.pushNamed(context, '/travel');
                },
              ),
            ),
          ),
        ),

        //temporary notepad
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(360),d3egreeTranslation.value * 100),
          child: Container(
            padding: EdgeInsets.all(100),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(d3egreeTranslation.value),
              child: CircularButton(
                height: btnSize,
                width: btnSize,
                color: Colors.red,
                icon: Icon(
                  Icons.note,
                  color: Colors.white,
                ),
                onClick: () {
                  Navigator.pushNamed(context, '/temp');
                },
              ),
            ),
          ),
        ),

        //Main middle Button
        Container(
          padding: EdgeInsets.all(100),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
            child: CircularButton(
              height: btnSize,
              width: btnSize,
              color: Colors.red,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onClick: () {
                if(animationController.isCompleted) {
                  animationController.reverse();
                }
                else {
                  animationController.forward();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

class CircularButton extends StatelessWidget {

  final double height;
  final double width;
  final Color color;
  final Icon icon;
  final String text;
  final Function onClick;

  CircularButton({this.text,this.height,this.width,this.icon,this.color,this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: icon,
        onPressed: onClick,
        enableFeedback: true,
      ),
    );
  }
}