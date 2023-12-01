import 'package:flutter/material.dart';
import 'package:hackathon_frontend/provider/model.dart';
import 'package:provider/provider.dart';

import 'Todo_card.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(builder: (context, Todo, _) {
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
                      Icons.list,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Todo',
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
                    for (final tile in Todo.todos)
                      tile.position == 0
                          ? Todo_Card(
                              key: ValueKey(tile.title),
                              title: tile.title,
                              index: Todo.todos.indexOf(tile),
                            )
                          : Container(
                              key: ValueKey(tile.title + 'todo'),
                            )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 254, 100, 0))),
                    onPressed: () {
                      final _controller = TextEditingController();
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Add Todo',
                              style: TextStyle(
                          color: Color.fromARGB(255, 254, 100, 0),),
                            ),
                            content: TextField(
                              controller: _controller,
                            ),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 254, 100, 0),
                                  ),
                                ),
                                onPressed: () {
                                  Todo.addTodo(_controller.text);
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text(
                                  'Add Todo',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 254, 100, 0),
                                  ),
                                ),
                                onPressed: () {
                                  Todo.addTodo(_controller.text);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        "Add Todo ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      );
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final _controller = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add Todo',
            style: TextStyle(
              color: Color.fromARGB(255, 254, 100, 0),
            ),
          ),
          content: TextField(
            controller: _controller,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add Todo'),
              onPressed: () {
                print('value: ${_controller.text}');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
