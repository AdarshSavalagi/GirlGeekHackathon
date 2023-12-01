import 'package:flutter/material.dart';

class card_box extends StatelessWidget {
  const card_box({super.key, required this.title, required this.icon, required this.data});
  final String title;
  final IconData icon;
  final List<String> data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Card(
          color: Color.fromARGB(255, 79, 59, 51),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      color: Color.fromARGB(255, 254, 100, 0),
                      icon,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              discription_as(str: data,),
            ]),
          )),
    );
  }
}

class discription_as extends StatelessWidget {
  discription_as({super.key, required this.str});

  final List<String> str ;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 79, 59, 51),
      child: SizedBox(
        child: Column(
          children: str.map((strone) {
            return Row(children: [
              Text(
                "\u2022",
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ), //bullet text
              const SizedBox(
                width: 10,
              ), //space between bullet and text
              Expanded(
                child: Text(
                  strone,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.7,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ), //text
              )
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
