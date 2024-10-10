import 'package:flutter/material.dart';
import 'package:rest_apis_flutter/functions.dart';
import 'package:rest_apis_flutter/models.dart';

class TodoProvider extends ChangeNotifier {
  // variable to represent loading state
  bool isTodoFetching = false;

  // function to update this state
  void setFetchState(bool isFetching) {
    isTodoFetching = isFetching;

    notifyListeners();
  }

  // variable for the todo List
  List<Todo> todos = [];

  // function to fetch todo list
  Future<void> fetchTodos() async {
    setFetchState(true); // show the circleprogressindicator

    // call the function
    todos = await TodoFunctions.fetchTodos();

    notifyListeners();

    setFetchState(false); // hide the circleprogressindicator
  }

  // variable to represent loading state
  bool isTodoCreating = false;

  // function to update loading state
  void setCreateState(bool isCreating) {
    isTodoCreating = isCreating;
    notifyListeners();
  }

  Future<bool> createTodo(String title) async {
    // show circle progress indicator
    setCreateState(true);

    // call the create todo function
    bool isCreated = await TodoFunctions.createNewTodo(title);

    // hide circle progress indicator
    setCreateState(false);

    return isCreated;
  }
}
