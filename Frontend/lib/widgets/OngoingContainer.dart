import 'package:flutter/material.dart';
import 'package:hackathon_frontend/provider/model.dart';
import 'package:hackathon_frontend/widgets/Todo_card.dart';
import 'package:provider/provider.dart';

class OngoingContainer extends StatefulWidget {
  const OngoingContainer({super.key});

  @override
  State<OngoingContainer> createState() => _OngoingContainerState();
}

class _OngoingContainerState extends State<OngoingContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(builder: (context, todoModel, _) {
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
                        Icons.psychology,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Ongoing',
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
                  child: ListView(
                    children: [
                      for (final tile in todoModel.todos)
                        tile.position == 1
                            ? Todo_Card(
                                key: ValueKey(tile.title),
                                title: tile.title,
                                index: todoModel.todos.indexOf(tile),
                              )
                            : Container(
                                key: ValueKey(tile.title + 'ongoing'),
                              )
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }
}
