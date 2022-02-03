import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:dict_app/services/http_service.dart';
import 'result_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String Url = "";
  String meaning = "";
  var data;
  var word;
  var origin;
  var Audio;
  var example;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text(
              "Dictionary App",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrangeAccent[400],
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            Text(
              "Search any word you want quickly",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[100],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: (value) {
                Url = "https://api.dictionaryapi.dev/api/v2/entries/en/" +
                    value.toString();
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Search the word",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent[400],
                ),
                onPressed: () async {
                  data = await fetchData(Url);
                  bool internet_check =
                      await InternetConnectionChecker().hasConnection;
                  if (data == null) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.BOTTOMSLIDE,
                      desc: 'Please enter the correct word',
                      body: Column(
                        children: [
                          Text(
                            "ERROR",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Please check the spelling",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      // btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  } else if (internet_check == false) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Dialog Title',
                      desc: 'Dialog description here.............',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  } else {
                    setState(() {
                      // title = data['title']; title
                      meaning = data[0]['meanings'][0]['definitions'][0][
                          'definition']; //0.meanings[0].definitions[0].definition
                      word = data[0]['word']; //0.word
                      Audio = data[0]['phonetics'][0]
                          ['audio']; //0.phonetics[0].audio
                      origin = data[0]['origin']; //0.origin
                      example = data[0]['meanings'][0]['definitions'][0]
                          ['example']; //0.meanings[0].definitions[0].example
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => result(
                          meaning: meaning,
                          word: word,
                          audio: Audio,
                          origin: origin,
                          example: example,
                        ),
                      ),
                    );
                  }
                  print(data);
                  print(Url);
                  print(meaning);
                  print(Audio);
                  print(origin);
                  print(example);
                  print(internet_check);
                },
                child: Text(
                  "SEARCH",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
