import 'dart:async';

import 'package:fitnessapp/model.dart';
import 'package:flutter/material.dart';

class PageThree extends StatefulWidget {
  PageThree({Key? key, this.exercises, this.seconds}) : super(key: key);
  Exercises? exercises;
  int? seconds;

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  late Timer timer;
  int initSecond = 0;
  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.seconds) {
        timer.cancel();

        Future.delayed(Duration(seconds: 4), () {
          Navigator.pop(context);
        });
      }
      setState(() {
        initSecond = timer.tick;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.network(
              "${widget.exercises!.gif}",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 20,
              child: Text("$initSecond / ${widget.seconds}"),
            )
          ],
        ),
      ),
    );
  }
}
