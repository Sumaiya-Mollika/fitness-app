import 'dart:convert';

import 'package:fitnessapp/model.dart';
import 'package:fitnessapp/pagetwo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Exercises> exercises = [];
  final String apiurl =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  fetchHomeData() async {
    final responce = await http.get(Uri.parse(apiurl));

    var data = responce.body;
    var DecodeData = jsonDecode(data);

    for (var singleData in DecodeData["exercises"]) {
      Exercises model = Exercises(
          id: singleData["id"],
          title: singleData["title"],
          thumbnail: singleData["thumbnail"],
          gif: singleData["gif"],
          seconds: singleData["seconds"]);
      setState(() {
        exercises.add(model);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageTwo(
                                  exercises: exercises[index],
                                  all: exercises,
                                )));
                  },
                  child: Container(
                    child: Image.network("${exercises[index].thumbnail}"),
                  ),
                );
              }),
        ));
  }
}
