import 'package:flutter/material.dart';
import 'package:rest_apis_flutter/all_functions/functions.dart';
import 'package:rest_apis_flutter/all_models/models.dart';
import 'package:rest_apis_flutter/shared_pref_service.dart';

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

  Future<bool> createTodo(String title, String description) async {
    // show circle progress indicator
    setCreateState(true);

    // call the create todo function
    bool isCreated = await TodoFunctions.createNewTodo(title, description);

    // hide circle progress indicator
    setCreateState(false);

    return isCreated;
  }

  // Manage theme State
  bool isDarkTheme = false; // set as light mode initially

  // function to set Dark Theme
  void setDarkTheme(bool newValue) async {
    // set the value on shared preferences
    bool isValueSet = await AppService.storeThemeValue(newValue: newValue);

    // check if the function was successful
    if (isValueSet) {
      // set the new value
      isDarkTheme = newValue;
    }

    notifyListeners();
  }

  // get dark theme value
  void getDarkTheme() async {
    var newValue = await AppService.getThemeValue(); // information stored

    if (newValue == true) {
      isDarkTheme = true;
    } else {
      isDarkTheme = false;
    }
    notifyListeners();
  }
}
