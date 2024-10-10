// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_apis_flutter/provider.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Create New Todo",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (BuildContext context, TodoProvider provider, Widget? child) =>
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(
                    Colors.black,
                  ),
                  fixedSize: WidgetStatePropertyAll(
                    Size(
                      MediaQuery.sizeOf(context).width,
                      50,
                    ),
                  ),
                ),
                onPressed: () async {
                  bool isCreated =
                      await Provider.of<TodoProvider>(context, listen: false)
                          .createTodo(_controller.text);
                  // check if it is created
                  if (isCreated) {
                    // re-fetch todos
                    await Provider.of<TodoProvider>(context, listen: false)
                        .fetchTodos();
                    // show successful message with snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Todo Created Successfully",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        backgroundColor: Colors.black,
                      ),
                    );
                    // navigate back to previous
                    Navigator.pop(context);
                  } else {
                    // display message with snack bars
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Failed request"),
                      ),
                    );
                  }
                },
                child:
                    // show progress indicator instead of text while loading
                    provider.isTodoCreating
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Create New Todo",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
