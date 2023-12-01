import 'package:flutter/material.dart';
import 'package:hackathon_frontend/widgets/CompletedCard.dart';
import 'package:provider/provider.dart';

import '../provider/model.dart';

class CompletedContainer extends StatefulWidget {
  const CompletedContainer({super.key});

  @override
  State<CompletedContainer> createState() => _CompletedContainerState();
}

class _CompletedContainerState extends State<CompletedContainer> {
  final List myTodos = [
    'Complted Card 1',
    'Complted Card 2',
    'Complted Card 3',
    'Complted Card 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(builder: (context, Todo, _) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.195,
        height: MediaQuery.of(context).size.height * 0.50,
        child: Card(
            color: const Color.fromARGB(255, 79, 59, 51),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(
                        color: Color.fromARGB(255, 254, 100, 0),
                        Icons.fact_check,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Completed',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (final tile in Todo.todos)
                        tile.position == 2
                            ? CompletedCard(
                                key: ValueKey(tile),
                                title: tile.title,
                                index: Todo.todos.indexOf(tile),
                              )
                            : Container()
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }
}
