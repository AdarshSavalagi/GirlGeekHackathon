import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_frontend/utils/constants.dart';
import 'package:hackathon_frontend/widgets/CardBox.dart';
import 'package:hackathon_frontend/widgets/Completed.dart';
import 'package:hackathon_frontend/widgets/OngoingContainer.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../widgets/WorkflowContainer.dart';
import '../widgets/Todo.dart';
import '../widgets/customcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoaded = false;
  Map dashData = {"projects": []};
  @override
  void initState() {
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('access') ?? '';
      if (data == '') {
        Navigator.pushNamed(context, '/login');
      }

      http.Response response = await http.get(Uri.parse(getDashboardData),
          headers: {'Authorization': 'Bearer $data'});
      // print(response.body);
      if (response.statusCode != 200) {
        Navigator.pushNamed(context, '/login');
      }
      setState(() {
        dashData = jsonDecode(response.body);
        _isLoaded = true;
      });
      // print('this ${dashData['workflow_stats'][_index]}');
    }();
    super.initState();
  }

  int _index = 0;
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Container(),
          title: const Text("Dashboard"),
          backgroundColor: Color.fromARGB(255, 254, 100, 0)),
      backgroundColor: Color.fromARGB(255, 41, 34, 29),
      body: _isLoaded
          ? Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Expanded(
                      child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Projects',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      for (var i = 0; i < dashData['projects'].length; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = i;
                            });
                          },
                          child: CustomCard(
                            id: dashData['projects'][i]['id'] ?? 0,
                            title: dashData['projects'][i]['title'] ?? '',
                          ),
                        ),
                    ],
                  )),
                ),
                const VerticalDivider(
                  color: Colors.white60,
                  thickness: 0.2,
                ),
                dashData['projects'].length == 0
                    ? Container(
                          width: MediaQuery.of(context).size.width * 0.78,
                      child: Column(
                        children: [
                          Lottie.asset('static/vector3.json',width: 600),
                          Text(
                            'Nothing to show here...',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20),
                          )
                        ],
                      ),
                    )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: ListView(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  dashData['projects'][_index]['title'],
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Deadline: ${dashData['projects'][_index]['deadline']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Progress',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 254, 100, 0)),
                                  value: dashData['projects'][_index]
                                                  ['get_status'] /
                                              100 ==
                                          0
                                      ? 0.01
                                      : dashData['projects'][_index]
                                              ['get_status'] /
                                          100, // Example value
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  child: Row(
                                    children: [
                                      Icon(
                                        color: Color.fromARGB(255, 254, 100, 0),
                                        Icons.copy,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        'Copy Git Repo',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    _copyToClipboard(dashData['projects']
                                        [_index]['git_repo']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Text copied to clipboard'),
                                      ),
                                    );
                                  }),
                              TextButton(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        color: Color.fromARGB(255, 254, 100, 0),
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        'Show Description',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isOpen = !isOpen;
                                    });
                                  })
                            ],
                          ),
                          SizedBox(
                            height: 8.5,
                          ),
                          isOpen
                              ? card_box(
                                  title: 'Description',
                                  icon: Icons.description,
                                  data: [
                                    dashData['projects'][_index]['purpose']
                                  ],
                                )
                              : Container(),
                          isOpen
                              ? card_box(
                                  title: 'Purpose',
                                  icon: Icons.apartment,
                                  data: [
                                    dashData['projects'][_index]['purpose']
                                  ],
                                )
                              : Container(),
                          isOpen
                              ? SizedBox(
                                  height: 6,
                                )
                              : Container(),
                          const Divider(
                            height: 0.5,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              WorkflowContainer(
                                  str: (dashData['workflow'] as List)
                                      .map((item) => item as String)
                                      .toList(),
                                  stats: dashData['workflow_stats'][_index]),
                              Todo(),
                              OngoingContainer(),
                              CompletedContainer()
                            ],
                          ),
                        ]),
                      ),
              ],
            )
          : Center(
              child: CupertinoActivityIndicator(
              color: Colors.white,
            )),
    );
  }

  void _copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((value) => print('Text copied'));
  }
}
