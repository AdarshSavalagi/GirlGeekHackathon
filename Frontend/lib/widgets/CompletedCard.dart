import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/model.dart';

class CompletedCard extends StatelessWidget {
  const CompletedCard({super.key, required this.title, required this.index});
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(builder: (context, todoModel, _) {
      return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 254, 100, 0))),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 254, 100, 0),
                ),
                onPressed: () {
                  todoModel.removeTodo(index);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
