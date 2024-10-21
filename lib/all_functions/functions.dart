import 'dart:convert';
import 'dart:developer';

import 'package:rest_apis_flutter/all_models/models.dart';
import 'package:http/http.dart' as http;

class TodoFunctions {
  // fetching function
  static Future<List<Todo>> fetchTodos() async {
    // create todoList
    List<Todo> todos = [];
    // get your Url
    String url =
        "https://6703fec0ab8a8f8927328e61.mockapi.io/api/v1/todo"; // endpoint

    try {
      // send api request
      final apiResponse = await http.get(
        Uri.parse(url), // url in Uri format
      );

      if (apiResponse.statusCode == 200) {
        // decode the response from string to Dart readable object
        final List todoList = jsonDecode(apiResponse.body);

        // for-loop
        for (Map<String, dynamic> todo in todoList) {
          // todo is a Map<String, dynamic>
          final thisTodo = Todo.fromJson(
              todo); // using factory constructor to create a Todo.

          todos.add(thisTodo);
        }
      }
    } catch (e) {
      log(e.toString()); // catch error
    }
    return todos;
  }

  // create new Todo
  static Future<bool> createNewTodo(String title, String description) async {
    // endpoint
    String url = "https://6703fec0ab8a8f8927328e61.mockapi.io/api/v1/todo";

    // headers
    Map<String, String> headers = {"Content-Type": "application/json"};

    // body
    Map<String, dynamic> requestBody = {
      "title": title,
      "completed": false,
      "description": description,
    };

    try {
      // send the post request
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
