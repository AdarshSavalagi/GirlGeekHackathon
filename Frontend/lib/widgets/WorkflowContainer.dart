import 'package:flutter/material.dart';
import 'package:hackathon_frontend/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WorkflowContainer extends StatefulWidget {
  const WorkflowContainer({super.key, required this.str, required this.stats});
  final List str;
  final Map stats;
  @override
  State<WorkflowContainer> createState() => _ContainerBoxState();
}

class _ContainerBoxState extends State<WorkflowContainer> {
  List<bool> checkboxValues = List.generate(10, (index) => false);
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      for (int i = 0; i < widget.str.length; i++) {
        checkboxValues[i] =
            widget.stats['progress'] * widget.str.length / 100 > i;
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.195,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Card(
          color: Color.fromARGB(255, 79, 59, 51),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      color: Color.fromARGB(255, 254, 100, 0),
                      Icons.rebase_edit,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Workflow',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.str.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(widget.stats['progress'].runtimeType);
                    // return WorkflowCard(
                    //   checkboxValues[index],
                    //   title: widget.str[index],
                    // );
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.str[index],
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 254, 100, 0),
                                )),
                            Checkbox(
                              value: checkboxValues[index],
                              onChanged: (bool? val) {
                                setState(() {
                                  checkboxValues[index] = val!;
                                });
                              },
                              fillColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 254, 100, 0)),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 100, 0))
                  ),
                    onPressed: () async {
                      print('${widget.stats['project']} and $checkboxValues');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final data = prefs.getString('access') ?? '';
                      if (data == '') {
                        Navigator.pushNamed(context, '/login');
                      }
                      var progress = checkboxValues
                              .where((element) => element == true)
                              .length /
                          widget.str.length *
                          100;
                      http.Response response =
                          await http.post(Uri.parse(getDashboardData), body: {
                        "type": "2",
                        "pid": '${widget.stats['project']}',
                        "progress": '${progress.round()}'
                      }, headers: {
                        'Authorization': 'Bearer $data'
                      });
                      if (response.statusCode != 200) {
                        Navigator.pushNamed(context, '/login');
                      }
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('updated'),
                      ));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
