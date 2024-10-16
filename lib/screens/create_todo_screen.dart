// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_apis_flutter/all_functions/validation_functions.dart';
import 'package:rest_apis_flutter/provider.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // title field

                TextFormField(
                  controller: _titleController, // controller
                  cursorColor: Colors.black, // cursor color

                  validator: ValidationFunctions.validateTitle, // validator
                  decoration: InputDecoration(
                    // normal border
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    // focused border
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    // hintText
                    hintText: "e.g Get breakfast",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // description field

                TextFormField(
                  controller: _descriptionController,
                  cursorColor: Colors.black, // cursor color
                  // textInputAction: TextInputAction.newline, // keynoard icon

                  validator:
                      ValidationFunctions.validateDescription, //  validator
                  decoration: InputDecoration(
                    // normal border
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    // focused border
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    // hintText
                    hintText: "e.g Breakfast for Mom",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // spacer
                const Spacer(),

                // button
                ElevatedButton(
                  style: ButtonStyle(
                    // bg color
                    backgroundColor: const WidgetStatePropertyAll(
                      Colors.black,
                    ),

                    // shape
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    // size
                    fixedSize: WidgetStatePropertyAll(
                      Size(
                        MediaQuery.sizeOf(context).width,
                        50,
                      ),
                    ),
                  ),

                  // function
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // call the create Todo Provider Function
                      bool isCreated = await Provider.of<TodoProvider>(context,
                              listen: false)
                          .createTodo(
                        _titleController.text,
                        _descriptionController.text,
                      );
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
      ),
    );
  }
}
