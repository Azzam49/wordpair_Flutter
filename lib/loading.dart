import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  


  void loadHomePage() async {

    

    Timer(Duration(seconds: 4), () {
      //pushReplacementNamed will switch to home page 
    //without making the loading page runs underneath it
    Navigator.pushReplacementNamed(
      context, 
      '/randomwords',
      arguments: {
       
      });
    });
    
  }

  @override
  void initState(){
    super.initState();
    loadHomePage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
    decoration: BoxDecoration(color: Colors.white),
    child: Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: SpinKitCubeGrid(
              color: Colors.red,
              size: 50.0,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,20.0),
            child: Text(
              "Created By Azzam",      
              style: TextStyle(
                //fontFamily: 'indieflower',
                fontSize: 28.0,
                color: Colors.redAccent[600],
                wordSpacing: 3.0,
                
              ),
              
              ),
          ),
        )
      ],
    ),
  ),
      
    );
  }
}