import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/model.dart';

class Todo_Card extends StatefulWidget {
  const Todo_Card({super.key, required this.title, required this.index});
  final String title;
  final int index;
  @override
  State<Todo_Card> createState() => _Todo_CardState();
}

class _Todo_CardState extends State<Todo_Card> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(builder: (context, todoModel, _) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 254, 100, 0),
                    fontWeight: FontWeight.w400,
                  )),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Color.fromARGB(255, 254, 100, 0),
                ),
                onPressed: () {
                  todoModel.changeTodoPosition(widget.index);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
