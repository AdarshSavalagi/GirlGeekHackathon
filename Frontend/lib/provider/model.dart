// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:hackathon/widgets/Todo.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // class Todo {
// //   final String title;
// //   int position;

// //   Todo(this.position, this.title);
// // }

// // class TodoModel extends ChangeNotifier {
// //   List<Todo> _todos = [];
// // TodoModel() {
// //     _loadData(); // Call the function to load data during initialization
// //   }

// //    Future<void> _loadData() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final todoList = prefs.getStringList('todoList');

// //     if (todoList != null) {
// //       _todos = todoList
// //           .map((todoString) => Todo.fromJson(todoString))
// //           .toList();
// //     }

// //     notifyListeners();
// //   }

// //   List<Todo> get todos => _todos;

// //   void addTodo(String todo) {
// //     _todos.add(Todo(0, todo));
// //     notifyListeners();
// //   }

// //   void changeTodoPosition(int index) {
// //     _todos[index].position++;
// //     notifyListeners();
// //   }

// //   void removeTodo(int index) {
// //     _todos.removeAt(index);
// //     notifyListeners();
// //   }
// // }

// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Todo {
//   final String title;
//   int position;

//   Todo(this.position, this.title);

//   // JSON serialization
//   factory Todo.fromJson(Map<String, dynamic> json) {
//     return Todo(json['position'] as int, json['title'] as String);
//   }

//   // Convert Todo object to a JSON object
//   Map<String, dynamic> toJson() {
//     return {
//       'position': position,
//       'title': title,
//     };
//   }
// }

// class TodoModel extends ChangeNotifier {
//   List<Todo> _todos = [];

//   TodoModel() {
//     _loadData(); // Call the function to load data during initialization
//   }

//  Future<void> _loadData() async {
//   final prefs = await SharedPreferences.getInstance();
//   final todoList = prefs.getStringList('todoList');

//   if (todoList != null) {
//     _todos = todoList.map((todoString) {
//       // Attempt to decode JSON from the stored string
//       Map<String, dynamic> decodedMap = Map<String, dynamic>.from(
//         // Using try-catch block to handle potential JSON decoding errors
//         () {
//           try {
//             // Assuming the stored string is valid JSON format, parse it
//             return jsonDecode(todoString);
//           } catch (e) {
//             // If parsing fails, return an empty map
//             return {};
//           }
//         }(),
//       );
//       return Todo.fromJson(decodedMap); // Creating Todo objects from decoded JSON
//     }).toList();
//   }

//   notifyListeners();
// }

//   List<Todo> get todos => _todos;

// void addTodo(String todo) {
//   _todos.add(Todo(0, todo));
//   notifyListeners();
//   saveData(); // Save data after adding a new todo
// }

// void changeTodoPosition(int index) {
//   _todos[index].position++;
//   notifyListeners();
//   saveData(); // Save data after changing a todo's position
// }

// void removeTodo(int index) {
//   _todos.removeAt(index);
//   notifyListeners();
//   saveData(); // Save data after removing a todo
// }

//     Future<void> saveData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final todoStrings = _todos.map((todo) => jsonEncode(todo.toJson())).toList();
//     prefs.setStringList('todoList', todoStrings);
//   }
// }

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  final String title;
  int position;

  Todo(this.position, this.title);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['position'] as int, json['title'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'title': title,
    };
  }
}

class TodoModel extends ChangeNotifier {
  List<Todo> _todos = [];

  TodoModel() {
    _initData();
  }
  List<Todo> get todos => _todos;

  Future<void> _initData() async {
    await _loadData(); // Load data asynchronously
    notifyListeners();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final todoList = prefs.getStringList('todoList');

    if (todoList != null) {
      _todos = todoList.map((todoString) {
        final Map<String, dynamic> todoJson = Map<String, dynamic>.from(
          () {
            try {
              return jsonDecode(todoString);
            } catch (_) {
              return {};
            }
          }(),
        );
        return Todo.fromJson(todoJson);
      }).toList();
    }
  }

  void addTodo(String todo) {
    _todos.add(Todo(0, todo));
    notifyListeners();
    saveData(); // Save data after adding a new todo
  }

  void changeTodoPosition(int index) {
    _todos[index].position++;
    notifyListeners();
    saveData(); // Save data after changing a todo's position
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
    saveData(); // Save data after removing a todo
  }

  // Save data method
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final todoStrings =
        _todos.map((todo) => jsonEncode(todo.toJson())).toList();
    prefs.setStringList('todoList', todoStrings);
  }
}

