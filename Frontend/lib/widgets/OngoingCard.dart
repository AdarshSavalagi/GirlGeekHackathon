import 'package:flutter/material.dart';
import 'package:hackathon_frontend/provider/model.dart';
import 'package:provider/provider.dart';

class OngoingCard extends StatelessWidget {
  const OngoingCard({super.key, required this.title, required this.index});
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(builder: (context, todoModel, _) {
      return Card(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      todoModel.changeTodoPosition(index);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
