import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class result extends StatefulWidget {
  final word;
  final meaning;
  final audio;
  final origin;
  final example;
  const result({
    Key? key,
    required this.meaning,
    required this.word,
    required this.audio,
    required this.origin,
    required this.example,
  }) : super(key: key);

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  //...
  AudioPlayer player = new AudioPlayer();

//...

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        print("CLicked the icon");
                        await player.setUrl('${widget.audio}');
                        player.play();
                      },
                      icon: Icon(
                        Icons.volume_up,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    capitalize("${widget.word}".toUpperCase()),
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "DEFINITION : ",
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueGrey[500],
                    ),
                    child: Text(
                      capitalize("${widget.meaning}"),
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "ORIGIN : ",
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueGrey[500],
                    ),
                    child: Text(
                      capitalize("${widget.origin}"),
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "EXAMPLE : ",
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueGrey[500],
                    ),
                    child: Text(
                      capitalize(
                        widget.example != null
                            ? "${widget.example}"
                            : "Not Found",
                      ),
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
